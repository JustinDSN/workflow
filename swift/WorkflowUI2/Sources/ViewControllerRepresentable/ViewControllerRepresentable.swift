public protocol ScreenViewControllerRepresentable {
    associatedtype ScreenViewControllerType: UIViewController
    typealias Context = ScreenViewControllerRepresentableContext<Self>

    func makeScreenViewController(context: Self.Context) -> Self.ScreenViewControllerType
    func updateScreenViewController(_ screenViewController: Self.ScreenViewControllerType, context: Self.Context)
}

public struct ScreenViewControllerRepresentableContext<Representable> where Representable : ScreenViewControllerRepresentable {

    var environment: EnvironmentValues
}

extension ScreenViewControllerRepresentableContext {
    struct EnvironmentValues {}
}
