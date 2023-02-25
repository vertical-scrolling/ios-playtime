import UIKit

public class PTRatingView: UIView {
    private enum Constants {
        static let numberOfRatingSquares: Int = 5
        static let ratingSquareSize: CGFloat = 10
    }

    public var rating: Int? {
        didSet {
            setupSubviews()
        }
    }

    private var ratingLabel: PTLabel = {
        let label = PTLabel()
        label.style = .pt2XS
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var ratingSummary: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        ratingsSquareViews.forEach {
            view.addArrangedSubview($0)
        }
        view.spacing = 2
        view.alignment = .center
        return view
    }()

    private lazy var ratingsSquareViews: [UIView] = {
        (1...Constants.numberOfRatingSquares).map { _ in
            Self.generateRatingSquareView()
        }
    }()

    private static func generateRatingSquareView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: Constants.ratingSquareSize).isActive = true
        view.widthAnchor.constraint(equalToConstant: Constants.ratingSquareSize).isActive = true
        return view
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(ratingLabel)
        addSubview(ratingSummary)
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: ratingSummary.leadingAnchor),
            topAnchor.constraint(equalTo: ratingLabel.topAnchor),
            bottomAnchor.constraint(equalTo: ratingLabel.bottomAnchor),
            ratingLabel.leadingAnchor.constraint(equalTo: ratingSummary.trailingAnchor,
                                                 constant: 7),
            ratingLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            ratingSummary.centerYAnchor.constraint(equalTo: ratingLabel.centerYAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension PTRatingView {
    func setupSubviews() {
        ratingSummary.arrangedSubviews.forEach {
            $0.backgroundColor = .lightGray
        }
        guard let rating = rating else {
            ratingLabel.text = nil
            return
        }
        ratingLabel.text = String(rating)
    }
}
