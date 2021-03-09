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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureSubviews()
        layout()
    }
    
    private func configureSubviews() {
        name.textAlignment = .left
        name.font = .systemFont(ofSize: 15, weight: .semibold)
        name.textColor = UIColor.white
        name.numberOfLines = 2
        name.translatesAutoresizingMaskIntoConstraints = false
        
        info.font = .systemFont(ofSize: 10, weight: .semibold)
        info.textColor = .white
        info.textAlignment = .left
        info.numberOfLines = 5
        info.translatesAutoresizingMaskIntoConstraints = false
        info.lineBreakMode = .byTruncatingTail
        
        avatar.contentMode = .scaleAspectFill
        avatar.clipsToBounds = true
        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatar.layer.cornerRadius = 10
        avatar.backgroundColor = .lightGray

        contentView.addSubview(name)
        contentView.addSubview(avatar)
        contentView.addSubview(info)
        contentView.backgroundColor = .red
        contentView.layer.cornerRadius = 10
    }
    
    func layout() {
        name.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10.0).isActive = true
        name.heightAnchor.constraint(greaterThanOrEqualToConstant: 22.0).isActive = true
        name.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10.0).isActive = true
        name.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10.0).isActive = true

        avatar.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 5.0).isActive = true
        avatar.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 3.0).isActive = true
        avatar.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -3.0).isActive = true
        avatar.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5.0).isActive = true

        info.heightAnchor.constraint(greaterThanOrEqualToConstant: 22.0).isActive = true
        info.leftAnchor.constraint(equalTo: name.leftAnchor, constant: 0.0).isActive = true
        info.rightAnchor.constraint(equalTo: name.rightAnchor, constant: 0.0).isActive = true
        info.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8.0).isActive = true
    }
}
