//
//  FlexibleCollectionViewLayoutAttributes.swift
//  FlexibleCollectionView-iOS
//
//  Created by Carlos Duclos on 10/13/18.
//  Copyright © 2018 FlexibleCollectionView. All rights reserved.
//

import UIKit

final public class FlexibleCollectionViewLayoutAttributes: UICollectionViewLayoutAttributes {
    
    // MARK: - Properties
//    var initialOrigin: CGPoint = .zero
//    var maskBounds: CGRect = .zero
//    var headerOverlayAlpha = CGFloat(0)
//    var roundedCorders: UIRectCorner = .none
//    var showsBorder: Bool = false
//    var showsTopSeparator: Bool = false
//    var showsBottomSeparator: Bool = true
//    var showsShadow: Bool = false
    
    // MARK: - Life Cycle
    override public func copy(with zone: NSZone?) -> Any {
        guard let copiedAttributes = super.copy(with: zone) as? FlexibleCollectionViewLayoutAttributes else {
            return super.copy(with: zone)
        }
//        copiedAttributes.initialOrigin = initialOrigin
//        copiedAttributes.maskBounds = maskBounds
//        copiedAttributes.headerOverlayAlpha = headerOverlayAlpha
//        copiedAttributes.roundedCorders = roundedCorders
//        copiedAttributes.showsBorder = showsBorder
//        copiedAttributes.showsTopSeparator = showsTopSeparator
//        copiedAttributes.showsBottomSeparator = showsBottomSeparator
//        copiedAttributes.showsShadow = showsShadow
//        copiedAttributes.selectionAccessory = selectionAccessory
        return copiedAttributes
    }
    
    override public func isEqual(_ object: Any?) -> Bool {
//        guard let otherAttributes = object as? FlexibleCollectionViewLayoutAttributes else {
//            return false
//        }
//        if otherAttributes.initialOrigin != initialOrigin
//            || otherAttributes.maskBounds != maskBounds
//            || otherAttributes.headerOverlayAlpha != headerOverlayAlpha
//            || otherAttributes.roundedCorders != roundedCorders
//            || otherAttributes.showsBorder != showsBorder
//            || otherAttributes.showsTopSeparator != showsTopSeparator
//            || otherAttributes.showsBottomSeparator != showsBottomSeparator
//            || otherAttributes.showsShadow != showsShadow
//            || otherAttributes.selectionAccessory != selectionAccessory {
//            return false
//        }
        return super.isEqual(object)
    }
    
}
