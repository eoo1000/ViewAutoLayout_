//
//  Chainable.swift
//  HybridWebView
//
//  Created by 유니위즈 on 2021/03/09.
//

import Foundation

public class Chain<Origin> {
    public var origin: Origin
    
    public init( origin: Origin) {
        self.origin = origin
    }
    public func done() {}
}
	
public protocol Chainable {}

public extension Chainable {
    var chain: Chain<Self> {
        return Chain(origin: self)
    }
}
