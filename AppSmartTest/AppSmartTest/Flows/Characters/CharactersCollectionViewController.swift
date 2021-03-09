//
//  CharactersCollectionViewController.swift
//  AppSmartTest
//
//  Created by Vitaly Khomatov on 01.03.2021.
//

import UIKit
import Kingfisher

class CharactersCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate, UISearchResultsUpdating {
    
    private let model = CharactersCollectionViewModel()
    var network = NetworkMonitor()
    private var searchController = UISearchController(searchResultsController: nil)
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupCollectionView()
        setupSearchBar()
        startNetworkMonitor()
        self.loadData(limit: 10, offset: 0, readRealm: true)

    }
    
   
    // MARK: - NetworkMonitor
    func startNetworkMonitor() {
        guard let navcontroller = self.navigationController?.view else { return }
        if !network.getNetworkStatus() {
            DispatchQueue.main.async {
                let errorMessage = ErrorMessage(view: navcontroller)
                errorMessage.showError(reverse: true, message: "Offline Mode", delay: 3.0)
            }
        }
        
     //   #if targetEnvironment(simulator)
        // code to run if running on simulator
    //    #else
        network.monitor.pathUpdateHandler = { path in
            if path.status == .satisfied  {
                DispatchQueue.main.async {
                    let errorMessage = ErrorMessage(view: navcontroller)
                    errorMessage.showError(reverse: true, message: "Online Mode", delay: 3.0)
                    if self.model.charactersSJ.count < 10 {
                        self.loadData(limit: 10, offset: 0)
                    } else { self.collectionView.reloadData() }
                }
            } else if path.status == .unsatisfied  {
                DispatchQueue.main.async {
                    let errorMessage = ErrorMessage(view: navcontroller)
                    errorMessage.showError(reverse: true, message: "Offline Mode", delay: 3.0)
                }
            }
        }
     //   #endif
    }
    
    
    // MARK: - Setup Views
    private func setupCollectionView() {
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout  else { return }
        flowLayout.sectionInset = UIEdgeInsets(top: 5, left: 3, bottom: 5, right: 3)
        flowLayout.scrollDirection = .vertical
        collectionView.setCollectionViewLayout(flowLayout, animated: true)
        collectionView.backgroundColor = UIColor.clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CharacterCollectionViewCell.self, forCellWithReuseIdentifier: "characterCell")
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.keyboardDismissMode = .onDrag
        view.addSubview(collectionView)
    }
    
    private func setupSearchBar() {
        navigationItem.searchController = self.searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.definesPresentationContext = true
    }
    
    private func setupNavBar() {
        if #available(iOS 13.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationItem.largeTitleDisplayMode =  .automatic
            navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
        } else {
            navigationItem.largeTitleDisplayMode = .never
            navigationController?.navigationBar.isTranslucent = false
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
        }
        navigationItem.title = "Marvell Heroes"
        navigationController?.definesPresentationContext = true
    }
    
    
    // MARK: - SerchBar
    func searchBar(_ frendsSearch: UISearchBar, textDidChange searchText: String) {
        updateSearchResults(for: self.searchController)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            if let text = searchField.text, model.searchText != text {
                model.searchText = text
                model.searchCharactersSJ.removeAll()
                collectionView.reloadData()
                if text.count < 1 {
                    searchController.resignFirstResponder()
                    model.search = false
                } else if !model.isLoading  {
                    loadData(limit: 10, offset: 0, name: text)
                    model.search = true
                }
            }
        }
    }
    
    // MARK: - LoadData
    private func loadData(limit: Int, offset: Int, name: String? = nil, readRealm: Bool? = nil) {
        self.model.isLoading.toggle()
        let spinner = SpinnerView(frame: CGRect(x: self.collectionView.frame.midX-55, y: self.collectionView.frame.midY-25, width: 110, height: 50))
        view.addSubview(spinner)
        spinner.start()
        self.collectionView.layer.opacity = 0.3
        self.collectionView.isUserInteractionEnabled = false
        
        self.model.loadCharactersSJ(limit: limit, offset: offset, name: name) { [weak self] (message) in
            guard let self = self else { return }
            if let error = message {
                DispatchQueue.main.async {
                    self.collectionView.layer.opacity = 1
                    self.model.isLoading.toggle()
                    self.collectionView.isUserInteractionEnabled = true
                    spinner.stop()
                    spinner.removeFromSuperview()

                    if let readRealm = readRealm, readRealm == true {
                        if let charactersSJ = try? RealmService.get(CharacterSJ.self) {
                            self.model.charactersSJ  = charactersSJ
                            self.collectionView.reloadData()
                            #if DEBUG
                            print("Characters load from Realm")
                            #endif
                        }
                    }
                    
                    if let name = name {
                        if self.model.charactersSJ.count > 0  {
                            self.model.searchCharactersSJ =  self.model.charactersSJ.filter( { $0.name?.prefix(name.count).description == name } )
                            self.model.search = true
                            self.collectionView.reloadData()
                        } else {
                            guard let navcontroller = self.navigationController?.view else { return }
                            let errorMessage = ErrorMessage(view: navcontroller)
                            errorMessage.showError(reverse: true, message: error, delay: 3.0)
                        }
                    } else {
                        guard let navcontroller = self.navigationController?.view else { return }
                        let errorMessage = ErrorMessage(view: navcontroller)
                        errorMessage.showError(reverse: true, message: error, delay: 3.0)
                    }
                    
                }
            } else {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    spinner.stop()
                    spinner.removeFromSuperview()
                    self.collectionView.layer.opacity = 1
                    self.model.isLoading.toggle()
                    self.collectionView.isUserInteractionEnabled = true
                    self.collectionView.reloadData()
                    
                }
            }
        }
    }
    
    
    //MARK: - CollectionView
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if model.search {
            return model.searchCharactersSJ.count
        }  else {
            return model.charactersSJ.count
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "characterCell", for: indexPath) as? CharacterCollectionViewCell else { return UICollectionViewCell() }
        if model.search {
            if indexPath.row < model.searchCharactersSJ.count {
                
                cell.name.text = model.searchCharactersSJ[indexPath.row].name
                cell.info.text = model.searchCharactersSJ[indexPath.row].descriptionSJ
                
                if let url = model.createURL(fileExtension: model.searchCharactersSJ[indexPath.row].fileExtension, path: model.searchCharactersSJ[indexPath.row].path) {
                    cell.avatar.kf.setImage(with: url)
                } else { cell.avatar.image = UIImage(named: "noimage") }
            }
            
        }  else {
            if indexPath.row < model.charactersSJ.count {
                
                cell.name.text = model.charactersSJ[indexPath.row].name
                cell.info.text = model.charactersSJ[indexPath.row].descriptionSJ
                
                if let url = model.createURL(fileExtension: model.charactersSJ[indexPath.row].fileExtension, path: model.charactersSJ[indexPath.row].path) {
                    cell.avatar.kf.setImage(with: url)
                } else { cell.avatar.image = UIImage(named: "noimage") }
            }
            
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let columns: CGFloat = 2
        let spacing: CGFloat = 5
        let totalHorizontalSpising = (columns - 1) * spacing
        let itemWeight = (collectionView.bounds.width - totalHorizontalSpising - 6) / columns
        let itemSize = CGSize(width: itemWeight, height: itemWeight * 1.2)
        return itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewController = CharacterDetailViewController()
        if model.search {
            viewController.model.characterSJ = self.model.searchCharactersSJ[indexPath.row]
        }  else {
            viewController.model.characterSJ = self.model.charactersSJ[indexPath.row]
        }
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if self.model.isLoading == false {
            if !model.search {
                if (indexPath.row + 1 == model.charactersSJ.count) {
                    loadData(limit: 10, offset: model.charactersSJ.count)
                }
            } else {
                if (indexPath.row + 1 == model.searchCharactersSJ.count) && (model.searchCharactersSJ.count < model.searchTotal) {
                    print(model.searchCharactersSJ.count)
                    loadData(limit: 10, offset: model.searchCharactersSJ.count, name: model.searchText)
                }
            }
        } else {
            #if DEBUG
            print("Loading Process")
            #endif
        }
    }
    
}
