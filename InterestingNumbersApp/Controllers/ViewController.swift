
import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
  

//    MARK: - SetupUIs
    private let interestingNumbersLabel: UILabel = {
        let label = UILabel()
        label.text = "Interesting numbers"
        label.font = .openSansBold28()
        label.textColor = .specialNightRider
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "This App about facts of Numbers and Dates"
        label.font = .openSansLight16()
        label.textColor = .specialNightRider
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let diceImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "bg image")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    
    private let userNumberButton: UIButton = {
        let button = UIButton()
        button.setTitle("User number", for: .normal)
        button.addShadowOnView()
        button.setUpCustomButton()
        return button
    }()
    
    private let randomNumberButton: UIButton = {
        let button = UIButton()
        button.setTitle("Random number", for: .normal)
        button.setUpCustomButton()
        button.addShadowOnView()
        return button
    }()
    
    private let numberInRangeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Number in a range", for: .normal)
        button.setUpCustomButton()
        button.addShadowOnView()
        return button
    }()
    
    private let multiplyNumbersButton: UIButton = {
        let button = UIButton()
        button.setTitle("Multiple numbers", for: .normal)
        button.setUpCustomButton()
        button.addShadowOnView()
        return button
    }()
    
    
    
    private let enterHereLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter here"
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let enterHereTextField: UITextField = {
        let textField = UITextField()
        textField .frame = CGRect(x: 0, y: 0, width: 343, height: 44)
        textField .backgroundColor = .white
        textField .layer.backgroundColor = UIColor.specialMagnolia.cgColor
        textField .layer.cornerRadius = 6
        textField .layer.borderWidth = 1
        textField .layer.borderColor = UIColor.specialBoarderColor.cgColor
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let displayFactButton: UIButton = {
        let button = UIButton()
        button.setTitle("Display Fact", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .specialPurple
        button.titleLabel?.font = .openSansSemiBold18()
        button.titleLabel?.textAlignment = .center
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
//    MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        enterHereTextField.delegate = self

        displayFactButton.addTarget(self, action: #selector(displayFactButtonIsPressed), for: .touchUpInside)
        userNumberButton.addTarget(self, action: #selector(buttonIsPressed), for: .touchUpInside)
        multiplyNumbersButton.addTarget(self, action: #selector(buttonIsPressed), for: .touchUpInside)
        randomNumberButton.addTarget(self, action: #selector(buttonIsPressed), for: .touchUpInside)
        numberInRangeButton.addTarget(self, action: #selector(buttonIsPressed), for: .touchUpInside)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapRecognizer)
        tapRecognizer.delegate = self
    }
    
//    MARK: - Objective-c funcs
    @objc func tapped(gestureRecognizer: UIGestureRecognizer) {
        deselectAllButtons()
    }

    @objc func buttonIsPressed(sender: UIButton) {
        deselectAllButtons()
        
        sender.isSelected = true
        sender.backgroundColor = .specialPurple
        sender.setTitleColor(.white, for: .normal)
        
        enterHereTextField.placeholder = ""
        enterHereTextField.isEnabled = true
        enterHereTextField.becomeFirstResponder()
        
        switch sender {
        case userNumberButton:
            enterHereTextField.placeholder = "date(ex:4/20) or number(42)"
        case randomNumberButton:
            enterHereTextField.isEnabled = false
            enterHereTextField.placeholder = "random"
        case numberInRangeButton:
            enterHereTextField.placeholder = "ex: 1..3"
        default:
            break
        }

    }
    
    @objc func displayFactButtonIsPressed(sender: UIButton!) {
            
            enterHereTextField.resignFirstResponder()
        
            let detailVC = FactViewController()
            let navigationController = UINavigationController(rootViewController: detailVC)
        
            detailVC.numberFromTextField = enterHereTextField.text ?? ""
        
            switch true{
            case multiplyNumbersButton.isSelected:
                detailVC.type = "math"
            default:
                break
            }
       
        
        navigationController.modalPresentationStyle = .pageSheet
        present(navigationController, animated: true)
    }

        
        
 //        let factViewController = FactViewController()
 //        factViewController.numberLabel.text = enterHereTextField.text ?? "0"
 //        factViewController.modalPresentationStyle = .pageSheet
 //        self.navigationController?.pushViewController(factViewController, animated: true)
         
         
//        completionHandler?(enterHereTextField.text)
        
        
//        if let text = enterHereTextField.text,
//           let textToNumber = Int(text) {
//            DispatchQueue.main.async {
//                
//                self.delegate?.factAbout(number: textToNumber)
//            }
//        }
        

//        self.networkDataFetcher.fetchFacts(number: enterHereTextField.text ?? "", type: "math") { [weak self] (result) in
//            DispatchQueue.main.async {
//                self?.delegate?.numberFact(fact: result?.text ?? "")
//                self?.delegate?.factAbout(number: result?.number ?? 0)
//            }
//        }
        
//        let navController = UINavigationController(rootViewController: FactViewController())
//        self.present(navController, animated: true, completion: nil)
    
    
    
//    MARK: - Private funcs
    private func setupViews() {
        view.backgroundColor = .specialBackground
        view.addSubview(interestingNumbersLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(diceImage)
        view.addSubview(userNumberButton)
        view.addSubview(enterHereLabel)
        view.addSubview(enterHereTextField)
        view.addSubview(displayFactButton)
        view.addSubview(randomNumberButton)
        view.addSubview(multiplyNumbersButton)
        view.addSubview(numberInRangeButton)
    }
    
    private func deselectAllButtons(){
        enterHereTextField.resignFirstResponder()
        enterHereTextField.placeholder = ""
        for subView in view.subviews
          {
            if let button = subView as? UIButton, button != displayFactButton {
                button.isSelected = false
                button.backgroundColor = .specialBackground
                button.setTitleColor(.black, for: .normal)
                enterHereTextField.text = ""

            }
        }
    }
}

extension ViewController {
    
    //    MARK: - SetupConstraints
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            interestingNumbersLabel.heightAnchor.constraint(equalToConstant: 38),
            interestingNumbersLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            interestingNumbersLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 88)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.heightAnchor.constraint(equalToConstant: 53),
            descriptionLabel.widthAnchor.constraint(equalToConstant: 242),
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150)
        ])
        
        NSLayoutConstraint.activate([
            diceImage.heightAnchor.constraint(equalToConstant: 144),
            diceImage.widthAnchor.constraint(equalToConstant: 180),
            diceImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            diceImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 253)
        ])
        
        NSLayoutConstraint.activate([
            userNumberButton.widthAnchor.constraint(equalToConstant: 75),
            userNumberButton.heightAnchor.constraint(equalToConstant: 74),
            userNumberButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 19),
            userNumberButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 486)
        ])
        
        NSLayoutConstraint.activate([
            randomNumberButton.widthAnchor.constraint(equalToConstant: 75),
            randomNumberButton.heightAnchor.constraint(equalToConstant: 74),
            randomNumberButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 103),
            randomNumberButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 486)
        ])

        NSLayoutConstraint.activate([
            numberInRangeButton.widthAnchor.constraint(equalToConstant: 75),
            numberInRangeButton.heightAnchor.constraint(equalToConstant: 74),
            numberInRangeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 187),
            numberInRangeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 486)
        ])

        NSLayoutConstraint.activate([
            multiplyNumbersButton.widthAnchor.constraint(equalToConstant: 75),
            multiplyNumbersButton.heightAnchor.constraint(equalToConstant: 74),
            multiplyNumbersButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 271),
            multiplyNumbersButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 486)
        ])

        
        NSLayoutConstraint.activate([
            enterHereLabel.widthAnchor.constraint(equalToConstant: 79),
            enterHereLabel.heightAnchor.constraint(equalToConstant: 21),
            enterHereLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 19),
            enterHereLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 580)
        ])
        
        NSLayoutConstraint.activate([
//            enterHereTextField.widthAnchor.constraint(equalToConstant: 343),
            enterHereTextField.heightAnchor.constraint(equalToConstant: 44),
            enterHereTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            enterHereTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            enterHereTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 606)
        ])
        
        NSLayoutConstraint.activate([
//            displayFactButton.widthAnchor.constraint(equalToConstant: 343),
            displayFactButton.heightAnchor.constraint(equalToConstant: 52),
            displayFactButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            displayFactButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            displayFactButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 670)
        ])
    }
}

extension ViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        guard string != "" else {return true}
        return onlyNums(string: string)
    }
    
    func onlyNums(string: String) -> Bool {
        let leftSideField = CharacterSet(charactersIn: "0123456789./")
        let rightSideField = CharacterSet(charactersIn: string)
        return leftSideField.isSuperset(of: rightSideField)
    }
}

