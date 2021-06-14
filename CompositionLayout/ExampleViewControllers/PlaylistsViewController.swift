//
//  PlaylistsViewController.swift
//  CompositionLayout
//
//  Created by Dane Regnier on 6/9/21.
//

import UIKit

class PlaylistsViewController: BaseCollectionController {
    enum Section {
        case all
    }
    var dataSource: UICollectionViewDiffableDataSource<Section, DemoModel>! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Playlists"
        
        setupDataSource()
    }
    
    /// Layout setup
    override func setupLayout() -> UICollectionViewLayout {
        let section = CollectionLayoutHelper.horizontalGroupSection(itemSize: CellSizes.playlist, columnCount: 2)
        return UICollectionViewCompositionalLayout(section: section)
    }
}

extension PlaylistsViewController {
    fileprivate func setupDataSource() {
        TextCell.register(to: collection)
        
        dataSource = UICollectionViewDiffableDataSource<Section, DemoModel>(collectionView: collection, cellProvider: { (collectionView, indexPath, playlist) -> UICollectionViewCell? in
            guard let cell = TextCell.dequeued(from: collectionView, for: indexPath) else { return nil }
            cell.configure(config: playlist)
            return cell
        })
        
        // Set up a basic snapshot
        var snapshot = NSDiffableDataSourceSnapshot<Section, DemoModel>()
        let playlists = DemoModel.playlists(count: 30)
        snapshot.appendSections([.all])
        snapshot.appendItems(playlists)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}
