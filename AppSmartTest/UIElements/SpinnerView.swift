//
//  SpinnerView.swift
//  AppSmartTest
//
//  Created by Vitaly Khomatov on 03.03.2021.
//

import UIKit
//import PinLayout

class SpinnerView: UIView {

    lazy var messageLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.text = "Loading"
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.textColor = .white
        label.sizeToFit()

        return label
    }()

    private lazy var spinner: UIActivityIndicatorView = {
        if #available(iOS 13.0, *) {
            let spinner = UIActivityIndicatorView(style: .medium)
            spinner.color = .white
            return spinner
        }
            let spinner = UIActivityIndicatorView(style: .white)
        spinner.color = .white
       // spinner.hidesWhenStopped = true
        return spinner
    }()

    var frameWidthCalculated: CGFloat {
        return spinner.frame.size.width + messageLabel.frame.size.width
    }

    override init(frame: CGRect) {

        super.init(frame: frame)

     //   self.backgroundColor = UIColor(displayP3Red: 1, green: 0.85, blue: 0.1, alpha: 0.8)
        self.layer.cornerRadius = 6.0

        self.setupSubviews()
    }
    
//    deinit {
//        self.removeFromSuperview()
//    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        
        messageLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 7).isActive = true
        spinner.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -7).isActive = true
        spinner.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        self.backgroundColor = .red
        self.layer.borderWidth = 3.0
        self.layer.borderColor = UIColor.white.cgColor
        


        
       // spinner.pin.left().top().size(50.0.scaled)
      //  messageLabel.pin.after(of: spinner, aligned: .center).sizeToFit()
//        if let superview = self.superview {
//            self.center = superview.center
//        }
        
    }

//    func calculatedSize() -> CGSize {
//        let width = messageLabel.frame.maxX + 10.0
//        let height = spinner.frame.maxY
//
//        return CGSize(width: width, height: height)
//    }

    private func setupSubviews() {
        spinner.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(spinner)
        self.addSubview(messageLabel)
     //   self.backgroundColor = .systemYellow
        //self.layer.opacity = 0.7
    }

    func start() {
        spinner.startAnimating()
    }

    func stop() {
        spinner.stopAnimating()
    }
}
