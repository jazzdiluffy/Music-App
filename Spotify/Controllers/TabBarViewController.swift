//
//  TabBarViewController.swift
//  Spotify
//
//  Created by Ilya Buldin on 10.05.2021.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let vc1 = HomeViewController()
        let vc2 = SearchViewController()
        let vc3 = LibraryViewController()
        
        vc1.title = "Home"
        vc2.title = "Search"
        vc3.title = "Library"
        
        vc1.navigationItem.largeTitleDisplayMode = .always
        vc2.navigationItem.largeTitleDisplayMode = .always
        vc3.navigationItem.largeTitleDisplayMode = .always
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemBackground
        
        let nav1 = UINavigationController(rootViewController: vc1)
        nav1.navigationBar.compactAppearance = appearance
        
        let nav2 = UINavigationController(rootViewController: vc2)
        nav2.navigationBar.compactAppearance = appearance
        
        let nav3 = UINavigationController(rootViewController: vc3)
        nav3.navigationBar.compactAppearance = appearance
        
        
        nav1.navigationBar.tintColor = .label
        nav2.navigationBar.tintColor = .label
        nav3.navigationBar.tintColor = .label
        
        nav1.tabBarItem = UITabBarItem(title: "Home",
                                       image: UIImage(systemName: "house"),
                                       tag: 1
        )
        nav2.tabBarItem = UITabBarItem(title: "Search",
                                       image: UIImage(systemName: "magnifyingglass"),
                                       tag: 2
        )
        nav3.tabBarItem = UITabBarItem(title: "Library",
                                       image: UIImage(systemName: "books.vertical"),
                                       tag: 3
        )
        
        tabBar.tintColor = .label
        tabBar.layer.masksToBounds = true
        tabBar.layer.cornerRadius = 15
        
        
        nav1.navigationBar.prefersLargeTitles = true
        nav2.navigationBar.prefersLargeTitles = true
        nav3.navigationBar.prefersLargeTitles = true
        
        setViewControllers([nav1, nav2, nav3], animated: false)
    }

}
