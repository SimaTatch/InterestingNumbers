
import Foundation
import UIKit

class FactViewController: UIViewController{
    
    let networkDataFetcher = NetworkDataFetcher()
    var numberFromTextField = ""
    var type = ""
    
    
    //    MARK: - SetupUIs
    let numberLabel: UILabel = {
        let label = UILabel()
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
        button.addTarget(self, action: #selector(exitButtonIsPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //    MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        if numberFromTextField == "" {
            numberFromTextField = "random"
        }
        DispatchQueue.main.async { [self] in
            self.networkDataFetcher.fetchFacts(number: numberFromTextField, type: type) { (result) in
                print("type:\(type)")
                print("number:\(String(describing:numberFromTextField))")
                
                if let num = result?.number {
                    self.numberLabel.text = String(num)
                }
                self.factLabel.text = result?.text
            }
        }
    }
    
    //  MARK: - Objective-c funcs
    @objc func exitButtonIsPressed(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //    MARK: - Private funcs
    private func setupViews() {
        view.backgroundColor = .specialPurple
        view.addSubview(factLabel)
        view.addSubview(numberLabel)
        view.addSubview(exitButton)
    }
}


extension FactViewController {
    
    //    MARK: - SetupConstraints
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            factLabel.widthAnchor.constraint(equalToConstant: 327),
            factLabel.heightAnchor.constraint(equalToConstant: 238),
            factLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            factLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150)
        ])
        
        NSLayoutConstraint.activate([
//            numberLabel.widthAnchor.constraint(equalToConstant: 58),
            numberLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            numberLabel.heightAnchor.constraint(equalToConstant: 38),
            numberLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
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
