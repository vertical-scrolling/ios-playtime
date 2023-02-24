import UIKit

public class PTLabel: UILabel {
    public var style: PTLabelStyle = .ptM {
        didSet { setupFont() }
    }
    
    public override var text: String? {
        didSet {
            setupText(text)
        }
    }
    
    public override var attributedText: NSAttributedString? {
        didSet {
            setupAttributedText(attributedText)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFont()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupFont()
    }
    
    private func setupFont() {
        font = style.font
        setupAttributedText(attributedText)
    }
    
    private func setupText(_ text: String?) {
        guard let text = text else { return }
        let attributed = NSMutableAttributedString(string: text)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = textAlignment
        
        if numberOfLines == 1 {
            paragraphStyle.lineBreakMode = .byTruncatingTail
        }
        
        attributed.addAttribute(.paragraphStyle,
                                value: paragraphStyle,
                                range: NSRange(location: 0, length: text.count))
        
        attributedText = attributed
    }
    
    private func setupAttributedText(_ text: NSAttributedString?) {
        if style.textTransform == .uppercased,
           let text = text {
            let newString = NSMutableAttributedString(attributedString: text)
            newString.enumerateAttributes(in: NSRange(location: 0, length: newString.length), options: []) {_, range, _ in
                newString.replaceCharacters(in: range, with: (newString.string as NSString).substring(with: range).localizedUppercase)
            }
            
            super.attributedText = newString.with(kerning: style.kerning,
                                                  lineHeightMultiple: style.lineHeightMultiple)
        } else {
            super.attributedText = text?.with(kerning: style.kerning,
                                              lineHeightMultiple: style.lineHeightMultiple)
        }
    }
}

private extension NSAttributedString {
    func with(kerning: NSNumber,
              baselineOffset: CGFloat? = nil,
              lineHeightMultiple: CGFloat,
              font: UIFont? = nil) -> NSAttributedString {
        let mutableAttributedString = NSMutableAttributedString(attributedString: self)
        let range = NSRange(location: 0, length: length)
        
        mutableAttributedString.addAttribute(.kern,
                                             value: kerning,
                                             range: range)

        if let font = font {
            mutableAttributedString.addAttributes([.font: font], range: range)
        }
        
        enumerateAttribute(.paragraphStyle,
                           in: range,
                           options: .longestEffectiveRangeNotRequired) { (paragraphStyle, range, _) in
            let style = paragraphStyle as? NSParagraphStyle
            let newStyle = style?.mutableCopy() as? NSMutableParagraphStyle ?? NSMutableParagraphStyle()
            
            newStyle.alignment = style?.alignment ?? .natural
            
            var auxLineHeightMultiple = style?.lineHeightMultiple ?? lineHeightMultiple
            auxLineHeightMultiple = auxLineHeightMultiple != .zero ? auxLineHeightMultiple : lineHeightMultiple
            newStyle.lineHeightMultiple = auxLineHeightMultiple
            
            mutableAttributedString.addAttribute(.paragraphStyle,
                                                 value: newStyle,
                                                 range: range)
        }
        
        return mutableAttributedString
    }
}
