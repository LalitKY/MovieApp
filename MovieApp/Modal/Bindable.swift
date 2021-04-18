//
//  Bindable.swift
//  MovieApp
//
//  Created by Lalit Kant on 17/04/21.
//

import Foundation

// This class act like observable to return binded data in observer value
class Bindable<T> {
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    private var listener: ((T) -> Void)?
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ closure: @escaping (T) -> Void) {
        closure(value)
        listener = closure
    }
}
