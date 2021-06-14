//
//  ArticlesViewController.swift
//  CompositionLayout
//
//  Created by Dane Regnier on 6/10/21.
//

import UIKit

class ArticlesViewController: BaseCollectionController {
    var dataSource: UICollectionViewDiffableDataSource<Section, DemoModel>! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Articles"
        
        setupDataSource()
    }
    
    override func setupCollection() {
        super.setupCollection()
        TitleHeaderView.register(to: collection)
    }
    
    override func setupLayout() -> UICollectionViewLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 0
        
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { (sectionIndex, environment) -> NSCollectionLayoutSection? in
            guard let sectionType = Section(rawValue: sectionIndex) else { return nil }
            return CollectionLayoutHelper.horizontalGroupSection(config: sectionType)
        }, configuration: config)
        return layout
    }
}

extension ArticlesViewController {
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
extension ArticlesViewController {
    enum Section: Int, CaseIterable, HorizontalGroupSectionConfig {
        case firstHero, firstHelper, secondHero, secondHelper, thirdHero, thirdHelper
        
        var columnCount: Int { return 1 }
        var orthogonalBehavior: UICollectionLayoutSectionOrthogonalScrollingBehavior {
            switch self {
                case .firstHelper, .secondHelper, .thirdHelper:
                    return .continuousGroupLeadingBoundary
                default: return .none
            }
        }
        
        var itemSize: NSCollectionLayoutSize {
            switch self {
                case .firstHero, .secondHero, .thirdHero:
                    return CellSizes.heroArticle
                case .firstHelper, .secondHelper, .thirdHelper:
                    return CellSizes.article
            }
        }
        
        var models: [DemoModel] {
            switch self {
                case .firstHero, .secondHero, .thirdHero:
                    return DemoModel.heroArticle()
                case .firstHelper, .secondHelper, .thirdHelper:
                    return DemoModel.articles(count: 4)
            }
        }
        
        var contentInsets: NSDirectionalEdgeInsets {
            switch self {
                case .firstHero, .secondHero, .thirdHero:
                    return NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
                case .firstHelper, .secondHelper, .thirdHelper:
                    return NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 20, trailing: 20)
            }
        }
        
        var title: String? {
            switch self {
                case .firstHero: return "Latest"
                case .secondHero: return "How To"
                case .thirdHero: return "Interviews"
                default: return nil
            }
        }
    }
}
