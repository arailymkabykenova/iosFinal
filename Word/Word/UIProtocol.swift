//
//  UIProtocol.swift
//  Word
//
//  Created by Арайлым Кабыкенова on 18.12.2025.
//

import UIKit

protocol UIViewExtension {
    func updateUI(_ object: UIView)
}

extension UIViewExtension {
    func updateUI(_ object: UIView) {
        object.backgroundColor = .black
        object.layer.cornerRadius = 8
        object.clipsToBounds = true
        
        if let button = object as? UIButton {
            button.layer.cornerRadius = 8
            button.clipsToBounds = true
            button.titleLabel?.font = UIFont(name: "STIXTwoText-Bold", size: 20)
            button.backgroundColor = .white
            button.setTitleColor(.black, for: .normal)
        }
    }
    
    func styleAllButtons(_ buttons: [UIButton]) {
        buttons.forEach { updateUI($0) }
    }
    
    func styleAllViews(_ views: [UIView]) {
        views.forEach { updateUI($0) }
    }
}
