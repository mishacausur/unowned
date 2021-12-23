//
//  Extensions.swift
//  unowned
//  swiftlint:disable all
//  Created by Misha Causur on 13.12.2021.
//

import Foundation
import UIKit

extension UIView {
    func addSubviews(_ subviews: UIView...)  {
        subviews.forEach{addSubview($0)}
    }
}

protocol ViewControllerable {
    associatedtype RootView: UIView
}

extension ViewControllerable where Self: UIViewController {
    func view() -> RootView {
        return self.view as! RootView
    }
}
