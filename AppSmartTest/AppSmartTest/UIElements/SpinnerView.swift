//
//  SpinnerView.swift
//  AppSmartTest
//
//  Created by Vitaly Khomatov on 03.03.2021.
//

import UIKit


class SpinnerView: UIView {

    private lazy var messageLabel: UILabel = {
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
        return spinner
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupSubviews()
        layout()
    }
    
    private func layout() {
        messageLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 7).isActive = true
        spinner.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -7).isActive = true
        spinner.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }

    private func setupSubviews() {
        spinner.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .red
        self.layer.borderWidth = 3.0
        self.layer.cornerRadius = 6.0
        self.layer.borderColor = UIColor.white.cgColor
        self.addSubview(spinner)
        self.addSubview(messageLabel)
    }

    func start() {
        spinner.startAnimating()
    }

    func stop() {
        spinner.stopAnimating()
    }
}
