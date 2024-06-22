//
//  MainTabBarViewController.swift
//  Netflix Clone
//
//  Created by Milad Marandi on 5/24/24.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        overrideUserInterfaceStyle = .dark
        
        let HomePageVC = UINavigationController(rootViewController: HomePageViewController())
        let ComingSoonVC = UINavigationController(rootViewController: ComingSoonViewController())
        let TopSearchesVC = UINavigationController(rootViewController: TopSearchesViewController())
        let DownloadsVC = UINavigationController(rootViewController: DownloadsViewController())
        
        HomePageVC.tabBarItem = UITabBarItem(title: "HomePage", image: UIImage(systemName: "house.fill"), tag: 1)
        ComingSoonVC.tabBarItem = UITabBarItem(title: "ComingSoon", image: UIImage(systemName: "play.circle.fill"), tag: 2)
        
        TopSearchesVC.tabBarItem = UITabBarItem(title: "TopSearches", image: UIImage(systemName: "magnifyingglass"), tag: 3)
        
        DownloadsVC.tabBarItem = UITabBarItem(title: "Downloads", image: UIImage(systemName: "arrow.down.to.line"), tag: 4)
        
        HomePageVC.navigationBar.tintColor = .label
        
        ComingSoonVC.navigationBar.tintColor = .label
        
        TopSearchesVC.navigationBar.tintColor = .label
        
        DownloadsVC.navigationBar.tintColor = .label
        
        self.tabBar.tintColor = .label
        
        ComingSoonVC.navigationBar.prefersLargeTitles = true
        TopSearchesVC.navigationBar.prefersLargeTitles = true
        DownloadsVC.navigationBar.prefersLargeTitles = true
        
        
        self.setViewControllers([HomePageVC , ComingSoonVC , TopSearchesVC , DownloadsVC], animated: true)
        
        
        
    }


}
