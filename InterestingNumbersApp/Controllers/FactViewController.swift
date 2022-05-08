//
//  FactViewController.swift
//  InterestingNumbersApp
//
//  Created by Серафима  Татченкова  on 08.05.2022.
//

import Foundation
import UIKit

class FactViewController: UIViewController, ViewControllerCustomDelegate {
    
    func factAbout(number: Int) {
        DispatchQueue.main.async {
            self.numberLabel.text = String(number)
        }
    }
    
    
    func numberFact(fact: String) {
        DispatchQueue.main.async {
            self.factLabel.text = fact
        }
    }
    
    
    private let numberLabel: UILabel = {
        let label = UILabel()
//        label.text = "100000"
        label.textAlignment = .center
        label.font = .openSansBold28()
        label.textColor = .white
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.lineBreakMode = .byClipping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private let factLabel: UILabel = {
        let label = UILabel()
//        label.text = "The word \"hundred\" is actually derived from the Old Norse word \"hundrath,\" which actually means 120, not 100. More specifically, \"hundrath,\" in Old Norse, means \"long hundred,\" which equals 120, due to the duodecimal system. But good luck trying to argue that your $100 bill is worth 20 percent more than it is."
        label.font = .openSansSemiBold16()
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.29
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let exitButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "close"), for: .normal)
//        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(exitButtonIsPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    @objc func exitButtonIsPressed(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func setupViews() {
        view.backgroundColor = .specialPurple
        view.addSubview(factLabel)
        view.addSubview(numberLabel)
        view.addSubview(exitButton)
    }
}
extension FactViewController {
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            factLabel.widthAnchor.constraint(equalToConstant: 327),
            factLabel.heightAnchor.constraint(equalToConstant: 238),
            factLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            factLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150)
        ])
        
        NSLayoutConstraint.activate([
            numberLabel.widthAnchor.constraint(equalToConstant: 48),
            numberLabel.heightAnchor.constraint(equalToConstant: 38),
            numberLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 163),
            numberLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 88)
        ])
        
        NSLayoutConstraint.activate([
            exitButton.widthAnchor.constraint(equalToConstant: 24),
            exitButton.heightAnchor.constraint(equalToConstant: 22),
            exitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 334),
            exitButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 60)
        ])
    }
}
