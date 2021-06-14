/*
 Apple, iPhone, iMac, iPad Pro, Apple Pencil, Apple Watch, App Store, TestFlight, Siri, and SiriKit are trademarks of Apple, Inc.
 
 The following license applies to the source code, and other elements of this package:
 
 Copyright © 2021 Apple Inc.
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

import UIKit

protocol TextCellConfig {
    var text: String { get }
    var bgColor: UIColor { get }
}

class TextCell: UICollectionViewCell, DemoCollectionSubView {
    let label = UILabel()
    static let reuseId = "simple-cell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // All cells share the same corner radius
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
        
        setupLabel(in: contentView, textAlignment: .center, font: .preferredFont(forTextStyle: .caption1))
    }
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:)") }
}

extension TextCell {
    func configure(config: TextCellConfig) {
        label.text = config.text
        contentView.backgroundColor = config.bgColor
    }
}

// Registration/dequeue convenience methods
extension TextCell {
    static func register(to collection: UICollectionView) {
        collection.register(self, forCellWithReuseIdentifier: reuseId)
    }
    
    static func dequeued(from collection: UICollectionView, for indexPath: IndexPath) -> TextCell? {
        return collection.dequeueReusableCell(withReuseIdentifier: reuseId, for: indexPath) as? TextCell
    }
}
