//
//  Settings.swift
//  unowned
//
//  Created by Misha Causur on 13.12.2021.
//

import Foundation
import UIKit

enum Color {
    case leaf
    case weird
    case darkSlateBlue
    case lightGrey
    case grey
    case charcoalGrey
    case warmGrey
    
    static func color(_ color: Color) -> UIColor {
        switch color {
        case .leaf:
            return UIColor(named: "leaf")!
        case .weird:
            return UIColor(named: "weird")!
        case .darkSlateBlue:
            return UIColor(named: "darkSlateBlue")!
        case .lightGrey:
            return UIColor(named: "lightGrey")!
        case .grey:
            return UIColor(named: "grey")!
        case .charcoalGrey:
            return UIColor(named: "charcoalGrey")!
        case .warmGrey:
            return UIColor(named: "warmGrey")!
        }
    }
}

enum Font {
    case extrabold
    
    static func setFont(_ font: Font, _ size: CGFloat) -> UIFont {
        switch font {
        case .extrabold:
            return UIFont(name: "OfficinaSansExtraBoldC", size: size)!
        }
    }
}
