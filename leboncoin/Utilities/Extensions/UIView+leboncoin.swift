//
//  UIView+leboncoin.swift
//  leboncoin
//
//  Created by Messaoui Meriam on 21/09/2022.
//

import Foundation
import UIKit

extension UIView {
    func autoFillToSuperView(edgeInset: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superViewTopAnchor = superview?.topAnchor {
            topAnchor.constraint(equalTo: superViewTopAnchor, constant: edgeInset.top).isActive = true
        }
        if let superviewBottomAnchor = superview?.bottomAnchor {
            bottomAnchor.constraint(equalTo: superviewBottomAnchor, constant: -edgeInset.bottom).isActive = true
        }
        if let superviewLeadingAnchor = superview?.leadingAnchor {
            leadingAnchor.constraint(equalTo: superviewLeadingAnchor, constant: edgeInset.left).isActive = true
        }
        if let superviewTrailingAnchor = superview?.trailingAnchor {
            trailingAnchor.constraint(equalTo: superviewTrailingAnchor, constant: -edgeInset.right).isActive = true
        }
    }

    func setAnchors(top: NSLayoutYAxisAnchor? = nil,
                    bottom: NSLayoutYAxisAnchor? = nil,
                    leading: NSLayoutXAxisAnchor? = nil,
                    trailing: NSLayoutXAxisAnchor? = nil,
                    distance: UIEdgeInsets = .zero,
                    size: CGSize = .zero ) {
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: distance.top).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -distance.bottom).isActive = true
        }
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: distance.left).isActive = true
        }
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -distance.right).isActive = true
        }
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
    }
}
