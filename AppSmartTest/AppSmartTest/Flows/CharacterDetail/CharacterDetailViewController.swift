//
//  CharacterDetailViewController.swift
//  AppSmartTest
//
//  Created by Vitaly Khomatov on 02.03.2021.
//

import UIKit
import Kingfisher


//enum characterActiviti {
//    case comics
//    case events
//    case series
//    case stories
//}



class CharacterDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource /*, UITableViewDataSourcePrefetching */{
   
    
    var model = CharacterDetailViewModel()
   // var model = CharactersCollectionViewModel()
    private var spinner = SpinnerView()
    private var firstTime: Bool = true

    
    
    var tableView = UITableView()
    
  //  var character: Character?
    //var characterSJ: CharacterSJ?

    
    var headerView = CharacterDetailTableViewHeader()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createViews()
        setCallbacks()
        loadHero()
        
        
        guard let characterSJ = self.model.characterSJ else { return }

        self.model.loadStorySJ = characterSJ.comicsSJ
      //  headerView.segment.selectedSegmentIndex = characterSJ.segment

        
//        if let id = characterSJ?.id {
//            model.loadCharacterStoriesSJ(id: id, storyType: "comics", limit: 10, offset: 0) { str in
//                print(str)
//            }
//        }
        
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
   
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        guard let characterSJ = self.model.characterSJ else { return }
//
//        //self.model.loadStorySJ = characterSJ.comicsSJ
//        headerView.segment.selectedSegmentIndex = characterSJ.segment
//    }

    
    private func loadHero() {
        self.title = model.characterSJ?.name
        
        if model.characterSJ?.description != "" {
            headerView.info.text = model.characterSJ?.description
        } else {
            headerView.info.isHidden = true
           // headerView.name.text = characterSJ?.name
        }
        headerView.avatar.kf.setImage(with: model.characterSJ?.url)
    }
    
    private func createViews() {
        
        self.tableView = UITableView(frame: view.bounds, style: .plain)
        self.tableView.delegate = self
        self.tableView.dataSource = self
      //  self.tableView.prefetchDataSource = self

        self.tableView.register(CharacterDetailTableViewCell.self, forCellReuseIdentifier: "storyCell")
        self.tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
     //   self.tableView.separatorStyle = .singleLine
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
            
            print(self.model.activity)
            
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
            
//            DispatchQueue.main.async { [weak self] in
//                self?.tableView.reloadData()
//            }
            
//            switch selectedSection {
//            case 0:
//                print("Segment 0")
//                self.activity = .comics
//                DispatchQueue.main.async { [weak self] in
//                    self?.tableView.reloadData()
//                }
//            case 1:
//                self.activity = .stories
//                DispatchQueue.main.async { [weak self] in
//                    self?.tableView.reloadData()
//                }
//
//                print("Segment 1")
//            case 2:
//                self.activity = .series
//                DispatchQueue.main.async { [weak self] in
//                    self?.tableView.reloadData()
//                }
//
//                print("Segment 2")
//            case 3:
//                self.activity = .events
//                DispatchQueue.main.async { [weak self] in
//                    self?.tableView.reloadData()
//                }
//
//                print("Segment 3")
//            default:
//                break
//            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      /*  switch model.activity {
        case .comics:
            return characterSJ?.comicsItems?.count ?? 0
        case .events:
            return characterSJ?.eventsItems?.count ?? 0
        case .series:
            return characterSJ?.seriesItems?.count ?? 0
        case .stories:
            return characterSJ?.storiesItems?.count ?? 0
        } */
        
        
     /*   switch model.activity {
         case .comics:
            return model.comicsSJ.count
         case .events:
            return model.eventsSJ.count
         case .series:
            return model.seriesSJ.count
         case .stories:
            return model.storiesSJ.count
         } */
        
