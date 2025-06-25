//
//  UIView+Utils.swift
//  PerfectExam
//
//  Created by 유니위즈 on 2022/04/21.
//

import UIKit

extension UIView {
    @IBInspectable var borderColor: UIColor {
        get {
            let color = self.layer.borderColor ?? UIColor.clear.cgColor
            return UIColor(cgColor: color)
        }
        set {
            self.layer.borderColor = newValue.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get { return self.layer.borderWidth }
        set { self.layer.borderWidth = newValue }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get { return self.layer.cornerRadius }
        set { self.layer.cornerRadius = newValue }
    }
    
    @IBInspectable var shadowColor: UIColor {
        get {
            let color = self.layer.shadowColor ?? UIColor.clear.cgColor
            return UIColor(cgColor: color)
        }
        set {
            self.layer.shadowColor = newValue.cgColor
            self.layer.masksToBounds = false
        }
    }
    
    @IBInspectable var shadowWidth: CGFloat {
        get { return self.layer.shadowRadius }
        set { self.layer.shadowRadius = newValue }
    }
    
    @IBInspectable var shadowOpacity: CGFloat {
        get { return CGFloat(self.layer.shadowOpacity) }
        set { self.layer.shadowOpacity = Float(newValue) }
    }
    
    @IBInspectable var shadowOffset: CGSize {
        get { return self.layer.shadowOffset }
        set { self.layer.shadowOffset = newValue }
    }
    
    func checkSubFirstPopupView() -> UIView? {
        for (i,subview) in self.subviews.enumerated() {
            if !(subview is UIButton) && !(subview is UILabel) && !(subview is UIImageView) && i > 0 {
                return subview
            }
        }
        return nil
    }
    
    func fillParent( topPriority: UILayoutPriority = .defaultHigh,
                     bottomPriority: UILayoutPriority = .defaultHigh,
                     leadingPriority: UILayoutPriority = .defaultHigh,
                     trailingPriority: UILayoutPriority = .defaultHigh) {
        if let parent = self.superview {
            self.translatesAutoresizingMaskIntoConstraints = false
            let top = self.topAnchor.constraint(equalTo: parent.topAnchor)
            top.priority = topPriority
            top.isActive = true
            let bottom = self.bottomAnchor.constraint(equalTo: parent.bottomAnchor)
            bottom.priority = bottomPriority
            bottom.isActive = true
            let leading = self.leadingAnchor.constraint(equalTo: parent.leadingAnchor)
            leading.priority = leadingPriority
            leading.isActive = true
            let trailing = self.trailingAnchor.constraint(equalTo: parent.trailingAnchor)
            trailing.priority = trailingPriority
            trailing.isActive = true
        }
    }
    
    func fillSafeArea() {
        if let parent = self.superview {
            self.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                self.topAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.topAnchor),
                self.bottomAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.bottomAnchor),
                self.leadingAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.leadingAnchor),
                self.trailingAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.trailingAnchor)
            ])
        }
    }
    
    func removeAllConstraint() {
        var superview = self.superview
        while superview != nil {
            for c in superview!.constraints {
                if let firstItem = c.firstItem as? UIView, firstItem == self {
                    superview!.removeConstraint(c)
                } else if let secondItem = c.secondItem as? UIView, secondItem == self {
                    superview!.removeConstraint(c)
                }
            }
            superview = superview?.superview
        }
        self.removeConstraints(self.constraints)
        self.translatesAutoresizingMaskIntoConstraints = true
    }
    
    func removeSuperViewConstraint() {
        guard let superview = self.superview else { return }
        let constraints = self.superview?.constraints.filter {
            ($0.firstItem as? UIView == self || $0.secondItem as? UIView == self) &&
            ($0.firstItem as? UIView == superview || $0.firstItem as? UILayoutGuide == superview.safeAreaLayoutGuide ||
             $0.secondItem as? UIView == superview || $0.secondItem as? UILayoutGuide == superview.safeAreaLayoutGuide)
        } ?? []

        self.superview?.removeConstraints(constraints)
        self.removeConstraints(self.constraints)
    }
    
    func removeOnlySuperViewConstraint() {
        guard let superview = self.superview else { return }
        let constraints = self.superview?.constraints.filter {
            ($0.firstItem as? UIView == self || $0.secondItem as? UIView == self) &&
            ($0.firstItem as? UIView == superview || $0.firstItem as? UILayoutGuide == superview.safeAreaLayoutGuide ||
             $0.secondItem as? UIView == superview || $0.secondItem as? UILayoutGuide == superview.safeAreaLayoutGuide)
        } ?? []

        self.superview?.removeConstraints(constraints)
    }
    
    func removeSelfConstraints() {
        let constraints = self.superview?.constraints.filter {
            $0.firstItem as? UIView == self || $0.secondItem as? UIView == self
        } ?? []

        self.superview?.removeConstraints(constraints)
        self.removeConstraints(self.constraints)
    }
    
    func coverView(centerView: UIView, isHorizontal: Bool = true) -> UIView {
        addSubview(centerView)
        centerView.translatesAutoresizingMaskIntoConstraints = false
        centerView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        centerView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        if isHorizontal {
            centerView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        } else {
            centerView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        }
        return self
    }
    
    func useAutolayout() -> UIView {
        translatesAutoresizingMaskIntoConstraints = false
        return self
    }
}
