//
//  CharacterDetailTableViewCell.swift
//  AppSmartTest
//
//  Created by Vitaly Khomatov on 02.03.2021.
//

import UIKit

class CharacterDetailTableViewCell: UITableViewCell {

//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
    var titleLabel = UILabel(frame: .zero)
    var thumbnailImageView = UIImageView(frame: .zero)
    var descriptionLabel = UILabel(frame: .zero)

    
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
        
        titleLabel.textAlignment = .left
      //  name.font = name.font.withSize(18.0)
        titleLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        titleLabel.textColor = UIColor.white
        titleLabel.numberOfLines = 2
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
      //  titleLabel.text = "Жопер-мэн"

       // info.font = info.font.withSize(13.0)
        descriptionLabel.font = .systemFont(ofSize: 10, weight: .semibold)
        descriptionLabel.textColor = UIColor.white
        descriptionLabel.textAlignment = .left
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.lineBreakMode = .byTruncatingTail
      //  descriptionLabel.text = "Сука просто сука Сука просто сука Сука просто сука Сука просто сука Сука просто сука Сука просто сука Сука просто сука Сука просто сука Сука просто сука Сука просто сука Сука просто сука Сука просто сука"
        
        thumbnailImageView.contentMode = .scaleAspectFill
        thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false

        thumbnailImageView.layer.cornerRadius = 10
        thumbnailImageView.backgroundColor = .lightGray

        contentView.addSubview(titleLabel)
        contentView.addSubview(thumbnailImageView)
        contentView.addSubview(descriptionLabel)
        
        self.contentView.backgroundColor = .red
        self.contentView.layer.cornerRadius = 10
        
        
        self.contentView.frame =  self.contentView.frame.inset(by: UIEdgeInsets(top: 2, left: 4, bottom: 2, right: 4))
        
//        self.contentView.layoutMargins.left = 10
//        self.contentView.layoutMargins.bottom = 5
//        self.contentView.layoutMargins.top = 5
//        self.contentView.layoutMargins.right = 10
      //  self.contentView.translatesAutoresizingMaskIntoConstraints = false



    }
    
    func layout() {
       
//        self.contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: self.frame.height).isActive = true
//        self.contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: self.frame.width).priority = UILayoutPriority(rawValue: 100)
        
//        contentView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5.0).isActive = true
//        contentView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5.0).isActive = true
//        contentView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5.0).isActive = true
//        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5.0).isActive = true
        
        thumbnailImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 3.0).isActive = true
        thumbnailImageView.heightAnchor.constraint(equalToConstant: contentView.frame.height - 6).isActive = true
        thumbnailImageView.widthAnchor.constraint(equalToConstant: contentView.frame.height*1.2).isActive = true
        thumbnailImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 3.0).isActive = true
        thumbnailImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3.0).isActive = true

       // thumbnailImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -3.0).isActive = true
        
        
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5.0).isActive = true
        titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 22.0).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: thumbnailImageView.rightAnchor, constant: 10.0).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10.0).isActive = true

        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0.0).isActive = true
        descriptionLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 22.0).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: thumbnailImageView.rightAnchor, constant: 10.0).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10.0).isActive = true

        descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5.0).isActive = true
       // info.heightAnchor.constraint(greaterThanOrEqualToConstant: 22.0).isActive = true
       // info.leftAnchor.constraint(equalTo: name.leftAnchor).isActive = true
       // info.rightAnchor.constraint(equalTo: name.rightAnchor).isActive = true

       
    }
    

}
