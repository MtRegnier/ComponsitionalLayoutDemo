//
//  CategoriesViewController.swift
//  CompositionLayout
//
//  Created by Dane Regnier on 6/10/21.
//

import UIKit

class CategoriesViewController: BaseCollectionController {
    var dataSource: UICollectionViewDiffableDataSource<Section, DemoModel>! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Categories"
        
        setupDataSource()
    }
    
    override func setupCollection() {
        super.setupCollection()
        TitleHeaderView.register(to: collection)
    }
    
    override func setupLayout() -> UICollectionViewLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 10
        
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { (sectionIndex, environment) -> NSCollectionLayoutSection? in
            guard let sectionType = Section(rawValue: sectionIndex) else { return nil }
            return CollectionLayoutHelper.horizontalGroupSection(config: sectionType)
        }, configuration: config)
        return layout
    }
}

extension CategoriesViewController {
    /// Diffable data source setup
    fileprivate func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, DemoModel>(collectionView: collection, cellProvider: { (collectionView, indexPath, model) -> UICollectionViewCell? in
            guard let cell = TextCell.dequeued(from: collectionView, for: indexPath) else { return nil }
            cell.configure(config: model)
            return cell
        })
        
        dataSource.supplementaryViewProvider = { (collectionView, kind, index) in
            guard let section = Section(rawValue: index.section),
                  let title = section.title,
                  let header = TitleHeaderView.dequeued(from: collectionView, for: index)
            else { return nil }
            header.label.text = title
            return header
        }
        
        // May want to simplify this down at some point
        var snapshot = NSDiffableDataSourceSnapshot<Section, DemoModel>()
        snapshot.appendSections(Section.allCases)
        for section in Section.allCases {
            snapshot.appendItems(section.models, toSection: section)
        }
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

// MARK: - Collection Sections
extension CategoriesViewController {
    enum Section: Int, CaseIterable, HorizontalGroupSectionConfig {
        case firstCategoryVideo, firstCategoryPlaylist, secondCategoryVideo, secondCategoryPlaylist, rewardVideo
        
        var orthogonalBehavior: UICollectionLayoutSectionOrthogonalScrollingBehavior {
            switch self {
                case .firstCategoryVideo, .secondCategoryVideo, .rewardVideo:
                    return .continuousGroupLeadingBoundary
                case .firstCategoryPlaylist, .secondCategoryPlaylist:
                    return .none
            }
        }
        
        var itemSize: NSCollectionLayoutSize {
            switch self {
                case .firstCategoryVideo, .secondCategoryVideo, .rewardVideo:
                    return CellSizes.video
                case .firstCategoryPlaylist, .secondCategoryPlaylist:
                    return CellSizes.playlist
            }
        }
        
        var columnCount: Int {
            switch self {
                case .firstCategoryVideo, .secondCategoryVideo, .rewardVideo:
                    return 1
                case .firstCategoryPlaylist, .secondCategoryPlaylist:
                    return 2
            }
        }
        
        var models: [DemoModel] {
            switch self {
                case .firstCategoryVideo, .secondCategoryVideo:
                    return DemoModel.categoryVideo(count: 30)
                case .rewardVideo:
                    return DemoModel.rewardVideo(count: 30)
                case .firstCategoryPlaylist, .secondCategoryPlaylist:
                    return DemoModel.playlists(count: 3)
            }
        }
        
        var contentInsets: NSDirectionalEdgeInsets {
            switch self {
                case .firstCategoryVideo, .secondCategoryVideo:
                    return NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
                case .firstCategoryPlaylist, .secondCategoryPlaylist:
                    return NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 20, trailing: 20)
                case .rewardVideo:
                    return CollectionLayoutHelper.defaultOuterInsets
            }
        }
        
        var title: String? {
            switch  self {
                case .firstCategoryVideo: return "Makeup"
                case .secondCategoryVideo: return "Skincare"
                case .rewardVideo: return "Reward Videos"
                default: return nil
            }
        }
    }
}
