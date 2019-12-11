import Foundation
import WorkflowUI2

struct MyScreen: Screen {
    var name: String
    var onNameChanged: (String) -> Void
    var onLoginTapped: () -> Void
}

extension MyScreen: ScreenViewControllerRepresentable {
    func makeScreenViewController(context: ScreenViewControllerRepresentableContext<MyScreen>) -> MyScreenViewController {
        return MyScreenViewController(screen: self)
    }

    func updateScreenViewController(_ screenViewController: MyScreenViewController, context: ScreenViewControllerRepresentableContext<MyScreen>) {
        screenViewController.update(with: self)
    }
}

final class MyScreenViewController: UIViewController {
    var screen: MyScreen {
        didSet {
            update(with: screen)
        }
    }

    let welcomeLabel: UILabel
    let nameField: UITextField
    let button: UIButton

    required init(screen: MyScreen) {
        self.screen = screen

        welcomeLabel = UILabel(frame: .zero)
        nameField = UITextField(frame: .zero)
        button = UIButton(frame: .zero)

        super.init(nibName: nil, bundle: nil)

        update(with: screen)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        welcomeLabel.text = "Welcome! Please Enter Your Name"
        welcomeLabel.textAlignment = .center

        nameField.backgroundColor = UIColor(white: 0.92, alpha: 1.0)
        nameField.addTarget(self, action: #selector(textDidChange(sender:)), for: .editingChanged)

        button.backgroundColor = UIColor(red: 41/255, green: 150/255, blue: 204/255, alpha: 1.0)
        button.setTitle("Login", for: .normal)
        button.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)

        view.addSubview(welcomeLabel)
        view.addSubview(nameField)
        view.addSubview(button)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let inset: CGFloat = 12.0
        let height: CGFloat = 44.0
        var yOffset = (view.bounds.size.height - (2 * height + inset)) / 2.0

        welcomeLabel.frame = CGRect(
            x: view.bounds.origin.x,
            y: view.bounds.origin.y,
            width: view.bounds.size.width,
            height: yOffset)

        nameField.frame = CGRect(
            x: view.bounds.origin.x,
            y: yOffset,
            width: view.bounds.size.width,
            height: height)
            .insetBy(dx: inset, dy: 0.0)

        yOffset += height + inset
        button.frame = CGRect(
            x: view.bounds.origin.x,
            y: yOffset,
            width: view.bounds.size.width,
            height: height)
            .insetBy(dx: inset, dy: 0.0)
    }

    func update(with screen: MyScreen) {
        nameField.text = screen.name
    }

    @objc private func textDidChange(sender: UITextField) {
        guard let text = sender.text else {
            return
        }
        screen.onNameChanged(text)
    }

    @objc private func buttonTapped(sender: UIButton) {
        screen.onLoginTapped()
    }
}



