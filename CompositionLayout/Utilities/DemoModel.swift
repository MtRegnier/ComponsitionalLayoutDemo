//
//  DemoModel.swift
//  CompositionLayout
//
//  Created by Dane Regnier on 6/10/21.
//

import UIKit

/// Very simple model used to configure the text cells
class DemoModel: Hashable, TextCellConfig {
    let text: String
    let bgColor: UIColor
    
    fileprivate init(text t: String, bgColor bg: UIColor) {
        text = t
        bgColor = bg
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
    
    static func == (lhs: DemoModel, rhs: DemoModel) -> Bool {
        return lhs.uuid == rhs.uuid
    }
    
    fileprivate let uuid = UUID()
}

extension DemoModel {
    /**
     Convenience method for setting up arrays of the demo model
     */
    static func createArray(count: Int, prefix: String, color: UIColor) -> [DemoModel] {
        return Array(0..<count).map({ DemoModel(text: "\(prefix) \($0)", bgColor: color)})
    }
    
    static func liveShows(count: Int) -> [DemoModel] {
        return createArray(count: count, prefix: "Live Show", color: .systemTeal)
    }
    
    static func spotlight(count: Int) -> [DemoModel] {
        return createArray(count: count, prefix: "Spotlight", color: .systemOrange)
    }
    
    static func brands(count: Int) -> [DemoModel] {
        return createArray(count: count, prefix: "Brand", color: .systemGreen)
    }
    
    static func forYou(count: Int) -> [DemoModel] {
        return createArray(count: count, prefix: "For You", color: .blue)
    }
    
    static func playlists(count: Int) -> [DemoModel] {
        return createArray(count: count, prefix: "Playlist", color: .systemPink)
    }
    
    static func creators(count: Int) -> [DemoModel] {
        return createArray(count: count, prefix: "Creator", color: .systemPurple)
    }
    
    static func tools(count: Int) -> [DemoModel] {
        return createArray(count: count, prefix: "Tool", color: .systemRed)
    }
    
    static func products(isForYou: Bool, count: Int) -> [DemoModel] {
        return createArray(count: count, prefix: isForYou ? "Product For You" : "Top Product", color: .clear)
    }
    
    static func heroArticle() -> [DemoModel] {
        return [DemoModel(text: "Hero Article", bgColor: .systemIndigo)]
    }
    
    static func articles(count: Int) -> [DemoModel] {
        return createArray(count: count, prefix: "Article", color: .systemYellow)
    }
    
    static func categoryVideo(count: Int) -> [DemoModel] {
        return createArray(count: count, prefix: "Category", color: .systemGray2)
    }
    
    static func rewardVideo(count: Int) -> [DemoModel] {
        return createArray(count: count, prefix: "Reward", color: .systemTeal)
    }
}

class LayoutOption: DemoModel {
    let controller: UIViewController.Type?
    
    init(title t: String, controller c: UIViewController.Type) {
        controller = c
        super.init(text: t, bgColor: .systemBackground)
    }
}
