//
//  CollectionLayoutHelper.swift
//  CompositionLayout
//
//  Created by Dane Regnier on 6/10/21.
//

import UIKit

/**
 Reduces the remaining boilerplate for the new compositional layout system
 */
class CollectionLayoutHelper {
    fileprivate init() {}
    
    // All collections throughout the app use ~ 20pt insets
    static let defaultOuterInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
    // All collections throughout the app use 10pt interitem spacing
    fileprivate static let itemSpacing = NSCollectionLayoutSpacing.fixed(10)
    static let interSectionSpacing = CGFloat(10)
    
    /**
     Returns an NSLayoutCollecitonSection with each group fitted to its item. Reduces what little boilerplate remains.
     */
    static func horizontalGroupSection(itemSize: NSCollectionLayoutSize, columnCount: Int, orthogonalBehavior ortho: UICollectionLayoutSectionOrthogonalScrollingBehavior = .none, contentInsets: NSDirectionalEdgeInsets = defaultOuterInsets, title: String? = nil) -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        // Right now, the only item in this group is the cell itself, so the group has the same size as the subitem
        // This would change if we were adding supplementary views
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: itemSize, subitem: item, count: columnCount)
        group.interItemSpacing = itemSpacing
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = contentInsets
        section.interGroupSpacing = itemSpacing.spacing
        section.orthogonalScrollingBehavior = ortho
        if let _ = title {
            section.boundarySupplementaryItems = [titleHeader()]
        }
        return section
    }
    
    // Convenience method for collections with sections set up
    static func horizontalGroupSection(config: HorizontalGroupSectionConfig) -> NSCollectionLayoutSection {
        return horizontalGroupSection(itemSize: config.itemSize, columnCount: config.columnCount, orthogonalBehavior: config.orthogonalBehavior, contentInsets: config.contentInsets, title: config.title)
    }
    
    // Convenience method for creating a section title header
    static func titleHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        return NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
    }
}

/**
 All of the variables needed to set up our simple CollectionLayoutGroup
 */
protocol HorizontalGroupSectionConfig {
    var itemSize: NSCollectionLayoutSize { get }
    var columnCount: Int { get }
    var orthogonalBehavior: UICollectionLayoutSectionOrthogonalScrollingBehavior { get }
    var contentInsets: NSDirectionalEdgeInsets { get }
    var title: String? { get }
}
