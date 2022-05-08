import UIKit

internal enum StoryboardScene {

    internal enum Add: StoryboardType {
        internal static let storyboardName = "Add"
        internal static let initialScene = InitialSceneType<UIKit.UINavigationController>(storyboard: Add.self)
        internal static let add = SceneType<CoreDataTest.AddViewController>(storyboard: Add.self, identifier: "Add")
    }
}

protocol StoryboardType {

    static var storyboardName: String { get }
}

extension StoryboardType {

    static var storyboard: UIStoryboard {
        let name = self.storyboardName
        return UIStoryboard(name: name, bundle: Bundle.main)
    }
}

internal struct InitialSceneType<T: UIViewController> {
    internal let storyboard: StoryboardType.Type

    internal func instantiate() -> T {
        guard let controller = storyboard.storyboard.instantiateInitialViewController() as? T else {
            fatalError("ViewController is not of the expected class \(T.self).")
        }
        return controller
    }

    @available(iOS 13.0, tvOS 13.0, *)
    internal func instantiate(creator block: @escaping (NSCoder) -> T?) -> T {
        guard let controller = storyboard.storyboard.instantiateInitialViewController(creator: block) else {
            fatalError("Storyboard \(storyboard.storyboardName) does not have an initial scene.")
        }
        return controller
    }
}

internal struct SceneType<T: UIViewController> {
    internal let storyboard: StoryboardType.Type
    internal let identifier: String

    internal func instantiate() -> T {
        let identifier = self.identifier
        guard let controller = storyboard.storyboard.instantiateViewController(withIdentifier: identifier) as? T else {
            fatalError("ViewController '\(identifier)' is not of the expected class \(T.self).")
        }
        return controller
    }

    @available(iOS 13.0, tvOS 13.0, *)
    internal func instantiate(creator block: @escaping (NSCoder) -> T?) -> T {
        return storyboard.storyboard.instantiateViewController(identifier: identifier, creator: block)
    }
}
