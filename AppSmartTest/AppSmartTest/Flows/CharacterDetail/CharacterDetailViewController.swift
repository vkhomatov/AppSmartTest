//
//  CharacterDetailViewController.swift
//  AppSmartTest
//
//  Created by Vitaly Khomatov on 02.03.2021.
//

import UIKit
import Kingfisher



class CharacterDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource /*, UITableViewDataSourcePrefetching */{
    
    
    public var model = CharacterDetailViewModel()
    private var spinner = SpinnerView()
    private var firstTime: Bool = true
    private var tableView = UITableView()
    private var headerView = CharacterDetailTableViewHeader()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createViews()
        loadHero()
        setCallbacks()

        
        
        if model.loadStorySJ.count == 0 {

            DispatchQueue.main.async { [self] in
                self.model.isLoading = true

                self.spinner = SpinnerView(frame: CGRect(x: self.tableView.frame.midX-55, y: self.headerView.frame.height + (self.tableView.frame.height - self.headerView.frame.height)/2, width: 110, height: 50))
                self.view.addSubview(self.spinner)
                self.spinner.start()

                guard let id = self.model.characterSJ?.id else { return }

                self.model.loadCharacterStoriesSJ(id: id, storyType: model.activity.rawValue, limit: 10, offset: 0) { [weak self] (message) in
                    guard let self = self else { return }
                    if let error = message {
                        DispatchQueue.main.async {
                            print(error)
                            self.model.isLoading = true

                            //                         let errorMessage = ErrorMessage(view: self.view)
                            //                         errorMessage.showError(reverse: true, message: error, delay: 3.0)
                        }
                    } else {
                        DispatchQueue.main.async { [weak self] in
                            guard let self = self else { return }
                            self.tableView.reloadData()
                            self.spinner.removeFromSuperview()
                            self.spinner.stop()
                            self.model.isLoading = false

                        }
                    }
                }



            }
        }
        
        
    }
    
    
    
    private func loadHero() {
        
        
        guard let characterSJ = self.model.characterSJ else { return }
        
        self.title = characterSJ.name
        
        if model.characterSJ?.descriptionSJ != "" {
            headerView.info.text = characterSJ.descriptionSJ
        } else {
            headerView.info.isHidden = true
        }
       // headerView.avatar.kf.setImage(with: characterSJ.url)
        
        headerView.avatar.kf.setImage(with: characterSJ.url)

        
        self.model.activity = self.model.activity.getIndex(num: characterSJ.segment)
        
        switch  self.model.activity {
        case .comics:
            self.model.loadStorySJ = characterSJ.comicsSJ
        case .events:
            self.model.loadStorySJ = characterSJ.eventsSJ
        case .series:
            self.model.loadStorySJ = characterSJ.seriesSJ
        case .stories:
            self.model.loadStorySJ = characterSJ.storiesSJ
        }
        
    }
    
    private func createViews() {
        
        self.tableView = UITableView(frame: view.bounds, style: .plain)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.register(CharacterDetailTableViewCell.self, forCellReuseIdentifier: "storyCell")
        self.tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.tableView.separatorStyle = .none
        
        
        view.addSubview(tableView)
        
        headerView = CharacterDetailTableViewHeader(frame: CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: 370.0))
        //   tableView.tableHeaderView = headerView
        
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        headerView.backgroundColor = .white
        headerView.layer.cornerRadius = 10
        
        guard let characterSJ = self.model.characterSJ else { return }
        
        headerView.segment.selectedSegmentIndex = characterSJ.segment
        
        //   self.navigationItem.searchController?.view = headerView
        
        
    }
    
    
    
    private func setCallbacks() {
        
        self.headerView.segmentSwitchCallback = { [weak self] selectedSection in
            
            guard let self = self else { return }
            
            
            self.model.activity = self.model.activity.getIndex(num: selectedSection)
            self.model.characterSJ?.segment = selectedSection
            
            
            guard let characterSJ = self.model.characterSJ else { return }
            
            switch  self.model.activity {
            case .comics:
                self.model.loadStorySJ = characterSJ.comicsSJ
            case .events:
                self.model.loadStorySJ = characterSJ.eventsSJ
            case .series:
                self.model.loadStorySJ = characterSJ.seriesSJ
            case .stories:
                self.model.loadStorySJ = characterSJ.storiesSJ
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
            if self.model.loadStorySJ.count == 0 {
                
                
                DispatchQueue.main.async { [self] in
                    self.model.isLoading = true
                    
                    //spinner start
                    self.spinner = SpinnerView(frame: CGRect(x: self.tableView.frame.midX-55, y: self.headerView.frame.height + (self.tableView.frame.height - self.headerView.frame.height)/2, width: 110, height: 50))
                    for cell in self.tableView.visibleCells { cell.layer.opacity = 0.2 }
                    self.tableView.isUserInteractionEnabled = false
                    self.view.addSubview(self.spinner)
                    self.spinner.start()
                    
                    
                    //loading data
                    guard let id = self.model.characterSJ?.id else { return }
                    self.model.loadCharacterStoriesSJ(id: id, storyType: self.model.activity.rawValue, limit: 10, offset: self.model.loadStorySJ.count) { [weak self] (message) in
                        guard let self = self else { return }
                        if let error = message {
                            DispatchQueue.main.async {
                                print(error)
                                
                                //spinner stop
                                self.spinner.removeFromSuperview()
                                self.spinner.stop()
                                for cell in self.tableView.visibleCells { cell.layer.opacity = 1 }
                                self.tableView.isUserInteractionEnabled = true
                                self.model.isLoading = false
                                
                                //let errorMessage = ErrorMessage(view: self.view)
                                //errorMessage.showError(reverse: true, message: error, delay: 3.0)
                            }
                        } else {
                            DispatchQueue.main.async { [weak self] in
                                guard let self = self else { return }
                                self.tableView.reloadData()
                                
                                //spinner stop
                                self.spinner.removeFromSuperview()
                                self.spinner.stop()
                                for cell in self.tableView.visibleCells { cell.layer.opacity = 1 }
                                self.tableView.isUserInteractionEnabled = true
                                self.model.isLoading = false
                                
                            }
                        }
                    }
                    
                }
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return model.loadStorySJ.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "storyCell", for: indexPath) as? CharacterDetailTableViewCell else { return CharacterDetailTableViewCell()
        }
        
        
        if model.loadStorySJ.count  > indexPath.row {
            cell.titleLabel.text = model.loadStorySJ[indexPath.row].title
            cell.descriptionLabel.text = model.loadStorySJ[indexPath.row].descriptionSJ
            if model.loadStorySJ[indexPath.row].url != nil {
                cell.thumbnailImageView.kf.setImage(with: model.loadStorySJ[indexPath.row].url)
            } else {
                cell.thumbnailImageView.image = UIImage(named: "noimage")
            }
        }
        
        
        cell.selectionStyle = .none
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 370.0
    }
    
    
    
    /*   func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
     if indexPath.row + 1  == model.loadStorySJ.count {
     
     }
     } */
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if distanceFromBottom < height {
            
            if !self.firstTime {
                
                if self.model.isLoading == false {
                    
                    
                    DispatchQueue.main.async { [self] in
                        self.model.isLoading = true
                        
                        //spinner start
                        self.spinner = SpinnerView(frame: CGRect(x: self.tableView.frame.midX-55, y: self.headerView.frame.height + (self.tableView.frame.height - self.headerView.frame.height)/2, width: 110, height: 50))
                        
                        for cell in self.tableView.visibleCells { cell.layer.opacity = 0.2 }
                        
                        self.tableView.isUserInteractionEnabled = false
                        self.view.addSubview(self.spinner)
                        self.spinner.start()
                        
                        
                        //loading data
                        guard let id = self.model.characterSJ?.id else { return }
                        self.model.loadCharacterStoriesSJ(id: id, storyType: self.model.activity.rawValue, limit: 10, offset: self.model.loadStorySJ.count) { [weak self] (message) in
                            guard let self = self else { return }
                            if let error = message {
                                DispatchQueue.main.async {
                                    print(error)
                                    
                                    //spinner stop
                                    self.spinner.removeFromSuperview()
                                    self.spinner.stop()
                                    for cell in self.tableView.visibleCells { cell.layer.opacity = 1 }
                                    self.tableView.isUserInteractionEnabled = true
                                    self.model.isLoading = false
                                    
                                    //let errorMessage = ErrorMessage(view: self.view)
                                    //errorMessage.showError(reverse: true, message: error, delay: 3.0)
                                }
                            } else {
                                DispatchQueue.main.async { [weak self] in
                                    guard let self = self else { return }
                                    self.tableView.reloadData()
                                    
                                    //spinner stop
                                    self.spinner.removeFromSuperview()
                                    self.spinner.stop()
                                    for cell in self.tableView.visibleCells { cell.layer.opacity = 1 }
                                    self.tableView.isUserInteractionEnabled = true
                                    self.model.isLoading = false
                                }
                            }
                        }
                        
                    }
                    
                }
                
            }
            self.firstTime = false
        
        }
    }
    
    
}



