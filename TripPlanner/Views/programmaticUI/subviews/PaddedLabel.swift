//
//  PaddedLabel.swift
//  TripPlanner
//
//  Created by waheedCodes on 19/02/2025.
//

import UIKit

class PaddedLabel: UILabel {
    private let padding = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)

    override func drawText(in rect: CGRect) {
        let insetRect = rect.inset(by: padding)
        super.drawText(in: insetRect)
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + padding.left + padding.right,
                      height: size.height + padding.top + padding.bottom)
    }
    
    func setBackgroundColor(_ color: UIColor, opacity: CGFloat) {
        self.backgroundColor = color.withAlphaComponent(opacity)
    }
}
