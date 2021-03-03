//
//  CharacterDetailTableViewHeader.swift
//  AppSmartTest
//
//  Created by Vitaly Khomatov on 02.03.2021.
//

import UIKit

class CharacterDetailTableViewHeader: UIView {
    
  //  var name = UILabel(frame: .zero)
    var avatar = UIImageView(frame: .zero)
    var info = UITextView(frame: .zero)
    var segment = UISegmentedControl(items: ["comics", "stories", "events", "series"])
    
    var segmentSwitchCallback: ((_ selectedSectionNumber: Int) -> Void)?
    
    private var state: State = .comics
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//       // self.backgroundColor = .sectionBackground
//        setupSegmentControl()
//    }
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    private func setupSegmentControl() {
        self.addSubview(segment)
        segment.selectedSegmentIndex = 0
        segment.addTarget(self, action: #selector(self.segmentSwitched), for: .valueChanged)
    }
    
    private func setSegmentedControlSection() {
        segment.selectedSegmentIndex = state.rawValue
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupViews()
        layoutViews()
    }
    
    private func setupViews() {
        
        if #available(iOS 13.0, *) {
            segment.selectedSegmentTintColor = .white
        } else {
            segment.layer.cornerRadius = segment.frame.size.height / 2
            segment.layer.masksToBounds = true
            segment.layer.borderWidth = 2
            segment.layer.borderColor = UIColor.gray.cgColor
        }
        
        segment.backgroundColor = .gray
        segment.tintColor = .white
        segment.translatesAutoresizingMaskIntoConstraints = false

        let titleTextAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor: UIColor.white as Any]
        segment.setTitleTextAttributes(titleTextAttributes, for: .normal)
        let titleSelectedTextAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor: UIColor.red as Any]
        segment.setTitleTextAttributes(titleSelectedTextAttributes, for: .selected)

        setSegmentedControlSection()
        
        self.addSubview(segment)
        segment.selectedSegmentIndex = 0
        segment.addTarget(self, action: #selector(self.segmentSwitched), for: .valueChanged)
        
//        name.textAlignment = .left
//        name.font = .systemFont(ofSize: 18, weight: .bold)
//        name.textColor = UIColor.white
//        name.numberOfLines = 2
//        name.translatesAutoresizingMaskIntoConstraints = false
//        self.addSubview(name)

      //  name.text = "Жопер-мэн"
        
        avatar.contentMode = .scaleAspectFill
        avatar.clipsToBounds = true
        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatar.layer.cornerRadius = 10
        avatar.backgroundColor = .lightGray
     //   avatar.layer.borderColor = UIColor.red.cgColor
     //   avatar.layer.borderWidth = 3.0
        self.addSubview(avatar)

        
        info.textAlignment = .left
        info.font = .systemFont(ofSize: 15, weight: .regular)
        info.textColor = UIColor.red
        info.translatesAutoresizingMaskIntoConstraints = false
        info.layer.cornerRadius = 10
        info.layer.opacity = 0.85

        self.addSubview(info)
        info.isSelectable = false
        
       // info.text = "Сука просто сука Сука просто сука Сука просто сука Сука просто сука Сука просто сука Сука просто сука Сука просто сука Сука просто сука Сука просто сука Сука просто сука Сука просто сука Сука просто сука Сука просто сука Сука просто сука Сука просто сука Сука просто сука Сука просто сука Сука просто сука Сука просто сука Сука просто сука Сука просто сука Сука просто сука Сука просто сука Сука просто сука"

        //info.isUserInteractionEnabled = false
        
        
    }
    
    private func layoutViews() {
        
        avatar.topAnchor.constraint(equalTo: self.topAnchor, constant: 10.0).isActive = true
        avatar.heightAnchor.constraint(equalToConstant: 300.0).isActive = true
        avatar.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5.0).isActive = true
        avatar.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5.0).isActive = true
        
//        name.topAnchor.constraint(equalTo: avatar.topAnchor, constant: 5.0).isActive = true
//        name.heightAnchor.constraint(greaterThanOrEqualToConstant: 30.0).isActive = true
//        name.leftAnchor.constraint(equalTo: avatar.leftAnchor, constant: 5.0).isActive = true
//        name.rightAnchor.constraint(equalTo: avatar.rightAnchor, constant: -5.0).isActive = true
        
        info.bottomAnchor.constraint(equalTo: avatar.bottomAnchor, constant: -3.0).isActive = true
        info.heightAnchor.constraint(equalToConstant: 100.0).isActive = true
        info.leftAnchor.constraint(equalTo: avatar.leftAnchor, constant: 3.0).isActive = true
        info.rightAnchor.constraint(equalTo: avatar.rightAnchor, constant: -3.0).isActive = true
        
        segment.topAnchor.constraint(equalTo: avatar.bottomAnchor, constant: 15.0).isActive = true
        segment.leftAnchor.constraint(equalTo: avatar.leftAnchor).isActive = true
        segment.rightAnchor.constraint(equalTo: avatar.rightAnchor).isActive = true
        segment.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20.0).isActive = true
    }
    
    @objc private func segmentSwitched() {
        state = State(rawValue: segment.selectedSegmentIndex) ?? .comics
        if let callback = self.segmentSwitchCallback {
            callback(segment.selectedSegmentIndex)
        }
    }
    
    private enum State: Int {
        case comics, stories, events, series
    }
    
}
