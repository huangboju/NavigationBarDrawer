//
//  TextEffect.swift
//  SwiftyAttributes
//
//  Created by Eddie Kaiger on 10/28/16.
//  Copyright © 2016 Eddie Kaiger. All rights reserved.
//

import UIKit


/**
 An enum describing the possible values for text effects on attributed strings.
 */
public enum TextEffect: RawRepresentable {

    /// A graphical text effect giving glyphs the appearance of letterpress printing, in which type is pressed into the paper.
    case letterPressStyle

    public init?(rawValue: NSAttributedString.TextEffectStyle) {
        switch rawValue {
        case .letterpressStyle: self = .letterPressStyle
        default: return nil
        }
    }

    public var rawValue: NSAttributedString.TextEffectStyle {
        switch self {
        case .letterPressStyle: return NSAttributedString.TextEffectStyle.letterpressStyle
        }
    }
}
