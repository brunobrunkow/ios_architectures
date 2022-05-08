import Foundation

public typealias LoadableIdentifiable = ReuseIdentifiable & NibLoadable

public protocol ReuseIdentifiable: AnyObject {

    static var reuseIdentifier: String { get }
}

public extension ReuseIdentifiable {

    static var reuseIdentifier: String {
        String(describing: self)
    }
}
