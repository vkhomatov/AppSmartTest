//
//  CharacterDetailViewController.swift
//  AppSmartTest
//
//  Created by Vitaly Khomatov on 02.03.2021.
//

import UIKit


//enum characterActiviti {
//    case comics
//    case events
//    case series
//    case stories
//}

enum TypeOfPActivity: CaseIterable {
    case comics, events, series, stories
    
    func getIndex(num: Int)  -> TypeOfPActivity  {
        switch num {
        case 0:
            return TypeOfPActivity.comics
        case 1:
            return TypeOfPActivity.events

        case 2:
            return TypeOfPActivity.series
        case 3:
            return TypeOfPActivity.stories

        default:
            return TypeOfPActivity.comics
        }
        
    }
}

class CharacterDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var activity: TypeOfPActivity = .comics
    
    var tableView = UITableView()
    
    var character: Character?
    
    var headerView = CharacterDetailTableViewHeader()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createViews()
        setCallbacks()
        loadHero()
        view.setNeedsLayout()
        
    }
    
    //    init(character: Character) {
    //        super.init(nibName: nil, bundle: nil)
    //        self.character = character
    //
    //    }
    //
    //    public required init?(coder aDecoder: NSCoder) {
    //        super.init(coder: aDecoder)
    //        self.character = nil
    //    }
    //
    
    
    private func loadHero() {
        self.title = character?.name
        
        if character?.characterDescription != "" {
            headerView.info.text = character?.characterDescription
        } else {
            headerView.info.isHidden = true
        }
        headerView.avatar.kf.setImage(with: character?.thumbnail?.url)
    }
    
    private func createViews() {
        
        self.tableView = UITableView(frame: view.bounds, style: .plain)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(CharacterDetailTableViewCell.self, forCellReuseIdentifier: "storyCell")
        self.tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.tableView.separatorStyle = .singleLine
        self.tableView.separatorStyle = .none
        
        
        view.addSubview(tableView)
        
        headerView = CharacterDetailTableViewHeader(frame: CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: 380.0))
        tableView.tableHeaderView = headerView
        
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        
        self.navigationItem.searchController?.view = headerView
        

    }
    
    
    
    private func setCallbacks() {
        
        self.headerView.segmentSwitchCallback = { [weak self] selectedSection in
            
            guard let self = self else { return }
            
            
            self.activity = self.activity.getIndex(num: selectedSection)
            print(self.activity)
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
            
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
        return character?.comics?.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "storyCell", for: indexPath) as? CharacterDetailTableViewCell else { return CharacterDetailTableViewCell()
        }
        
        
            
            switch activity {
            case .comics:
                if let count = character?.comics?.items?.count, count  > indexPath.row {

                cell.titleLabel.text = character?.comics?.items?[indexPath.row].name
                cell.descriptionLabel.text = character?.comics?.items?[indexPath.row].resourceURI
                }
            case .events:
                if let count = character?.events?.items?.count, count  > indexPath.row {

                cell.titleLabel.text = character?.events?.items?[indexPath.row].name
                cell.descriptionLabel.text = character?.events?.items?[indexPath.row].resourceURI
                }
            case .series:
                if let count = character?.series?.items?.count, count  > indexPath.row {

                cell.titleLabel.text = character?.series?.items?[indexPath.row].name
                cell.descriptionLabel.text = character?.series?.items?[indexPath.row].resourceURI
                }
            case .stories:
                if let count = character?.stories?.items?.count, count  > indexPath.row {

                cell.titleLabel.text = character?.stories?.items?[indexPath.row].name
                cell.descriptionLabel.text = character?.stories?.items?[indexPath.row].resourceURI
                }
            }
           
        
        
        cell.selectionStyle = .none
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    //    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    //
    //        return headerView
    //    }
    
    //    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    //        return 30.0
    //    }
    
}
