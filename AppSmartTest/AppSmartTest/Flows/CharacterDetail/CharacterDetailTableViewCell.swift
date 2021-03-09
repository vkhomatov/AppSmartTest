//
//  CharacterDetailTableViewCell.swift
//  AppSmartTest
//
//  Created by Vitaly Khomatov on 02.03.2021.
//

import UIKit

class CharacterDetailTableViewCell: UITableViewCell {
    
    var titleLabel = UILabel(frame: .zero)
    var thumbnailImageView = UIImageView(frame: .zero)
    var descriptionLabel = UILabel(frame: .zero)
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureSubviews()
        layout()
    }
    
    private func configureSubviews() {
        titleLabel.textAlignment = .left
        titleLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        titleLabel.textColor = UIColor.white
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        
        descriptionLabel.font = .systemFont(ofSize: 10, weight: .semibold)
        descriptionLabel.textColor = UIColor.white
        descriptionLabel.textAlignment = .left
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.lineBreakMode = .byTruncatingTail
        contentView.addSubview(descriptionLabel)
        
        thumbnailImageView.contentMode = .scaleAspectFill
        thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        thumbnailImageView.layer.cornerRadius = 10
        thumbnailImageView.backgroundColor = .lightGray
        thumbnailImageView.clipsToBounds = true
        contentView.addSubview(thumbnailImageView)
        
        contentView.backgroundColor = .red
        contentView.layer.cornerRadius = 10
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 2, left: 4, bottom: 2, right: 4))
    }
    
    func layout() {
        thumbnailImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 3.0).isActive = true
        thumbnailImageView.heightAnchor.constraint(equalToConstant: contentView.frame.height - 6).isActive = true
        thumbnailImageView.widthAnchor.constraint(equalToConstant: contentView.frame.height*1.2).isActive = true
        thumbnailImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 3.0).isActive = true
        thumbnailImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3.0).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5.0).isActive = true
        titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 22.0).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: thumbnailImageView.rightAnchor, constant: 10.0).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10.0).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0.0).isActive = true
        descriptionLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 22.0).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: thumbnailImageView.rightAnchor, constant: 10.0).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10.0).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5.0).isActive = true
    }
}
