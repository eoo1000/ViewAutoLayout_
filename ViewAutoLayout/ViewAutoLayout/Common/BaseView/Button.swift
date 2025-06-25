//
//  Button.swift
//  tabtap
//
//  Created by uniwiz on 2023/06/27.
//

import UIKit

class Button: UIButton {
    private weak var listener: ButtonActionListener? = nil
    private var _action: ((UIButton) -> Void)? = nil
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        if let label = self.titleLabel {
            label.widthAnchor.constraint(lessThanOrEqualTo: self.widthAnchor, multiplier: 1.0).isActive = true
        }
    }
    
    required init(imageName: String, selectImageName: String? = nil) {
        super.init(frame: .zero)
        self.setImage(UIImage(named: imageName), for: .normal)
        self.setImage(UIImage(named: selectImageName ?? imageName), for: .selected)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init(font: UIFont, textColor: UIColor, selectColor: UIColor? = nil, title: String, selectTitle: String? = nil, radius: CGFloat = 0, border: (color: UIColor, width: CGFloat) = (color: .black, width: 0)) {
        super.init(frame: .zero)
        
        self.configuration = UIButton.Configuration.plain()
        var attributedTitle = AttributedString(title)
        attributedTitle.font = font
        attributedTitle.foregroundColor = textColor
        self.configuration?.attributedTitle = attributedTitle
        self.layer.cornerRadius = radius
        self.layer.borderColor = border.color.cgColor
        self.layer.borderWidth = border.width
        self.tintColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let handler: UIButton.ConfigurationUpdateHandler = { button in
            switch button.state {
            case .selected:
                button.configuration?.title = selectTitle ?? title
                button.configuration?.attributedTitle?.font = font
                button.configuration?.attributedTitle?.foregroundColor = selectColor ?? textColor
            default:
                button.configuration?.title = title
                button.configuration?.attributedTitle?.font = font
                button.configuration?.attributedTitle?.foregroundColor = textColor
            }
        }
        self.configurationUpdateHandler = handler
        self.setPadding(aligment: .center)
    }
    
    required init(_ target: Any?, action: Selector, for controlEvents: UIControl.Event = .touchUpInside) {
        super.init(frame: .zero)
        self.addTarget(target, action: action, for: controlEvents)
    }
    
    required init(listener: ButtonActionListener) {
        super.init(frame: .zero)
        self.addTarget(self, action: #selector(onClick(sender:)), for: .touchUpInside)
        self.listener = listener
    }
    
    required init(action: @escaping (UIButton) -> Void) {
        super.init(frame: .zero)
        self.addTarget(self, action: #selector(onClick(sender:)), for: .touchUpInside)
        _action = action
    }
    
    @objc private func onClick(sender: UIButton) {
        listener?.action(sender)
        _action?(sender)
    }
    
    func setPadding(aligment: UIControl.ContentHorizontalAlignment, left: CGFloat = 0, right: CGFloat = 0, bottom: CGFloat = 0, top: CGFloat = 0) {
        self.contentHorizontalAlignment = aligment
        self.configuration?.contentInsets = NSDirectionalEdgeInsets(top: top, leading: left, bottom: bottom, trailing: right)
    }
}

protocol ButtonActionListener : AnyObject {
    func action(_ sender: UIButton)
}
