//
//  ViewController.swift
//  ViewAutoLayout
//
//  Created by eoo on 6/25/25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let v = UIView()
        self.view.addSubview(v)
        v.backgroundColor = .yellow
        v.fillSafeArea()
        
        UIView().chain
            .addView(to: self.view)
            .setBgColor(.blue)
            .corner(Radius: 30)
            .top(constant: 10)
            .left(constant: 10)
            .right(constant: 10)
            .height(constant: 200)
            .done()
        
        let btn = Button(font: .systemFont(ofSize: 12), textColor: .black, title: "test")
        btn.chain
            .addView(to: self.view)
            .setBgColor(.brown)
            .center(multiWidth: 0.5, multiHeight: 0.5)
            .done()
    }


}

