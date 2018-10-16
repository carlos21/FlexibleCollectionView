//
//  FlexibleCollectionView.swift
//  FlexibleCollectionView
//
//  Created by Carlos Duclos on 10/12/18.
//  Copyright © 2018 FlexibleCollectionView. All rights reserved.
//

import Foundation
import UIKit

open class FlexibleCollectionView: UICollectionView {
    
    public var layout: FlexibleCollectionViewLayout {
        return collectionViewLayout as! FlexibleCollectionViewLayout
    }
    
    public var settings: FlexibleCollectionViewLayout.Settings {
        get { return layout.settings }
        set { layout.settings = newValue }
    }
    
    open override var delegate: UICollectionViewDelegate? {
        didSet {
            dataSource = delegate as? UICollectionViewDataSource
        }
    }
    
    public override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        collectionViewLayout = FlexibleCollectionViewLayout(style: .normal)
        setup()
    }
    
    private func setup() {
        
    }
    
    open override func reloadData() {
        layout.invalidateLayout()
        super.reloadData()
    }
}
