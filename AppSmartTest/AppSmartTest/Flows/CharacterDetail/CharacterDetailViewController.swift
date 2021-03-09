//
//  CharacterDetailViewController.swift
//  AppSmartTest
//
//  Created by Vitaly Khomatov on 02.03.2021.
//

import UIKit
import Kingfisher

class CharacterDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource /*, UITableViewDataSourcePrefetching */{
    
    public let model = CharacterDetailViewModel()
    private var headerView = CharacterDetailTableViewHeader()
    private var firstTime: Bool = true
    private var tableView = UITableView()
    let storyCellId = "storyCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createViews()
        loadHero()
        setCallbacks()
        
        if model.loadStorySJ.count == 0 {
            
            
            guard let id = self.model.characterSJ?.id else { return }

            loadData(id: id, storyType: self.model.activity, limit: 10, offset: 0)
            //
          /*  self.model.isLoading = true
            let spinner = SpinnerView(frame: CGRect(x: self.tableView.frame.midX-55, y: self.headerView.frame.height + (self.tableView.frame.height - self.headerView.frame.height)/2, width: 110, height: 50))
            self.view.addSubview(spinner)
            spinner.start()
            
            guard let id = self.model.characterSJ?.id else { return }
            self.model.loadCharacterStoriesSJ(id: id, storyType: model.activity, limit: 10, offset: 0) { [weak self] (message) in
                guard let self = self else { return }
                if let error = message {
                    DispatchQueue.main.async {
                        self.model.isLoading = false
                        spinner.stop()
                        spinner.removeFromSuperview()
                        self.tableView.isUserInteractionEnabled = true
                        guard let navcontroller = self.navigationController?.view else { return }
                        let errorMessage = ErrorMessage(view: navcontroller)
                        errorMessage.showError(reverse: true, message: error, delay: 3.0)
                    }
                } else {
                    DispatchQueue.main.async { [weak self] in
                        guard let self = self else { return }
                        self.tableView.reloadData()
                        spinner.stop()
                        spinner.removeFromSuperview()
                        self.model.isLoading = false
                    }
                }
            } */
        }
        //
        
        
    }
    
    private func loadHero() {
        guard let characterSJ = self.model.characterSJ else { return }
        
        self.title = characterSJ.name
        if model.characterSJ?.descriptionSJ != "" {
            headerView.info.text = characterSJ.descriptionSJ
        } else {
            headerView.info.isHidden = true
        }

        if let url = model.createURL(fileExtension: characterSJ.fileExtension, path: characterSJ.path) {
            headerView.avatar.kf.setImage(with: url)
        }
        
        
        model.activity = self.model.activity.getIndex(num: characterSJ.segment)
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
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CharacterDetailTableViewCell.self, forCellReuseIdentifier: storyCellId)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        view.addSubview(tableView)
        
        headerView = CharacterDetailTableViewHeader(frame: CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: 370.0))
        headerView.backgroundColor = .white
        headerView.layer.cornerRadius = 10
        guard let characterSJ = self.model.characterSJ else { return }
        headerView.segment.selectedSegmentIndex = characterSJ.segment
    }
    
    
    
    private func setCallbacks() {
        self.headerView.segmentSwitchCallback = { [weak self] selectedSection in
            guard let self = self else { return }
            
            self.model.activity = self.model.activity.getIndex(num: selectedSection)
            guard let characterSJ = self.model.characterSJ else { return }
            try? RealmService.save(item: characterSJ, segment: selectedSection)
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
                
                guard let id = self.model.characterSJ?.id else { return }

                self.loadData(id: id, storyType: self.model.activity, limit: 10, offset: self.model.loadStorySJ.count)
                
                
                //
             /*   self.model.isLoading = true
                let spinner = SpinnerView(frame: CGRect(x: self.tableView.frame.midX-55, y: self.headerView.frame.height + (self.tableView.frame.height - self.headerView.frame.height)/2, width: 110, height: 50))
                for cell in self.tableView.visibleCells { cell.layer.opacity = 0.2 }
                self.tableView.isUserInteractionEnabled = false
                self.view.addSubview(spinner)
                spinner.start()
                guard let id = self.model.characterSJ?.id else { return }
                self.model.loadCharacterStoriesSJ(id: id, storyType: self.model.activity, limit: 10, offset: self.model.loadStorySJ.count) { [weak self] (message) in
                    guard let self = self else { return }
                    if let error = message {
                        DispatchQueue.main.async {
                            spinner.stop()
                            spinner.removeFromSuperview()
                            for cell in self.tableView.visibleCells { cell.layer.opacity = 1 }
                            self.tableView.isUserInteractionEnabled = true
                            self.model.isLoading = false
                            
                            guard let navcontroller = self.navigationController?.view else { return }
                            let errorMessage = ErrorMessage(view: navcontroller)
                            errorMessage.showError(reverse: true, message: error, delay: 3.0)
                        }
                    } else {
                        DispatchQueue.main.async { [weak self] in
                            guard let self = self else { return }
                            self.tableView.reloadData()
                            for cell in self.tableView.visibleCells { cell.layer.opacity = 1 }
                            self.tableView.isUserInteractionEnabled = true
                            spinner.stop()
                            spinner.removeFromSuperview()
                            self.model.isLoading = false
                        }
                    }
                } */
                //
            }
        }
    }
    
    
    
    private func loadData(id: Int, storyType: TypeOfStory, limit: Int, offset: Int) {
        
        self.model.isLoading = true
        let spinner = SpinnerView(frame: CGRect(x: self.tableView.frame.midX-55, y: self.headerView.frame.height + (self.tableView.frame.height - self.headerView.frame.height)/2, width: 110, height: 50))
        for cell in tableView.visibleCells { cell.layer.opacity = 0.2 }
        tableView.isUserInteractionEnabled = false
        view.addSubview(spinner)
        spinner.start()
        guard let id = self.model.characterSJ?.id else { return }
        self.model.loadCharacterStoriesSJ(id: id, storyType: storyType, limit: limit, offset: offset) { [weak self] (message) in
            guard let self = self else { return }
            if let error = message {
                DispatchQueue.main.async {
                    spinner.stop()
                    spinner.removeFromSuperview()
                    for cell in self.tableView.visibleCells { cell.layer.opacity = 1 }
                    self.tableView.isUserInteractionEnabled = true
                    self.model.isLoading = false
                    guard let navcontroller = self.navigationController?.view else { return }
                    let errorMessage = ErrorMessage(view: navcontroller)
                    errorMessage.showError(reverse: true, message: error, delay: 3.0)
                }
            } else {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.tableView.reloadData()
                    spinner.stop()
                    spinner.removeFromSuperview()
                    for cell in self.tableView.visibleCells { cell.layer.opacity = 1 }
                    self.tableView.isUserInteractionEnabled = true
                    self.model.isLoading = false
                }
            }
        }
        
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.loadStorySJ.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: storyCellId, for: indexPath) as? CharacterDetailTableViewCell else { return CharacterDetailTableViewCell()
        }
        if model.loadStorySJ.count  > indexPath.row {
            cell.titleLabel.text = model.loadStorySJ[indexPath.row].title
            cell.descriptionLabel.text = model.loadStorySJ[indexPath.row].descriptionSJ
            if let url = model.createURL(fileExtension: model.loadStorySJ[indexPath.row].fileExtension, path: model.loadStorySJ[indexPath.row].path) {
                cell.thumbnailImageView.kf.setImage(with: url)
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if distanceFromBottom < height {
            
            if !self.firstTime {
                if model.isLoading == false  {
                    
                    guard let id = self.model.characterSJ?.id else { return }

                    loadData(id: id, storyType: self.model.activity, limit: 10, offset: self.model.loadStorySJ.count)
                    
                    //
                   /* self.model.isLoading = true
                    let spinner = SpinnerView(frame: CGRect(x: self.tableView.frame.midX-55, y: self.headerView.frame.height + (self.tableView.frame.height - self.headerView.frame.height)/2, width: 110, height: 50))
                    for cell in tableView.visibleCells { cell.layer.opacity = 0.2 }
                    tableView.isUserInteractionEnabled = false
                    view.addSubview(spinner)
                    spinner.start()
                    guard let id = self.model.characterSJ?.id else { return }
                    self.model.loadCharacterStoriesSJ(id: id, storyType: self.model.activity, limit: 10, offset: self.model.loadStorySJ.count) { [weak self] (message) in
                        guard let self = self else { return }
                        if let error = message {
                            DispatchQueue.main.async {
                                spinner.stop()
                                spinner.removeFromSuperview()
                                for cell in self.tableView.visibleCells { cell.layer.opacity = 1 }
                                self.tableView.isUserInteractionEnabled = true
                                self.model.isLoading = false
                                guard let navcontroller = self.navigationController?.view else { return }
                                let errorMessage = ErrorMessage(view: navcontroller)
                                errorMessage.showError(reverse: true, message: error, delay: 3.0)
                            }
                        } else {
                            DispatchQueue.main.async { [weak self] in
                                guard let self = self else { return }
                                self.tableView.reloadData()
                                spinner.stop()
                                spinner.removeFromSuperview()
                                for cell in self.tableView.visibleCells { cell.layer.opacity = 1 }
                                self.tableView.isUserInteractionEnabled = true
                                self.model.isLoading = false
                            }
                        }
                    } */
                    //
                }
            }
            self.firstTime = false
        }
    }
}



