//
//  LayoutOptionsViewController.swift
//  CompositionLayout
//
//  Created by Dane Regnier on 6/9/21.
//

import UIKit

class LayoutOptionsViewController: BaseCollectionController {
    enum Section {
        case all
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, DemoModel>! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Select Collection"
        navigationItem.backButtonTitle = ""
        setupDataSource()
    }
    
    fileprivate lazy var layoutOptions: [LayoutOption] = {
        return [
            LayoutOption(title: "Combined", controller: PagedDemoViewController.self),
            LayoutOption(title: "Featured", controller: FeaturedViewController.self),
            LayoutOption(title: "Articles", controller: ArticlesViewController.self),
            LayoutOption(title: "Playlists", controller: PlaylistsViewController.self),
            LayoutOption(title: "Brands", controller: BrandsViewController.self),
            LayoutOption(title: "Categories", controller: CategoriesViewController.self)
        ]
    }()
    
    override func setupLayout() -> UICollectionViewLayout {
        let section = CollectionLayoutHelper.horizontalGroupSection(itemSize: CellSizes.list, columnCount: 1)
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    override func setupCollection() {
        super.setupCollection()
        collection.delegate = self
    }
}

extension LayoutOptionsViewController {
    fileprivate func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, DemoModel>(collectionView: collection, cellProvider: { (collectionView, indexPath, option) -> UICollectionViewCell? in
            guard let cell = TextCell.dequeued(from: collectionView, for: indexPath) else { return nil }
            cell.configure(config: option)
            cell.label.textAlignment = .left
            return cell
        })
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, DemoModel>()
        snapshot.appendSections([.all])
        snapshot.appendItems(layoutOptions)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

extension LayoutOptionsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Make sure there is something to get
        guard let option = dataSource.itemIdentifier(for: indexPath) as? LayoutOption else { return }
        
        // Deselect
        collection.deselectItem(at: indexPath, animated: true)
        
        // Push the appropriate example view
        guard let vc = option.controller else { return }
        navigationController?.pushViewController(vc.init(), animated: true)
    }
}
