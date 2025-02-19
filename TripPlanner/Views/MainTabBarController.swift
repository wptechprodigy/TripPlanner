//
//  MainTabBarController.swift
//  TripPlanner
//
//  Created by waheedCodes on 19/02/2025.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeVC = UIViewController()
        let generatorVC = UIViewController()
        let addVC = UIViewController()
        let favoriteVC = UIViewController()
        let plannerVC = UIViewController()
        
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 0)
        generatorVC.tabBarItem = UITabBarItem(title: "Generator", image: UIImage(systemName: "wand.and.rays"), tag: 1)
        addVC.tabBarItem = UITabBarItem(title: "Add", image: UIImage(systemName: "plus.circle.fill"), tag: 2)
        favoriteVC.tabBarItem = UITabBarItem(title: "Favourite", image: UIImage(systemName: "heart.fill"), tag: 3)
        plannerVC.tabBarItem = UITabBarItem(title: "Planner", image: UIImage(systemName: "calendar"), tag: 4)
        
        let homeNav = UINavigationController(rootViewController: homeVC)
        let generatorNav = UINavigationController(rootViewController: generatorVC)
        let addNav = UINavigationController(rootViewController: addVC)
        let favoriteNav = UINavigationController(rootViewController: favoriteVC)
        let plannerNav = UINavigationController(rootViewController: plannerVC)
        
        viewControllers = [homeNav, generatorNav, addNav, favoriteNav, plannerNav]
        
        tabBar.tintColor = .systemBlue
        tabBar.barTintColor = .white
    }
}
