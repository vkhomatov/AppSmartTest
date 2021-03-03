//
//  CharactersCollectionViewController.swift
//  AppSmartTest
//
//  Created by Vitaly Khomatov on 01.03.2021.
//

import UIKit
import Kingfisher
import RealmSwift

class CharactersCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate, UISearchResultsUpdating {
    
    private var searchController =  UISearchController(searchResultsController: nil)
    private var model = CharactersCollectionViewModel()
    private var spinner = SpinnerView()

    
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

        
       DispatchQueue.main.async {
        
        self.spinner = SpinnerView(frame: CGRect(x: 0, y: 0, width: 110, height: 50))
        self.spinner.center = self.view.center
        self.collectionView.addSubview(self.spinner)
        self.spinner.start()
        
            self.model.loadCharacters(limit: 10, offset: 0) { [weak self] (message) in
                guard let self = self else { return }
                if let error = message {
                    DispatchQueue.main.async {
                        print(error)
                        //let errorMessage = ErrorMessage(view: self.view)
                        //errorMessage.showError(reverse: true, message: error, delay: 3.0)
                    }
                } else {
                    DispatchQueue.main.async { [weak self] in
                        guard let self = self else { return }
                        self.collectionView.reloadData()
                        self.spinner.removeFromSuperview()
                        self.spinner.stop()
                        
                    }
                }
            }
       }
    }
    
    
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
        view.addSubview(collectionView)
    }
    
    
    private func setupSearchBar() {
        
        self.navigationItem.searchController = self.searchController
        self.searchController.searchResultsUpdater = self
        self.searchController.searchBar.delegate = self
        //  self.definesPresentationContext = true
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.searchController.obscuresBackgroundDuringPresentation = false
        
        
       // navigationController?.navigationBar.barStyle = .black
    //    navigationController?.navigationBar.isTranslucent = true
   //     navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.red]
      //  self.navigationController!.navigationBar.tintColor = #colorLiteral(red: 1, green: 0.99997437, blue: 0.9999912977, alpha: 1)
        //self.searchController.searchBar.frame = CGRect(x: 0, y: 0, width: view.frame.width-10, height: 0)
        
        
    //    searchController.searchBar.scopeButtonTitles = ["Option 1", "Option 2"]

        // Make sure the scope bar is always showing, even when not actively searching
 //       searchController.searchBar.showsScopeBar = true

        // Make sure the search bar is showing, even when scrolling
        //navigationItem.hidesSearchBarWhenScrolling = false

        // Add the search controller to the nav item
      //  navigationItem.searchController = searchController
        self.navigationItem.searchController = self.searchController

   //     definesPresentationContext = true

        
        //navigationItem.hidesSearchBarWhenScrolling = false
        //navigationItem.hi
        
        // self.searchController.searchBar.isHidden = true
        
        //        if #available(iOS 13.0, *) {
        //            self.searchController.automaticallyShowsScopeBar = true
        //        }
        //  self.navigationItem.searchController?.hidesNavigationBarDuringPresentation = true
        
    }
    
    
    private func setupNavBar() {
        
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Marvell Heroes"
        
       // let backBarButtton = UIBarButtonItem(title: "", style: .done, target: nil, action: nil)
       // navigationItem.backBarButtonItem = backBarButtton
        
      //  navigationController?.navigationBar.
        
    }

    
    // MARK: - SerchBar
    func searchBar(_ frendsSearch: UISearchBar, textDidChange searchText: String) {
        updateSearchResults(for: self.searchController)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            if let text = searchField.text {
                
              //  let names = text.split { str in str == " " }
                
                model.searchCharacters =  model.characters.filter( { $0.name?.prefix(text.count).description == text } )
                
//                for character in model.characters {
//                    if let names = character.names {
//                    if names.count >= 2 {
//                        print(character.names?[1].description)
//                        model.searchCharacters =  model.characters.filter( { ( $0.names?[0].prefix(text.count).description == text ) || ( $0.names?[1].prefix(text.count).description == text ) } )
//                    } else {
//                        model.searchCharacters =  model.characters.filter( { $0.name?.prefix(text.count).description == text } )
//                    }
//                }
                    
                

                model.search = true
                collectionView.reloadData()
                
                if text.count < 1 {
                    searchController.resignFirstResponder()
                    model.search = false
                    collectionView.reloadData()
                }
        
            }
        }
    }
    
//    func searchBar(_ frendsSearch: UISearchBar, textDidChange searchText: String) {
//
//        model.searchCharacters =  model.characters.filter( { $0.name?.prefix(searchText.count).description == searchText } )
//        model.search = true
//        collectionView.reloadData()
//
//        if searchText.count < 1 {
//            frendsSearch.resignFirstResponder()
//            model.search = false
//            collectionView.reloadData()
//        }
//    }
    
    
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if model.search {
            return model.searchCharacters.count
        }  else {
            return model.characters.count
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "characterCell", for: indexPath) as? CharacterCollectionViewCell else { return UICollectionViewCell() }
        
        if indexPath.row < model.characters.count {
            
            if model.search {
                
                cell.name.text = model.searchCharacters[indexPath.row].name
                cell.info.text = model.searchCharacters[indexPath.row].characterDescription
                cell.avatar.kf.setImage(with: model.searchCharacters[indexPath.row].thumbnail?.url)
            }  else {
            
            cell.name.text = model.characters[indexPath.row].name
            cell.info.text = model.characters[indexPath.row].characterDescription
            cell.avatar.kf.setImage(with: model.characters[indexPath.row].thumbnail?.url)
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
            viewController.character = self.model.searchCharacters[indexPath.row]

        }  else {
            viewController.character = self.model.characters[indexPath.row]
        }
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    
        if indexPath.row + 1 == model.characters.count {
                if self.model.isLoading == false {
                
                    self.spinner = SpinnerView(frame: CGRect(x: 0, y: 0, width: 110, height: 50))
                    self.spinner.center = self.collectionView.center
                    self.collectionView.layer.opacity = 0.3
                    self.view.addSubview(self.spinner)
                    self.spinner.start()
        
                    self.model.loadCharacters(limit: 10, offset: model.characters.count) { [weak self] (message) in
                        guard let self = self else { return }
                        if let error = message {
                            DispatchQueue.main.async {
                                print(error)
                                //let errorMessage = ErrorMessage(view: self.view)
                                //errorMessage.showError(reverse: true, message: error, delay: 3.0)
                            }
                        } else {
                            DispatchQueue.main.async { [weak self] in
                                guard let self = self else { return }
                                self.collectionView.reloadData()
                                self.collectionView.layer.opacity = 1
                                self.spinner.removeFromSuperview()
                                self.spinner.stop()
                                print(self.model.characters.count)
                            }
                        }
                    }
                } else {
                    print("Loading Process")
                }
        }
    }
    
    
    
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    //            return CGSize(width: collectionView.frame.width, height: 100) //add your height here
    //        }
    
    
    //    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    //
    //        switch kind {
    //        case UICollectionView.elementKindSectionHeader:
    //            let reusableview = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "hCollectionReusableView", for: indexPath)
    //            reusableview.frame = CGRect(x: 0 , y: 0, width: self.view.frame.width, height: 80)
    //            reusableview.backgroundColor = .blue
    //
    //                return reusableview
    //
    //
    //        default:  fatalError("Unexpected element kind")
    //        }
    //    }
}
