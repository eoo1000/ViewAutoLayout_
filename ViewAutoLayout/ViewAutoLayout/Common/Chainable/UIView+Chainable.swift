//
//  UIView+Chainable.swift
//  HybridWebView
//
//  Created by 유니위즈 on 2021/03/10.
//

import UIKit

extension UIView: Chainable {}

extension Chain where Origin: UIView {
    public func addView( to: UIView ) -> Chain {
        to.addSubview(origin)
        return self
    }

    public func addSubView( view: UIView ) -> Chain {
        origin.addSubview(view)
        return self
    }
    
    public func insertSubview( to: UIView, at: Int ) -> Chain {
        to.insertSubview(origin, at: at)
        return self
    }
    
    public func fillParant( constant : CGFloat ) -> Chain {
        return fillParant(topConstant: constant, bottomConstant: -constant, leadConstant: constant, trailConstant: -constant)
    }
    
    public func fillParant( topConstant : CGFloat = 0.0,
                            bottomConstant : CGFloat = 0.0,
                            leadConstant : CGFloat = 0.0,
                            trailConstant : CGFloat = 0.0 ) -> Chain {
        origin.translatesAutoresizingMaskIntoConstraints = false
        if let superView = origin.superview {
            return fillParantWithAnchor(topAnchor:superView.topAnchor,
                                        bottomAnchor:superView.bottomAnchor,
                                        leadAnchor:superView.leadingAnchor,
                                        trailAnchor:superView.trailingAnchor,
                                        topConstant: topConstant,
                                        bottomConstant: bottomConstant,
                                        leadConstant: leadConstant,
                                        trailConstant: trailConstant)
        }
        return self
    }
    
    public func fillParantWithAnchor( topAnchor : NSLayoutYAxisAnchor? = nil,
                                      bottomAnchor : NSLayoutYAxisAnchor? = nil,
                                      leadAnchor : NSLayoutXAxisAnchor? = nil,
                                      trailAnchor : NSLayoutXAxisAnchor? = nil,
                                      constant : CGFloat ) -> Chain {
        return fillParantWithAnchor(topAnchor:topAnchor,
                                    bottomAnchor:bottomAnchor,
                                    leadAnchor:leadAnchor,
                                    trailAnchor:trailAnchor,
                                    topConstant: constant,
                                    bottomConstant: constant,
                                    leadConstant: constant,
                                    trailConstant: constant)
    }
    
    public func fillParantWithAnchor( topAnchor : NSLayoutYAxisAnchor? = nil,
                                      bottomAnchor : NSLayoutYAxisAnchor? = nil,
                                      leadAnchor : NSLayoutXAxisAnchor? = nil,
                                      trailAnchor : NSLayoutXAxisAnchor? = nil,
                                      topConstant : CGFloat = 0.0,
                                      bottomConstant : CGFloat = 0.0,
                                      leadConstant : CGFloat = 0.0,
                                      trailConstant : CGFloat = 0.0 ) -> Chain {
        origin.translatesAutoresizingMaskIntoConstraints = false
        if let superView = origin.superview {
            origin.topAnchor.constraint(equalTo: topAnchor ?? superView.topAnchor, constant: topConstant).isActive = true
            origin.bottomAnchor.constraint(equalTo: bottomAnchor ?? superView.bottomAnchor, constant: -bottomConstant).isActive = true
            origin.leadingAnchor.constraint(equalTo: leadAnchor ?? superView.leadingAnchor, constant: leadConstant).isActive = true
            origin.trailingAnchor.constraint(equalTo: trailAnchor ?? superView.trailingAnchor, constant: -trailConstant).isActive = true
        }
        return self
    }

    public func fillSafeAreaGuide(constant: CGFloat = 0.0) -> Chain {
        origin.translatesAutoresizingMaskIntoConstraints = false
        if let superView = origin.superview {
            return fillParantWithAnchor(topAnchor:superView.safeAreaLayoutGuide.topAnchor,
                                        bottomAnchor:superView.safeAreaLayoutGuide.bottomAnchor,
                                        leadAnchor:superView.safeAreaLayoutGuide.leadingAnchor,
                                        trailAnchor:superView.safeAreaLayoutGuide.trailingAnchor,
                                        topConstant: constant,
                                        bottomConstant: constant,
                                        leadConstant: constant,
                                        trailConstant: constant)
        }
        return self
    }
    
