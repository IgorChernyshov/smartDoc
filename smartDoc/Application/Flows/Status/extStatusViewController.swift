//
//  extStatusViewController.swift
//  smartDoc
//
//  Created by MacBook-Игорь on 31/03/2019.
//  Copyright © 2019 Igor Chernyshov. All rights reserved.
//

import UIKit

extension StatusViewController {
    
    var popUpView: UIView {
        return UIView()
    }
    
    func showPopUp() {
        print("SHow ")
        self.view.addSubview(popUpView)
        self.view.bringSubviewToFront(popUpView)
        popUpView.backgroundColor = .red
        popUpView.translatesAutoresizingMaskIntoConstraints = false
        
        popUpView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        popUpView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        popUpView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        popUpView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
    }
}

extension UIView {
    
    func fillSuperView(top: NSLayoutYAxisAnchor, leading: NSLayoutXAxisAnchor, trailing: NSLayoutXAxisAnchor, bottom: NSLayoutYAxisAnchor) {
        
//        guard let superviewTop = self.superview?.topAnchor, let superviewLeading = self.superview?.leadingAnchor, let superviewTrailing = self.superview?.trailingAnchor, let superviewBottom = self.superview?.bottomAnchor else {return}
        
//        self.translatesAutoresizingMaskIntoConstraints = false
//
//        self.topAnchor.constraint(equalTo: top, constant: 0).isActive = true
//        self.leadingAnchor.constraint(equalTo: leading, constant: 0).isActive = true
//        self.trailingAnchor.constraint(equalTo: trailing, constant: 0).isActive = true
//        self.bottomAnchor.constraint(equalTo: bottom, constant: 0).isActive = true

    }
}
