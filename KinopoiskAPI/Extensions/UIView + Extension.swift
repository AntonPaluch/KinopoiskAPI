//
//  UIView + Extension.swift
//  KinopoiskAPI
//
//  Created by Dmitriy Pavlov on 12.01.2023.
//

import UIKit

extension UIView {
    
    func addViews(_ views: [UIView]) {
        views.forEach({
            add($0)
        })
    }
    
    public func addViews(_ views: UIView...) {
        addViews(views)
    }
    
    func add(_ view: UIView) {
        addSubview(view)
    }
}

extension UIStackView {
    func addArrangedSubviews(_ views: [UIView]) {
        for view in views {
            addArrangedSubview(view)
        }
    }
}
