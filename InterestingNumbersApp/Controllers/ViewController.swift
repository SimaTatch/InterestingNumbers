
import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    
    //MARK: - Labels
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
    
    private let enterHereLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter here"
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Image
    private let diceImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "bg image")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Buttons
    private let userNumberButton: UIButton = {
        let button = UIButton()
        button.setTitle("User\n number", for: .normal)
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
    
    //MARK: - TextField
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
    
    // MARK: - StackViews
    private let buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 9.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let labelAndTextFieldStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 3.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let commonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 15.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    //    MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        addSubviews()
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
            enterHereTextField.placeholder = "ex: a date(4/20) or a number(42)"
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
        
        navigationController.modalPresentationStyle = .pageSheet
        present(navigationController, animated: true)
    }
    
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
        view.addSubview(buttonsStackView)
        view.addSubview(labelAndTextFieldStackView)
        view.addSubview(commonStackView)
    }
    
    private func addSubviews() {
        buttonsStackView.addArrangedSubview(userNumberButton)
        buttonsStackView.addArrangedSubview(multiplyNumbersButton)
        buttonsStackView.addArrangedSubview(randomNumberButton)
        buttonsStackView.addArrangedSubview(numberInRangeButton)
        
        labelAndTextFieldStackView.addArrangedSubview(enterHereLabel)
        labelAndTextFieldStackView.addArrangedSubview(enterHereTextField)
        
        commonStackView.addArrangedSubview(buttonsStackView)
        commonStackView.addArrangedSubview(labelAndTextFieldStackView)
        commonStackView.addArrangedSubview(displayFactButton)
    }
    
    private func deselectAllButtons(){
        enterHereTextField.resignFirstResponder()
        enterHereTextField.placeholder = ""
        for subView in buttonsStackView.arrangedSubviews
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
            userNumberButton.widthAnchor.constraint(equalToConstant: self.view.frame.width / 4),
            userNumberButton.heightAnchor.constraint(equalToConstant: self.view.frame.height / 4)
        ])
        
        NSLayoutConstraint.activate([
            randomNumberButton.widthAnchor.constraint(equalToConstant: self.view.frame.width / 4),
            randomNumberButton.heightAnchor.constraint(equalToConstant: self.view.frame.height / 4)
        ])
        
        NSLayoutConstraint.activate([
            numberInRangeButton.widthAnchor.constraint(equalToConstant: self.view.frame.width / 4),
            numberInRangeButton.heightAnchor.constraint(equalToConstant: self.view.frame.height / 4)
        ])
        
        NSLayoutConstraint.activate([
            multiplyNumbersButton.widthAnchor.constraint(equalToConstant: self.view.frame.width / 4),
            multiplyNumbersButton.heightAnchor.constraint(equalToConstant: self.view.frame.height / 4)
        ])
        
        NSLayoutConstraint.activate([
            buttonsStackView.heightAnchor.constraint(equalToConstant: 74)
        ])
        
        NSLayoutConstraint.activate([
            enterHereLabel.heightAnchor.constraint(equalToConstant: 21)
        ])
        
        NSLayoutConstraint.activate([
            enterHereTextField.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        NSLayoutConstraint.activate([
            displayFactButton.heightAnchor.constraint(equalToConstant: 42),
            displayFactButton.topAnchor.constraint(equalTo: labelAndTextFieldStackView.bottomAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            commonStackView.topAnchor.constraint(equalTo: diceImage.bottomAnchor, constant: 49),
            commonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            commonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
}

extension ViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard string != "" else {return true}
        return shoudAddCharecterToDashField(string: string, previousText: enterHereTextField.text)
    }
    
    func shoudAddCharecterToDashField(string: String, previousText: String?) -> Bool {
        
        let containsComma = previousText?.contains(",") ?? false
        let containsDots = previousText?.contains("..") ?? false
        let containsDash = previousText?.contains("/") ?? false
        if previousText != "" { //already have text
            if ((!containsDots && string == ".") || (!containsDash && string == "/"))
                && ((!containsDash && string == ".") || (!containsDots && string == "/")) {
                return true
            }
            if (!containsDash && string == ",") && (!containsComma && string == ","){
                return true
            }
            if string.count == 1 { // entering throught keyboard
                if let inputCh = string.last {
                    return inputCh.isNumber
                }
            } else { // paste
                return true
            }
        } else {
            return string.last?.isNumber ?? true
        }
        return true
    }
}


