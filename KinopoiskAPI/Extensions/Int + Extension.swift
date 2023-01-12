//
//  Int + Extension.swift
//  KinopoiskAPI
//
//  Created by Dmitriy Pavlov on 12.01.2023.
//

import Foundation

import Foundation

extension Int {
    func convertMinutes() -> (Int, Int) {
        let hour = self / 60
        let min = self % 60
        return (hour, min)
    }
}
