//
//  CellSizes.swift
//  CompositionLayout
//
//  Created by Dane Regnier on 6/10/21.
//

import UIKit

/**
 Cell sizes as measured in Figma for iPhone 12 Pro
 */
class CellSizes {
    fileprivate init() {}
    
    static let liveShow = NSCollectionLayoutSize(widthDimension: .absolute(250), heightDimension: .absolute(310))
    static let video = NSCollectionLayoutSize(widthDimension: .absolute(160), heightDimension: .absolute(350))
    static let playlist = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(128))
    static func brand(orthogonal: Bool) -> NSCollectionLayoutSize {
        let widthFraction: CGFloat = orthogonal ? 0.5 : 1.0
        return NSCollectionLayoutSize(widthDimension: .fractionalWidth(widthFraction), heightDimension: .absolute(170))
    }
    static let creator = NSCollectionLayoutSize(widthDimension: .absolute(230), heightDimension: .absolute(330))
    static let list = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44))
    
    static let heroArticle = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(360))
    static let article = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.85), heightDimension: .absolute(120))
}