    public func center( multiWidth: CGFloat? = nil, multiHeight: CGFloat? = nil, width: CGFloat? = nil, height: CGFloat? = nil ) -> Chain {
        origin.translatesAutoresizingMaskIntoConstraints = false
        if let superView = origin.superview {
            if let width = width { origin.widthAnchor.constraint(equalToConstant: width).isActive = true }
            if let height = height { origin.heightAnchor.constraint(equalToConstant: height).isActive = true }
            
            if let multiWidth = multiWidth { origin.widthAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.widthAnchor, multiplier: multiWidth).isActive = true }
            if let multiHeight = multiHeight { origin.heightAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.heightAnchor, multiplier: multiHeight).isActive = true }
            origin.centerXAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.centerXAnchor).isActive = true
            origin.centerYAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.centerYAnchor).isActive = true
        }
        return self
    }
    
    public func centerY(equalTo: NSLayoutYAxisAnchor? = nil, constant: CGFloat) -> Chain {
        origin.translatesAutoresizingMaskIntoConstraints = false
        if let equalTo = equalTo {
            origin.centerYAnchor.constraint(equalTo: equalTo, constant: constant).isActive = true
        } else if let superView = origin.superview {
            origin.centerYAnchor.constraint(equalTo: superView.centerYAnchor, constant: constant).isActive = true
        }
        return self
    }
    
    public func centerX(equalTo: NSLayoutXAxisAnchor? = nil, constant: CGFloat) -> Chain {
        origin.translatesAutoresizingMaskIntoConstraints = false
        if let equalTo = equalTo {
            origin.centerXAnchor.constraint(equalTo: equalTo, constant: constant).isActive = true
        } else if let superView = origin.superview {
            origin.centerXAnchor.constraint(equalTo: superView.centerXAnchor, constant: constant).isActive = true
        }
        return self
    }
    
    public func left(equalTo: NSLayoutXAxisAnchor? = nil, constant: CGFloat) -> Chain {
        origin.translatesAutoresizingMaskIntoConstraints = false
        if let equalTo = equalTo {
            origin.leadingAnchor.constraint(equalTo: equalTo, constant: constant).isActive = true
        } else if let superView = origin.superview {
            origin.leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: constant).isActive = true
        }
        return self
    }
    
    public func left(greaterThanOrEqualTo: NSLayoutXAxisAnchor?, constant: CGFloat) -> Chain {
        origin.translatesAutoresizingMaskIntoConstraints = false
        if let greaterThanOrEqualTo = greaterThanOrEqualTo {
            origin.trailingAnchor.constraint(greaterThanOrEqualTo: greaterThanOrEqualTo, constant: constant).isActive = true
        } else if let superView = origin.superview {
            origin.trailingAnchor.constraint(greaterThanOrEqualTo: superView.leadingAnchor, constant: constant).isActive = true
        }
        return self
    }
    
    public func right(equalTo: NSLayoutXAxisAnchor? = nil, constant: CGFloat) -> Chain {
        origin.translatesAutoresizingMaskIntoConstraints = false
        if let equalTo = equalTo {
            origin.trailingAnchor.constraint(equalTo: equalTo, constant: constant).isActive = true
        } else if let superView = origin.superview {
            origin.trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: constant).isActive = true
        }
        return self
    }
    
    public func right(greaterThanOrEqualTo: NSLayoutXAxisAnchor?, constant: CGFloat) -> Chain {
        origin.translatesAutoresizingMaskIntoConstraints = false
        if let greaterThanOrEqualTo = greaterThanOrEqualTo {
            origin.trailingAnchor.constraint(greaterThanOrEqualTo: greaterThanOrEqualTo, constant: constant).isActive = true
        } else if let superView = origin.superview {
            origin.trailingAnchor.constraint(greaterThanOrEqualTo: superView.trailingAnchor, constant: constant).isActive = true
        }
        return self
    }
    
    public func right(lessThanOrEqualTo: NSLayoutXAxisAnchor?, constant: CGFloat) -> Chain {
        origin.translatesAutoresizingMaskIntoConstraints = false
        if let lessThanOrEqualTo = lessThanOrEqualTo {
            origin.trailingAnchor.constraint(lessThanOrEqualTo: lessThanOrEqualTo, constant: constant).isActive = true
        } else if let superView = origin.superview {
            origin.trailingAnchor.constraint(lessThanOrEqualTo: superView.trailingAnchor, constant: constant).isActive = true
        }
        return self
    }
    
    public func bottom(equalTo: NSLayoutYAxisAnchor? = nil, constant: CGFloat) -> Chain {
        origin.translatesAutoresizingMaskIntoConstraints = false
        if let equalTo = equalTo {
            origin.bottomAnchor.constraint(equalTo: equalTo, constant: constant).isActive = true
        } else if let superView = origin.superview {
            origin.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: constant).isActive = true
        }
        return self
    }
    
    public func top(equalTo: NSLayoutYAxisAnchor? = nil, constant: CGFloat) -> Chain {
        origin.translatesAutoresizingMaskIntoConstraints = false
        if let equalTo = equalTo {
            origin.topAnchor.constraint(equalTo: equalTo, constant: constant).isActive = true
        } else if let superView = origin.superview {
            origin.topAnchor.constraint(equalTo: superView.topAnchor, constant: constant).isActive = true
        }
        return self
    }
    
    public func width(constant: CGFloat?) -> Chain {
        guard let constant = constant else { return self }
        origin.translatesAutoresizingMaskIntoConstraints = false
        origin.widthAnchor.constraint(equalToConstant: constant).isActive = true
        return self
    }
    
    public func width(greaterThanOrEqualToConstant: CGFloat, priority: UILayoutPriority = .required) -> Chain {
        origin.translatesAutoresizingMaskIntoConstraints = false
        let layout = origin.widthAnchor.constraint(greaterThanOrEqualToConstant: greaterThanOrEqualToConstant)
        layout.priority = priority
        layout.isActive = true
        return self
    }
    
    public func width(lessThanOrEqualToConstant: CGFloat?) -> Chain {
        guard let lessThanOrEqualToConstant = lessThanOrEqualToConstant else { return self }
        origin.translatesAutoresizingMaskIntoConstraints = false
        let layout: NSLayoutConstraint?
        layout = origin.widthAnchor.constraint(lessThanOrEqualToConstant: lessThanOrEqualToConstant)
        layout?.isActive = true
        return self
    }
    
    public func width(equalTo: NSLayoutDimension? = nil, lessThan: NSLayoutDimension? = nil, multiWidth: CGFloat?, priority: UILayoutPriority = .required) -> Chain {
        guard let multiWidth = multiWidth else { return self }
        origin.translatesAutoresizingMaskIntoConstraints = false
        let layout: NSLayoutConstraint?
        if let lessThan = lessThan {
            layout = origin.widthAnchor.constraint(lessThanOrEqualTo: lessThan, multiplier: multiWidth)
        } else if let equalTo = equalTo {
            layout = origin.widthAnchor.constraint(equalTo: equalTo, multiplier: multiWidth)
        } else if let superView = origin.superview {
            layout = origin.widthAnchor.constraint(equalTo: superView.widthAnchor, multiplier: multiWidth)
        } else {
            layout = nil
        }
        layout?.priority = priority
        layout?.isActive = true
        return self
    }
    
    public func height(constant: CGFloat?) -> Chain {
        guard let constant = constant else { return self }
        origin.translatesAutoresizingMaskIntoConstraints = false
        origin.heightAnchor.constraint(equalToConstant: constant).isActive = true
        return self
    }
    
    public func height(lessThanOrEqualToConstant: CGFloat) -> Chain {
        origin.translatesAutoresizingMaskIntoConstraints = false
        origin.heightAnchor.constraint(lessThanOrEqualToConstant: lessThanOrEqualToConstant).isActive = true
        return self
    }
    
    public func height(greaterThanOrEqualToConstant: CGFloat) -> Chain {
        origin.translatesAutoresizingMaskIntoConstraints = false
        origin.heightAnchor.constraint(greaterThanOrEqualToConstant: greaterThanOrEqualToConstant).isActive = true
        return self
    }
    
    public func height(lessThanOrEqualToConstant: CGFloat?) -> Chain {
        guard let lessThanOrEqualToConstant = lessThanOrEqualToConstant else { return self }
        origin.translatesAutoresizingMaskIntoConstraints = false
        let layout: NSLayoutConstraint?
        layout = origin.heightAnchor.constraint(lessThanOrEqualToConstant: lessThanOrEqualToConstant)
        layout?.isActive = true
        return self
    }
    
    public func height(equalTo: NSLayoutDimension? = nil, lessThan: NSLayoutDimension? = nil, multiHeight: CGFloat?, priority: UILayoutPriority = .required) -> Chain {
        guard let multiHeight = multiHeight else { return self}
        origin.translatesAutoresizingMaskIntoConstraints = false
        let layout: NSLayoutConstraint?
        if let lessThan = lessThan {
            layout = origin.heightAnchor.constraint(lessThanOrEqualTo: lessThan, multiplier: multiHeight)
        } else if let equalTo = equalTo {
            layout = origin.heightAnchor.constraint(equalTo: equalTo, multiplier: multiHeight)
        } else if let superView = origin.superview {
            layout = origin.heightAnchor.constraint(equalTo: superView.heightAnchor, multiplier: multiHeight)
        } else {
            layout = nil
        }
        layout?.priority = priority
        layout?.isActive = true
        return self
    }
    
    public func ratio(width: CGFloat, heght: CGFloat) -> Chain {
        origin.widthAnchor.constraint(equalTo: origin.heightAnchor, multiplier: width/heght).isActive = true
        return self
    }

    public func corner( Radius: CGFloat ) -> Chain {
        origin.layer.masksToBounds = true
        origin.layer.cornerRadius = Radius
        return self
    }

    public func border( Width: CGFloat ) -> Chain {
        origin.layer.borderWidth = Width
        return self
    }

    public func border( Color: UIColor ) -> Chain {
        origin.layer.borderColor = Color.cgColor
        return self
    }

    public func setBgColor(_ color: UIColor ) -> Chain {
        origin.backgroundColor = color
        return self
    }

    public func transform( angle: CGFloat ) -> Chain {
        origin.transform = CGAffineTransformMakeRotation(angle)
        return self
    }

    public func setAlpha( alpha: CGFloat ) -> Chain {
        origin.alpha = alpha
        return self
    }
    
    public func shadow( color: UIColor = .black, offset: CGSize = .zero, radius: CGFloat, opascity: Float = 0.5 ) -> Chain {
        self.origin.layer.shadowColor = color.cgColor
        self.origin.layer.shadowOffset = offset
        self.origin.layer.shadowRadius = radius
        self.origin.layer.shadowOpacity = opascity
        self.origin.layer.masksToBounds = false
        return self
    }
}
