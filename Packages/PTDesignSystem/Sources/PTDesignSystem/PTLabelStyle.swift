import Foundation
import UIKit

public enum PTFontTextTransform {
    case none
    case uppercased
}

public enum PTFontFamily {
    case poppins
}

public enum PTFontWeight {
    case light
    case regular
    case medium
    case semibold
    case bold
}

public enum PTFontStretch: String {
    case normal
    case condensed
    case expanded
}

public enum PTFontSize {
    case size3XS
    case size2XS
    case sizeXS
    case sizeS
    case sizeM
    case sizeL
    case sizeXL
    case size2XL
    case size3XL
    case size4XL
    case size5XL
    case value(CGFloat)

    public var value: CGFloat {
        switch self {
        case .value(let value): return value
        case .size3XS: return 10
        case .size2XS: return 11
        case .sizeXS: return 12
        case .sizeS: return 13
        case .sizeM: return 14
        case .sizeL: return 15
        case .sizeXL: return 16
        case .size2XL: return 18
        case .size3XL: return 20
        case .size4XL: return 24
        case .size5XL: return 50
        }
    }
}

public struct PTLabelStyle {
    let size: PTFontSize
    let fontFamily: PTFontFamily = .poppins
    var weight: PTFontWeight
    let stretch: PTFontStretch?
    let lineHeight: CGFloat?
    let kerning: NSNumber
    let textTransform: PTFontTextTransform

    mutating public func withWeight(_ weight: PTFontWeight) -> Self {
        self.weight = weight
        return self
    }

    public init(size: PTFontSize,
                lineHeight: CGFloat? = nil,
                weight: PTFontWeight = .regular,
                stretch: PTFontStretch = .normal,
                kerning: NSNumber = 0,
                textTransform: PTFontTextTransform = .none) {
        self.size = size
        self.lineHeight = lineHeight
        self.weight = weight
        self.stretch = stretch
        self.kerning = kerning
        self.textTransform = textTransform
    }

    public var font: UIFont {
        switch (fontFamily, weight) {
        case (.poppins, .light):
            try? UIFont.registerFont(bundle: .module, fontName: "Poppins-Light", fontExtension: "ttf")
            return UIFont(name: "Poppins-Light", size: size.value)!
        case (.poppins, .regular):
            try? UIFont.registerFont(bundle: .module, fontName: "Poppins-Regular", fontExtension: "ttf")
            return UIFont(name: "Poppins-Regular", size: size.value)!
        case (.poppins, .medium):
            try? UIFont.registerFont(bundle: .module, fontName: "Poppins-Medium", fontExtension: "ttf")
            return UIFont(name: "Poppins-Medium", size: size.value)!
        case (.poppins, .semibold):
            try? UIFont.registerFont(bundle: .module, fontName: "Poppins-SemiBold", fontExtension: "ttf")
            return UIFont(name: "Poppins-SemiBold", size: size.value)!
        case (.poppins, .bold):
            try? UIFont.registerFont(bundle: .module, fontName: "Poppins-Bold", fontExtension: "ttf")
            return UIFont(name: "Poppins-Bold", size: size.value)!
        }
    }

    public var lineHeightMultiple: CGFloat {
        let fontLineHeight = font.lineHeight
        if let lineHeight = lineHeight, fontLineHeight > 0 {
            return lineHeight / fontLineHeight
        }
        return .zero
    }
}

// MARK: - Tokens
public extension PTLabelStyle {
    static let pt3XS: Self = .init(size: .size3XS,
                                   lineHeight: 12,
                                   kerning: 0.2)
    static let pt2XS: Self = .init(size: .size2XS,
                                   lineHeight: 15,
                                   kerning: 0.2)
    static let ptXS: Self = .init(size: .sizeXS,
                                  lineHeight: 14,
                                  kerning: 0.2)
    static let ptS: Self = .init(size: .sizeS,
                                 lineHeight: 15,
                                 kerning: 0.2)
    static let ptM: Self = .init(size: .sizeM,
                                  lineHeight: 16,
                                  kerning: 0.2)
    static let ptL: Self = .init(size: .sizeL,
                                 lineHeight: 18,
                                 kerning: 0.2)
    static let ptXL: Self = .init(size: .sizeXL,
                                  lineHeight: 19,
                                  kerning: 0.2)
    static let pt2XL: Self = .init(size: .size2XL,
                                   lineHeight: 21,
                                   kerning: 0.2)
    static let pt3XL: Self = .init(size: .size3XL,
                                   lineHeight: 23,
                                   kerning: 0.2)
    static let pt4XL: Self = .init(size: .size4XL,
                                   lineHeight: 28,
                                   kerning: 0.2)
    static let pt5XL: Self = .init(size: .size5XL,
                                   lineHeight: 60,
                                   kerning: 0.2)
}

private extension UIFont {
    enum FontError: Error {
        case noFontAvailable
        case corruptedFontData
        case wrongFormatFont
        case duplicatedFontRegistration
    }

    static func registerFont(bundle: Bundle, fontName: String, fontExtension: String) throws {
        guard let fontURL = bundle.url(forResource: fontName, withExtension: fontExtension) else {
            throw FontError.noFontAvailable
        }

        guard let fontDataProvider = CGDataProvider(url: fontURL as CFURL) else {
            throw FontError.corruptedFontData
        }

        guard let font = CGFont(fontDataProvider) else {
            throw FontError.wrongFormatFont
        }

        var error: Unmanaged<CFError>?
        guard CTFontManagerRegisterGraphicsFont(font, &error) else {
            throw error?.takeRetainedValue() ?? FontError.duplicatedFontRegistration
        }
    }
}
