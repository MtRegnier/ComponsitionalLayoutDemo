//
//  BrandsViewController.swift
//  CompositionLayout
//
//  Created by Dane Regnier on 6/9/21.
//

import UIKit

class BrandsViewController: BaseCollectionController {
    enum Section {
        case all
    }
    var dataSource: UICollectionViewDiffableDataSource<Section, DemoModel>! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Brands"
        
        setupDataSource()
    }
    
    /// Layout setup
    override func setupLayout() -> UICollectionViewLayout {
        let section = CollectionLayoutHelper.horizontalGroupSection(itemSize: CellSizes.brand(orthogonal: false), columnCount: 2)
        return UICollectionViewCompositionalLayout(section: section)
    }
}

extension BrandsViewController {
    fileprivate func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, DemoModel>(collectionView: collection, cellProvider: { (collectionView, indexPath, brand) -> UICollectionViewCell? in
            guard let cell = TextCell.dequeued(from: collectionView, for: indexPath ) else { return nil }
            cell.configure(config: brand)
            return cell
        })
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, DemoModel>()
        let brands = DemoModel.brands(count: 30)
        snapshot.appendSections([.all])
        snapshot.appendItems(brands)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}
