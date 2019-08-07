//
//  BorderedLabel.swift
//  Catch Up
//
//  Created by Paramesh V on 11/07/19.
//  Copyright © 2019 CZ Ltd. All rights reserved.
//

import Foundation
import UIKit

//class BorderedLabel: UILabel {
//    var sidePadding = CGFloat(1) // Needed padding, add property observers
//
//    override func sizeToFit() {
//        super.sizeToFit()
////        bounds.size.width += 2 * sidePadding
//    }
//
//    override func drawText(in rect: CGRect) {
//        print(rect)
//        super.drawText(in: rect.insetBy(dx: sidePadding, dy: 0))
//        invalidateIntrinsicContentSize()
//    }
//}

@IBDesignable class BorderedLabel: UILabel {
    
    @IBInspectable var topInset: CGFloat = 5.0
    @IBInspectable var bottomInset: CGFloat = 5.0
    @IBInspectable var leftInset: CGFloat = 7.0
    @IBInspectable var rightInset: CGFloat = 7.0
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }
}
