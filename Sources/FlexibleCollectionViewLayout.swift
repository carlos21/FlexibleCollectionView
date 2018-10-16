//
//  FlexibleCollectionViewLayout.swift
//  FlexibleCollectionView-iOS
//
//  Created by Carlos Duclos on 10/13/18.
//  Copyright © 2018 FlexibleCollectionView. All rights reserved.
//

import Foundation
import UIKit

public protocol FlexibleCollectionViewLayoutDelegate: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, heightForItemWithWidth width: CGFloat, atIndexPath indexPath: IndexPath) -> CGFloat
    
    func collectionView(_ collectionView: UICollectionView, insetsForSection section: Int) -> CGFloat
}

final public class FlexibleCollectionViewLayout: UICollectionViewLayout {
    
    private var cache = [Element: [IndexPath: FlexibleCollectionViewLayoutAttributes]]()
    private var visibleLayoutAttributes = [FlexibleCollectionViewLayoutAttributes]()
    private var contentHeight = CGFloat()
    
    public weak var delegate: FlexibleCollectionViewLayoutDelegate! {
        get {
            return self.collectionView!.delegate as? FlexibleCollectionViewLayoutDelegate
        }
    }
    
    public var settings = Settings()
    
    public init(style: Style) {
        super.init()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func invalidateLayout() {
        cache.removeAll(keepingCapacity: true)
        super.invalidateLayout()
    }
    
    override public class var layoutAttributesClass: AnyClass {
        return FlexibleCollectionViewLayoutAttributes.self
    }
    
    public override var collectionViewContentSize: CGSize {
        let width = collectionView?.frame.width ?? 0
        return CGSize(width: width, height: contentHeight)
    }
    
    public override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    public override func prepare() {
        guard let collectionView = collectionView, cache.isEmpty else { return }
        
        prepareCache()
        
        let sectionsCount = collectionView.numberOfSections
        for section in 0..<sectionsCount {
            
            let itemsCount = collectionView.numberOfItems(inSection: section)
            for item in 0..<itemsCount {
                
                let indexPath = IndexPath(item: item, section: section)
                let calculatedSize = itemSize(indexPath: indexPath)
                let attributes = FlexibleCollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = CGRect(x: 0, y: contentHeight, width: calculatedSize.width, height: calculatedSize.height)
            }
        }
    }
    
    public override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        visibleLayoutAttributes.removeAll(keepingCapacity: true)
        
        for (_, info) in cache {
            for (_, attributes) in info {
                if attributes.frame.intersects(rect) {
                    visibleLayoutAttributes.append(attributes)
                }
            }
        }
        return visibleLayoutAttributes
    }
    
    private func itemSize(indexPath: IndexPath) -> CGSize {
        guard let collectionView = collectionView else { return CGSize.zero }
        let calculatedInsets = sectionInsets(section: indexPath.section)
        let width = collectionView.frame.width - calculatedInsets * 2
        let height: CGFloat
        let delegatedHeight = delegate.collectionView(collectionView, heightForItemWithWidth: width, atIndexPath: indexPath)
        if delegatedHeight == .automatic {
            let fittingSize = CGSize(width: width, height: 10)
            let cell = delegate.collectionView(collectionView, cellForItemAt: indexPath)
//            cell.apply(tentativeAttributes)
            
            let size = cell.contentView.systemLayoutSizeFitting(fittingSize,
                                                                withHorizontalFittingPriority: .init(912),
                                                                verticalFittingPriority: .fittingSizeLevel)
            cell.removeFromSuperview()
            height = size.height
        } else {
            height = delegatedHeight
        }
        return CGSize(width: width, height: ceil(height))
    }
    
    private func prepareCache() {
        cache.removeAll(keepingCapacity: true)
        cache[.header] = [IndexPath: FlexibleCollectionViewLayoutAttributes]()
        cache[.sectionHeader] = [IndexPath: FlexibleCollectionViewLayoutAttributes]()
        cache[.sectionFooter] = [IndexPath: FlexibleCollectionViewLayoutAttributes]()
        cache[.cell] = [IndexPath: FlexibleCollectionViewLayoutAttributes]()
    }
}

extension FlexibleCollectionViewLayout {
    
    public enum Style {
        case normal
        case collage
    }
    
    public struct Settings {
        public var itemSpacing: CGFloat = 0
        public var insets: UIEdgeInsets = .zero
    }
    
    enum Element: String {
        case header
        case menu
        case cell
        case sectionHeader
        case sectionFooter
    }
}

extension FlexibleCollectionViewLayout {
    
    func sectionInsets(section: Int) -> CGFloat {
        guard let collectionView = collectionView else { return 0 }
        let sectionInsets: CGFloat
        let delegatedSectionInsets = delegate.collectionView(collectionView, insetsForSection: section)
        if delegatedSectionInsets == .automatic {
            sectionInsets = settings.insets.left
        } else {
            sectionInsets = delegatedSectionInsets
        }
        return sectionInsets
    }
}

public extension CGFloat {
    
    public static let automatic: CGFloat = .greatestFiniteMagnitude
}
