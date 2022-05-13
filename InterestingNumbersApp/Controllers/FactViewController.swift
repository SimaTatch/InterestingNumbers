
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
        label.textAlignment = .left
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
    
    private let labelAndTextFieldStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 10.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    //    MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        if numberFromTextField == "" {
            numberFromTextField = "random"
        }
        
        //        MARK: - Eсли пользователь вводит диапазон чисел или пару чисел
        if numberFromTextField.contains("..") || numberFromTextField.contains(",") {
            self.networkDataFetcher.fetchRange(number: numberFromTextField, type: "") { (result) in
                let sortedResult = result?.sorted(by: { lhs, rhs in
                    lhs.key < rhs.key })
                let keys = sortedResult?.map({$0.key}).joined(separator: ",")
                let resultString = sortedResult?.map({$0.value}).joined(separator: ",\n")
                if let currentNumb = keys {
                    self.numberLabel.text = currentNumb
                } else {
                    self.numberLabel.text = "🥲"
                }
                if let currentValue = resultString {
                    self.factLabel.text = currentValue
                } else {
                    self.factLabel.text = "Something went wrong.\n Please, try a different number/date format."
                }
            }
            return
        }
        
        //        MARK: - Eсли пользователь вводит дату или число
        self.networkDataFetcher.fetchFacts(number: numberFromTextField, type: type) { result in
            DispatchQueue.main.async {
                print("type:\(self.type)")
                print("number:\(String(describing:self.numberFromTextField))")
                switch result {
                case .Success(let success):
                    self.numberLabel.text = String(describing:success.number!)
                    self.factLabel.text = success.text
                case .Error(let _):
                    self.numberLabel.text =  "🥲"
                    self.factLabel.text = "Something went wrong.\n Please, try a different number/date format."
                default:
                    break
                }
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
        view.addSubview(labelAndTextFieldStackView)
        
        labelAndTextFieldStackView.addArrangedSubview(numberLabel)
        labelAndTextFieldStackView.addArrangedSubview(factLabel)
    }
}


extension FactViewController {
    
    //    MARK: - SetupConstraints
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            factLabel.heightAnchor.constraint(equalToConstant: 290)
        ])
        
        NSLayoutConstraint.activate([
            numberLabel.heightAnchor.constraint(equalToConstant: 38)
        ])
        
        NSLayoutConstraint.activate([
            labelAndTextFieldStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 88),
            labelAndTextFieldStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            labelAndTextFieldStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            exitButton.widthAnchor.constraint(equalToConstant: 24),
            exitButton.heightAnchor.constraint(equalToConstant: 22),
            exitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 334),
            exitButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 60)
        ])
    }
}



