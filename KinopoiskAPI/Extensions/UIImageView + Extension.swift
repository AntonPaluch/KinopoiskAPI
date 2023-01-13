//
//  UIImageView + Extension.swift
//  KinopoiskAPI
//
//  Created by Dmitriy Pavlov on 12.01.2023.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImageFromUrl(imageUrl: String) {
        self.kf.indicatorType = .activity
        self.kf.setImage(with: URL(string: imageUrl),placeholder: Images.placeholder.placeholderFilms, options: [.transition(.fade(0.3))])
    }
}
