//
//  PTFilterPill.swift
//  
//
//  Created by Martín Sande on 25/2/23.
//

import UIKit

public final class PTFilterPill: UIButton {

    override public var isSelected: Bool {
        didSet {
            configuration?.background.strokeWidth = isSelected ? 2 : 0
            configuration?.background.strokeColor = isSelected ? UIColor.white : nil
            updateConfiguration()
        }
    }

    convenience init(title: String?, actionHandler: @escaping () -> Void) {
        var configuration = UIButton.Configuration.filled()
        configuration.cornerStyle = .capsule // 2
        configuration.baseBackgroundColor = .greenApp
        configuration.buttonSize = .large
        let titleLabel = PTLabel()
        var style: PTLabelStyle = .ptM
        titleLabel.style = style.withWeight(.light)
        titleLabel.text = title
        titleLabel.textColor = .blackMain
        configuration.attributedTitle = AttributedString(titleLabel.attributedText ?? NSAttributedString(string: ""))
        configuration.titleAlignment = .center
        self.init(configuration: configuration)
        addAction(UIAction { [weak self] _ in
            self?.isSelected.toggle()
            actionHandler()
        }, for: .touchUpInside)
    }
}
