import Foundation
import UIKit

extension UIView {
    static func initForAutolayout() -> Self {
        let view = Self.init(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }

    func addSubviews(_ views: [UIView]) {
        views.forEach { addSubview($0) }
    }

    func fitToSuperview() {
        guard let superview = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            topAnchor.constraint(equalTo: superview.topAnchor),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor)
        ])
    }

    func fitToSuperview(with insets: UIEdgeInsets) {
        guard let superview = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: insets.left),
            topAnchor.constraint(equalTo: superview.topAnchor, constant: insets.top),
            superview.trailingAnchor.constraint(equalTo: trailingAnchor, constant: insets.right),
            superview.bottomAnchor.constraint(equalTo: bottomAnchor, constant: insets.bottom)
        ])
    }

    /// Center current view to super.view if exists. Can add margin vertical and horizontal margin.
    ///
    /// - Parameters:
    ///   - verticalSpacing: Margins for top and bottom. Must be grather than 0
    ///   - horizontalSpacing: Margins for leading and trailing. Must be grather than 0
    func centerToSuperview(verticalSpacing: CGFloat = 0, horizontalSpacing: CGFloat = 0) {
        guard let superview = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: superview.centerXAnchor),
            centerYAnchor.constraint(equalTo: superview.centerYAnchor),
            superview.widthAnchor.constraint(greaterThanOrEqualTo: widthAnchor, constant: horizontalSpacing),
            superview.heightAnchor.constraint(greaterThanOrEqualTo: heightAnchor, constant: verticalSpacing)
        ])
    }
}

/// Warning on method usage
///    - `Considerations`: If the content of the wrapped value have a class reference, this init will show an error and the wrapped value will need
///    a lazy init instead. However, if the wrapped value has a #selector pointing to the class, it will not pop any error
///    but the feature won't work properly
@propertyWrapper
struct InitForAutoLayout<T: UIView> {
    public var wrappedValue: T {
        didSet {
            wrappedValue.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    public init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
        self.wrappedValue.translatesAutoresizingMaskIntoConstraints = false
    }
}

/// Warning on method usage
///    - `Considerations`: If the content of the wrapped value have a class reference, this init will show an error and the wrapped value will need
///    a lazy init instead. However, if the wrapped value has a #selector pointing to the class, it will not pop any error
///    but the feature won't work properly
@propertyWrapper
struct InitForLazyAutoLayout<T: UIView> {
    private enum Lazy<T> {
        case uninitialized(() -> T)
        case initialized(T)
    }

    private var _value: Lazy<T>
    public var wrappedValue: T {
        mutating get {
            defer { translateAutoresizingMaskIntoConstraints() }
            switch _value {
            case .uninitialized(let initializer):
                let value = initializer()
                _value = .initialized(value)
                return value
            case .initialized(let value):
                return value
            }
        }
        set {
            _value = .initialized(newValue)
            translateAutoresizingMaskIntoConstraints()
        }
    }

    public init(wrappedValue: @autoclosure @escaping () -> T) {
        _value = .uninitialized(wrappedValue)
    }

    private func translateAutoresizingMaskIntoConstraints() {
        if case let .initialized(value) = _value {
            value.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}
