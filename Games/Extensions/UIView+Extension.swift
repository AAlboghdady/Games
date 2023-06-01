//
//  UIView+Extension.swift
//  Games
//
//  Created by Abdurrahman Alboghdady on 29/05/2023.
//

import UIKit

extension UIView {
    func round(_ cornerRadius: CGFloat? = nil) {
        layer.masksToBounds = true
        layer.cornerRadius = ((cornerRadius == nil) ? layer.frame.height / 2 : cornerRadius)!
    }
    
    func addBorder(color: UIColor = .gray, width: CGFloat = 1) {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
    }
}
