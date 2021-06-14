//
//  FeaturedViewController.swift
//  CompositionLayout
//
//  Created by Dane Regnier on 6/9/21.
//

import UIKit

class FeaturedViewController: BaseCollectionController {
    var dataSource: UICollectionViewDiffableDataSource<Section, DemoModel>! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Featured"
        
        setupDataSource()
    }
    
    override func setupCollection() {
        super.setupCollection()
        TitleHeaderView.register(to: collection)
    }
    
    override func setupLayout() -> UICollectionViewLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = CollectionLayoutHelper.interSectionSpacing
        
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { (sectionIndex, environment) -> NSCollectionLayoutSection? in
            guard let sectionType = Section(rawValue: sectionIndex) else { return nil }
            return CollectionLayoutHelper.horizontalGroupSection(config: sectionType)
        }, configuration: config)
        return layout
    }
}

extension FeaturedViewController {
    // Setting up our diffable data source
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
extension FeaturedViewController {
    enum Section: Int, CaseIterable, HorizontalGroupSectionConfig {
        case live, spotlight, brands, forYou, playlists, creators, topProducts, tools, trendingProducts
        
        var contentInsets: NSDirectionalEdgeInsets {
            return NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 20, trailing: 20)
        }
        var orthogonalBehavior: UICollectionLayoutSectionOrthogonalScrollingBehavior {
            switch self {
                case .playlists, .topProducts, .trendingProducts: return .none
                default: return .continuousGroupLeadingBoundary
            }
        }
        
        var itemSize: NSCollectionLayoutSize {
            switch self {
                case .live: return CellSizes.liveShow
                case .spotlight, .forYou, .tools: return CellSizes.video
                case .brands: return CellSizes.brand(orthogonal: true)
                case .playlists: return CellSizes.playlist
                case .creators: return CellSizes.creator
                case .topProducts, .trendingProducts: return CellSizes.list
            }
        }
        
        var columnCount: Int {
            switch self {
                case .playlists: return 2
                default: return 1
            }
        }
        
        var models:  [DemoModel] {
            switch self {
                case .live: return DemoModel.liveShows(count: 30)
                case .spotlight: return DemoModel.spotlight(count: 30)
                case .brands: return DemoModel.brands(count: 30)
                case .forYou: return DemoModel.forYou(count: 30)
                case .playlists: return DemoModel.playlists(count: 5)
                case .creators: return DemoModel.creators(count: 30)
                case .tools: return DemoModel.tools(count: 30)
                case .topProducts:
                    return DemoModel.products(isForYou: true, count: 5)
                case  .trendingProducts:
                    return DemoModel.products(isForYou: false, count: 5)
            }
        }
        
        var title: String? {
            switch  self {
                case .live: return "Live Show Guide"
                case .spotlight: return "Supergreat Spotlight"
                case .brands: return "Popular Brands"
                case .forYou: return "Videos for You"
                case .playlists: return "Playlists for You"
                case .creators: return "Featured Creators"
                case .topProducts: return "Top Products for You"
                case .tools: return "Tools"
                case .trendingProducts: return "Trending Products"
            }
        }
    }
}
