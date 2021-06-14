//
//  BaseCollectionController.swift
//  CompositionLayout
//
//  Created by Dane Regnier on 6/10/21.
//

import UIKit

class BaseCollectionController: UIViewController {
    var collection: UICollectionView! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollection()
    }
    
    /// Default layout
    func setupLayout() -> UICollectionViewLayout {
        let section = CollectionLayoutHelper.horizontalGroupSection(itemSize: CellSizes.list, columnCount: 1)
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    /**
     For the purposes of this demo, all collections will have the same background color and use the same cell
     */
    func setupCollection() {
        collection = UICollectionView(frame: view.bounds, collectionViewLayout: setupLayout())
        collection.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collection.backgroundColor = .systemGroupedBackground
        view.addSubview(collection)
        
        TextCell.register(to: collection)
    }
}
