
import UIKit

protocol ViewControllerCustomDelegate: AnyObject {
    func numberFact(fact: String)
    func factAbout(number: Int)
}

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var networkDataFetcher = NetworkDataFetcher()
    
    weak var delegate: ViewControllerCustomDelegate? // FactViewController
    
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
        button.titleLabel?.font = .openSansSemiBold13()
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .specialBackground
        button.titleLabel?.numberOfLines = 2
        button.layer.cornerRadius = 6
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.specialBoarderColor.cgColor
        button.addShadowOnView()
        button.translatesAutoresizingMaskIntoConstraints = false
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
        displayFactButton.addTarget(self, action: #selector(displayFactButtonIsPressed), for: .touchUpInside)
        userNumberButton.addTarget(self, action: #selector(buttonIsPressed), for: .touchUpInside)
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapRecognizer)
        tapRecognizer.delegate = self
    }
    
//    MARK: - Objective-c funcs
    @objc func tapped(gestureRecognizer: UIGestureRecognizer) {
        refreshButtonState()
    }
    @objc func buttonIsPressed(sender: UIButton!) {
        sender.backgroundColor = .specialPurple
        sender.setTitleColor(.white, for: .normal)
    }
    @objc func displayFactButtonIsPressed(sender: UIButton!) {
        let navController = UINavigationController(rootViewController: FactViewController())
        
        self.networkDataFetcher.fetchFacts(number: enterHereTextField.text ?? "", type: "math") { [weak self] (result) in
            DispatchQueue.main.async {
                self?.delegate?.numberFact(fact: result?.text ?? "")
                self?.delegate?.factAbout(number: result?.number ?? 0)
            }
        }
        enterHereTextField.resignFirstResponder()
        self.present(navController, animated: true, completion: nil)
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
    }
    
    private func refreshButtonState() {
        userNumberButton.backgroundColor = .specialBackground
        userNumberButton.setTitleColor(.black, for: .normal)
        enterHereTextField.resignFirstResponder()
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
            enterHereLabel.widthAnchor.constraint(equalToConstant: 79),
            enterHereLabel.heightAnchor.constraint(equalToConstant: 21),
            enterHereLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 19),
            enterHereLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 580)
        ])
        
        NSLayoutConstraint.activate([
            enterHereTextField.widthAnchor.constraint(equalToConstant: 343),
            enterHereTextField.heightAnchor.constraint(equalToConstant: 44),
            enterHereTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            enterHereTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 606)
        ])
        
        NSLayoutConstraint.activate([
            displayFactButton.widthAnchor.constraint(equalToConstant: 343),
            displayFactButton.heightAnchor.constraint(equalToConstant: 52),
            displayFactButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            displayFactButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 670)
        ])
    }
}


