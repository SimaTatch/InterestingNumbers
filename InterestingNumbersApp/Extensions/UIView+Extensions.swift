//
//  UIView+Extensions.swift
//  InterestingNumbersApp
//
//  Created by Серафима  Татченкова  on 08.05.2022.
//

import Foundation
import UIKit

extension UIView {
    func addShadowOnView() {
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15).cgColor
        layer.masksToBounds = false
        layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 4
    }

}