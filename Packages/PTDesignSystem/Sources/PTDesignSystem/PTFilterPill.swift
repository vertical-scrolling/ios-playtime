//
//  PTPillButton.swift
//  
//
//  Created by Martín Sande on 25/2/23.
//

import UIKit

public final class PTPillButton: UIButton {

    override public var isSelected: Bool {
        didSet {
            configuration?.background.strokeWidth = isSelected ? 2 : 0
            configuration?.background.strokeColor = isSelected ? UIColor.white : nil
            updateConfiguration()
        }
    }

    public convenience init(title: String?,
                            actionHandler: (() -> Void)? = nil) {
        var configuration = UIButton.Configuration.filled()
        configuration.cornerStyle = .capsule // 2
        configuration.baseBackgroundColor = .greenApp
        configuration.buttonSize = .large
        configuration.titleAlignment = .center
        self.init(configuration: configuration)
        addAction(UIAction { [weak self] _ in
            self?.isSelected.toggle()
            actionHandler?()
        }, for: .touchUpInside)
        setTitle(title)
    }

    public func setTitle(_ title: String?) {
        let titleLabel = PTLabel()
        var style: PTLabelStyle = .ptM
        titleLabel.style = style.withWeight(.light)
        titleLabel.text = title
        titleLabel.textColor = .blackMain
        configuration?.attributedTitle = AttributedString(titleLabel.attributedText ?? NSAttributedString(string: ""))
        updateConfiguration()
    }
}
