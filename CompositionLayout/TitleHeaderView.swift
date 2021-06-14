//
//  TitleHeaderView.swift
//  CompositionLayout
//
//  Created by Dane Regnier on 6/14/21.
//

import UIKit

class TitleHeaderView: UICollectionReusableView, DemoCollectionSubView {
    let label = UILabel()
    static let reuseId = "title-header-view"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLabel(in: self, textAlignment: .left, font: .preferredFont(forTextStyle: .subheadline), insets: NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:)") }
}

// Registration/dequeue convenience methods
extension TitleHeaderView {
    static func register(to collection: UICollectionView) {
        collection.register(self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: reuseId)
    }
    
    static func dequeued(from collection: UICollectionView, for indexPath: IndexPath) -> TitleHeaderView? {
        return collection.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: reuseId, for: indexPath) as? TitleHeaderView
    }
}

// Cells and headers have extremely similar styling. Protocol is for convenience
protocol DemoCollectionSubView {
    var label: UILabel { get }
    func setupLabel(in targetView: UIView, textAlignment: NSTextAlignment, font: UIFont, insets: NSDirectionalEdgeInsets)
}

extension DemoCollectionSubView {
    func setupLabel(in targetView: UIView, textAlignment: NSTextAlignment, font: UIFont, insets: NSDirectionalEdgeInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)) {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.textAlignment = textAlignment
        targetView.addSubview(label)
        label.font = font
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: targetView.leadingAnchor, constant: insets.leading),
            label.trailingAnchor.constraint(equalTo: targetView.trailingAnchor, constant: -insets.trailing),
            label.topAnchor.constraint(equalTo: targetView.topAnchor, constant: insets.top),
            label.bottomAnchor.constraint(equalTo: targetView.bottomAnchor, constant: -insets.bottom),
        ])
    }
}
