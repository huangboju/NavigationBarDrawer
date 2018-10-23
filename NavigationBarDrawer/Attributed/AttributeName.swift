//
//  AttributeName.swift
//  SwiftyAttributes
//
//  Created by Eddie Kaiger on 11/23/16.
//  Copyright © 2016 Eddie Kaiger. All rights reserved.
//

import UIKit

extension Attribute {

    /**
     An enum that corresponds to `Attribute`, mapping attributes to their respective names.
     */
    public enum Name: RawRepresentable {

        case baselineOffset
        case backgroundColor
        case expansion
        case font
        case kern
        case ligature
        case link

        case obliqueness
        case paragraphStyle

        case strokeColor
        case strokeWidth
        case strikethroughColor
        case strikethroughStyle
        case textColor
        case textEffect
        case underlineColor
        case underlineStyle
        case verticalGlyphForm
        case writingDirection

        public init?(rawValue: NSAttributedString.Key) {

            switch rawValue {
//            case NSAttachmentAttributeName: self = .attachment
            case .baselineOffset: self = .baselineOffset
            case .backgroundColor: self = .backgroundColor
            case .expansion: self = .expansion
            case .font: self = .font
            case .kern: self = .kern
            case .ligature: self = .ligature
            case .link: self = .link
            case .obliqueness: self = .obliqueness
            case .paragraphStyle: self = .paragraphStyle
//            case NSShadowAttributeName: self = .shadow
            case .strokeColor: self = .strokeColor
            case .strokeWidth: self = .strokeWidth
            case .strikethroughColor: self = .strikethroughColor
            case .strikethroughStyle: self = .strikethroughStyle
            case .foregroundColor: self = .textColor
            case .textEffect: self = .textEffect
            case .underlineColor: self = .underlineColor
            case .underlineStyle: self = .underlineStyle
            case .verticalGlyphForm: self = .verticalGlyphForm
            case .writingDirection: self = .writingDirection
            default: return nil
            }
        }

        public var rawValue: NSAttributedString.Key {

            var type: NSAttributedString.Key

            // Bug in Swift prevents us from putting directives inside switch statements (https://bugs.swift.org/browse/SR-2)

            switch self {
            case .baselineOffset: type = .baselineOffset
            case .backgroundColor: type = .backgroundColor
            case .expansion: type = .expansion
            case .font: type = .font
            case .kern: type = .kern
            case .ligature: type = .ligature
            case .link: type = .link
            case .obliqueness: type = .obliqueness
            case .paragraphStyle: type = .paragraphStyle
            case .strokeColor: type = .strokeColor
            case .strokeWidth: type = .strokeWidth
            case .strikethroughColor: type = .strikethroughColor
            case .strikethroughStyle: type = .strikethroughStyle
            case .textColor: type = .foregroundColor
            case .textEffect: type = .textEffect
            case .underlineColor: type = .underlineColor
            case .underlineStyle: type = .underlineStyle
            case .verticalGlyphForm: type = .verticalGlyphForm
            case .writingDirection: type = .writingDirection
            }

            return type
        }
    }

}