        return model.loadStorySJ.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "storyCell", for: indexPath) as? CharacterDetailTableViewCell else { return CharacterDetailTableViewCell()
        }
            
      /*  switch model.activity {
        case .comics:
            if let count = characterSJ?.comicsItems?.count, count  > indexPath.row {
                cell.titleLabel.text = characterSJ?.comicsItems?[indexPath.row].name
                cell.descriptionLabel.text = characterSJ?.comicsItems?[indexPath.row].resourceURI
            }
        case .events:
            if let count = characterSJ?.eventsItems?.count, count  > indexPath.row {
                cell.titleLabel.text = characterSJ?.eventsItems?[indexPath.row].name
                cell.descriptionLabel.text = characterSJ?.eventsItems?[indexPath.row].resourceURI
            }
        case .series:
            if let count = characterSJ?.seriesItems?.count, count  > indexPath.row {
                cell.titleLabel.text = characterSJ?.seriesItems?[indexPath.row].name
                cell.descriptionLabel.text = characterSJ?.seriesItems?[indexPath.row].resourceURI
            }
        case .stories:
            if let count = characterSJ?.storiesItems?.count, count  > indexPath.row {
                cell.titleLabel.text = characterSJ?.storiesItems?[indexPath.row].name
                cell.descriptionLabel.text = characterSJ?.storiesItems?[indexPath.row].resourceURI
            }
        } */
        
        
        
        
     /*   switch model.activity {
        case .comics:
            if model.comicsSJ.count  > indexPath.row {
                cell.titleLabel.text = model.comicsSJ[indexPath.row].title
                cell.descriptionLabel.text = model.comicsSJ[indexPath.row].description
                cell.thumbnailImageView.kf.setImage(with: model.comicsSJ[indexPath.row].url)
            }
        case .events:
            if model.eventsSJ.count  > indexPath.row {
                cell.titleLabel.text = model.eventsSJ[indexPath.row].title
                cell.descriptionLabel.text = model.eventsSJ[indexPath.row].description
                cell.thumbnailImageView.kf.setImage(with: model.eventsSJ[indexPath.row].url)
            }
        case .series:
            if model.seriesSJ.count  > indexPath.row {
                cell.titleLabel.text = model.seriesSJ[indexPath.row].title
                cell.descriptionLabel.text = model.seriesSJ[indexPath.row].description
                cell.thumbnailImageView.kf.setImage(with: model.seriesSJ[indexPath.row].url)
            }
        case .stories:
            if model.storiesSJ.count  > indexPath.row {
                cell.titleLabel.text = model.storiesSJ[indexPath.row].title
                cell.descriptionLabel.text = model.storiesSJ[indexPath.row].description
                cell.thumbnailImageView.kf.setImage(with: model.storiesSJ[indexPath.row].url)
            }
        } */
        
        if model.loadStorySJ.count  > indexPath.row {
            cell.titleLabel.text = model.loadStorySJ[indexPath.row].title
            cell.descriptionLabel.text = model.loadStorySJ[indexPath.row].description
            if model.loadStorySJ[indexPath.row].url != URL(string: ".") {
               cell.thumbnailImageView.kf.setImage(with: model.loadStorySJ[indexPath.row].url)
            } else {
                cell.thumbnailImageView.image = UIImage(named: "noimage")
            }
            //print(model.loadStorySJ[indexPath.row].url)
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
    
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1  == model.loadStorySJ.count {

        if !self.firstTime {
            
            if self.model.isLoading == false {
                
                    
                    DispatchQueue.main.async { [self] in
                        self.model.isLoading = true
                        //spinner start
                        self.spinner = SpinnerView(frame: CGRect(x: self.tableView.frame.midX-55, y: self.headerView.frame.height + (self.tableView.frame.height - self.headerView.frame.height)/2, width: 110, height: 50))
                        
                        for cell in self.tableView.visibleCells { cell.layer.opacity = 0.2 }
                        
                       // self.tableView.cel
                        
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

    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
      if  scrollView.contentOffset.y >= 0
            && scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height) {
        
        print("ХУЙ ХУЙ ХУЙ")
      }
    }


//    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
//
//        if self.model.isLoading == false {
//
//        DispatchQueue.main.async { [self] in
//            self.model.isLoading = true
//            //spinner start
//            self.spinner = SpinnerView(frame: CGRect(x: self.tableView.frame.midX-55, y: self.headerView.frame.height + (self.tableView.frame.height - self.headerView.frame.height)/2, width: 110, height: 50))
//
//            for cell in self.tableView.visibleCells { cell.layer.opacity = 0.2 }
//
//           // self.tableView.cel
//
//            self.tableView.isUserInteractionEnabled = false
//            self.view.addSubview(self.spinner)
//            self.spinner.start()
//
//
//            //loading data
//            guard let id = self.characterSJ?.id else { return }
//            self.model.loadCharacterStoriesSJ(id: id, storyType: self.model.activity.rawValue, limit: indexPaths.count, offset: self.model.loadStorySJ.count) { [weak self] (message) in
//                guard let self = self else { return }
//                if let error = message {
//                    DispatchQueue.main.async {
//                        print(error)
//
//                        //spinner stop
//                        self.spinner.removeFromSuperview()
//                        self.spinner.stop()
//                        for cell in self.tableView.visibleCells { cell.layer.opacity = 1 }
//                        self.tableView.isUserInteractionEnabled = true
//                        self.model.isLoading = false
//
//                        //let errorMessage = ErrorMessage(view: self.view)
//                        //errorMessage.showError(reverse: true, message: error, delay: 3.0)
//                    }
//                } else {
//                    DispatchQueue.main.async { [weak self] in
//                        guard let self = self else { return }
//                        self.tableView.reloadData()
//
//                        //spinner stop
//                        self.spinner.removeFromSuperview()
//                        self.spinner.stop()
//                        for cell in self.tableView.visibleCells { cell.layer.opacity = 1 }
//                        self.tableView.isUserInteractionEnabled = true
//                        self.model.isLoading = false
//                    }
//                }
//            }
//
//        }
//
//    }
//        print("Загрузка данных")
//    }
//    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
//
//    }


}



