//
//  PagedDemoViewController.swift
//  CompositionLayout
//
//  Created by Dane Regnier on 6/10/21.
//

import UIKit

class PagedDemoViewController: UIViewController {
    let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    let pages: [UIViewController] = [FeaturedViewController(), ArticlesViewController(), PlaylistsViewController(), BrandsViewController(), CategoriesViewController()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPageViewController()
        
        // Start out by using the title of the first view controller in our array
        title = pages.first?.title
    }
}

extension PagedDemoViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    /// Page view controller setup
    func setupPageViewController() {
        pageViewController.view.backgroundColor = .systemGroupedBackground
        pageViewController.dataSource = self
        pageViewController.delegate = self
        pageViewController.view.frame = view.bounds
        pageViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        
        pageViewController.setViewControllers([pages[0]], direction: .forward, animated: false, completion: nil)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index != 0 else { return nil }
        return pages[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index < pages.count - 1 else { return nil }
        return pages[index + 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard finished, completed else { return }
        DispatchQueue.main.async { [unowned self] in
            guard let firstVc = self.pageViewController.viewControllers?.first else { return }
            self.title = firstVc.title
        }
    }
}
