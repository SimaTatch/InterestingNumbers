//
//  UIButton+Extension.swift
//  InterestingNumbersApp
//
//  Created by Серафима  Татченкова  on 09.05.2022.
//

import Foundation
import UIKit





extension UIButton {
    func setUpCustomButton() {
        titleLabel?.font = .openSansSemiBold13()
        setTitleColor(.black, for: .normal)
        titleLabel?.textAlignment = .center
        backgroundColor = .specialBackground
        titleLabel?.numberOfLines = 2
        layer.cornerRadius = 6
        layer.borderWidth = 1
        layer.borderColor = UIColor.specialBoarderColor.cgColor
        translatesAutoresizingMaskIntoConstraints = false
    }
}
