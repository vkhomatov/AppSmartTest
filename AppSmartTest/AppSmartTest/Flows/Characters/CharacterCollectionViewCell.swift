//
//  CharacterCollectionViewCell.swift
//  AppSmartTest
//
//  Created by Vitaly Khomatov on 02.03.2021.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {
    
    var name = UILabel(frame: .zero)
    var avatar = UIImageView(frame: .zero)
    var info = UILabel(frame: .zero)

    
//    override init(frame: CGRect) {
//        super.init(frame: .zero)
//        configureSubviews()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureSubviews()
        layout()
    }
    
    private func configureSubviews() {
        
        name.textAlignment = .left
      //  name.font = name.font.withSize(18.0)
        name.font = .systemFont(ofSize: 15, weight: .semibold)
        name.textColor = UIColor.white
        name.numberOfLines = 2
        name.translatesAutoresizingMaskIntoConstraints = false
      //  name.text = "Жопер-мэн"

       // info.font = info.font.withSize(13.0)
        info.font = .systemFont(ofSize: 10, weight: .semibold)
        info.textColor = UIColor.white
        info.textAlignment = .left
        info.numberOfLines = 5
        info.translatesAutoresizingMaskIntoConstraints = false
        info.lineBreakMode = .byTruncatingTail
      //  info.text = "Сука просто сука Сука просто сука Сука просто сука Сука просто сука Сука просто сука Сука просто сука Сука просто сука Сука просто сука Сука просто сука Сука просто сука Сука просто сука Сука просто сука"
        
        avatar.contentMode = .scaleAspectFill
        avatar.clipsToBounds = true
        avatar.translatesAutoresizingMaskIntoConstraints = false

        avatar.layer.cornerRadius = 10
        avatar.backgroundColor = .lightGray

        contentView.addSubview(name)
        contentView.addSubview(avatar)
        contentView.addSubview(info)
        
        self.contentView.backgroundColor = .red
        self.contentView.layer.cornerRadius = 10

    }
    
    func layout() {
       
//        self.contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: self.frame.height).isActive = true
//        self.contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: self.frame.width).priority = UILayoutPriority(rawValue: 100)
        
        
        name.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10.0).isActive = true
        name.heightAnchor.constraint(greaterThanOrEqualToConstant: 22.0).isActive = true
        name.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10.0).isActive = true
        name.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10.0).isActive = true

        avatar.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 5.0).isActive = true
        avatar.heightAnchor.constraint(equalToConstant: 140.0).isActive = true
        avatar.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 3.0).isActive = true
        avatar.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -3.0).isActive = true

        info.topAnchor.constraint(equalTo: avatar.bottomAnchor, constant: 5.0).isActive = true
        info.heightAnchor.constraint(greaterThanOrEqualToConstant: 22.0).isActive = true
        info.leftAnchor.constraint(equalTo: name.leftAnchor, constant: 0.0).isActive = true
        info.rightAnchor.constraint(equalTo: name.rightAnchor, constant: 0.0).isActive = true
        
        info.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5.0).isActive = true
       // info.heightAnchor.constraint(greaterThanOrEqualToConstant: 22.0).isActive = true
       // info.leftAnchor.constraint(equalTo: name.leftAnchor).isActive = true
       // info.rightAnchor.constraint(equalTo: name.rightAnchor).isActive = true

       
    }
    
    
}
