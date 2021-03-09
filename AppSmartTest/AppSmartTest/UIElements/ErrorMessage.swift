//
//  ErrorMessage.swift
//  AppSmartTest
//
//  Created by Vitaly Khomatov on 06.03.2021.
//

import UIKit

class ErrorMessage: UIView {

    private var parentView = UIView()
    private var errorMessageView = UIView()
    private var errorMessageLabel = UILabel()

    convenience init(view: UIView) {
        self.init()
        parentView = view
        setupSubviews()
        layout()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    private func setupSubviews() {
        errorMessageView = UIView(frame: CGRect(x: 3 , y: -60, width: parentView.frame.width-6, height: 60))
        errorMessageView.center.x = parentView.center.x
        errorMessageView.backgroundColor = .red
        errorMessageView.layer.cornerRadius = 6
        parentView.addSubview(errorMessageView)
        
        errorMessageLabel = UILabel(frame: .zero)
        errorMessageLabel.lineBreakMode = .byWordWrapping
        errorMessageLabel.textAlignment = .center
        errorMessageLabel.text = "Loading message ..."
        errorMessageLabel.numberOfLines = 0
        errorMessageLabel.font = .systemFont(ofSize: 15, weight: .medium)
        errorMessageLabel.textColor = .white
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        errorMessageView.addSubview(errorMessageLabel)
    }
    
    private func layout() {
        errorMessageLabel.topAnchor.constraint(equalTo: errorMessageView.topAnchor, constant: 5.0).isActive = true
        errorMessageLabel.bottomAnchor.constraint(equalTo: errorMessageView.bottomAnchor, constant: -5.0).isActive = true
        errorMessageLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 22).isActive = true
        errorMessageLabel.leftAnchor.constraint(equalTo: errorMessageView.leftAnchor, constant: 5.0).isActive = true
        errorMessageLabel.rightAnchor.constraint(equalTo: errorMessageView.rightAnchor, constant: -5.0).isActive = true
    }
    
    
    private func animationView(reverse: Bool, duration: Double, delay: Double,  offsetY: CGFloat, opacity: Float) {
        UIView.animate(withDuration: duration, delay: 0.2, options: .curveEaseOut, animations: { [weak self] in
                        guard let self = self else { return }
                        self.errorMessageView.frame = self.errorMessageView.frame.offsetBy(dx: 0, dy: offsetY)
                        self.errorMessageView.layer.opacity = opacity }) { (finish) in
            if reverse {
                UIView.animate(withDuration: duration, delay: delay, options: .curveEaseIn, animations: { [weak self] in
                                guard let self = self else { return }
                                self.errorMessageView.frame = self.errorMessageView.frame.offsetBy(dx: 0, dy: offsetY * -1)
                                self.errorMessageView.layer.opacity = opacity }) { (finish) in
                    self.errorMessageView.removeFromSuperview()
                }
            }
        }
    }
    
    func showError(reverse: Bool, message: String, delay: Double) {
        self.errorMessageLabel.text = message
        self.animationView(reverse: reverse, duration: 1.0, delay: delay, offsetY: 54.0, opacity: 1.0)
    }
    
}
