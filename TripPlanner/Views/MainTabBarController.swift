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
        
        let homeVC = HomeViewController()
        let generatorVC = GeneratorViewController()
        let addVC = AddViewController()
        let favoriteVC = FavouriteViewController()
        let plannerVC = PlannerViewController()
        
        generatorVC.title = "Generator"
        addVC.title = "Add"
        favoriteVC.title = "Favourite"
        plannerVC.title = "Planner"
        
        let homeNav = UINavigationController(rootViewController: homeVC)
        let generatorNav = UINavigationController(rootViewController: generatorVC)
        let addNav = UINavigationController(rootViewController: addVC)
        let favoriteNav = UINavigationController(rootViewController: favoriteVC)
        let plannerNav = UINavigationController(rootViewController: plannerVC)
        
        homeNav.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 0)
        generatorNav.tabBarItem = UITabBarItem(title: "Generator", image: UIImage(systemName: "wand.and.rays"), tag: 1)
        addNav.tabBarItem = UITabBarItem(title: "Add", image: UIImage(systemName: "plus.circle.fill"), tag: 2)
        favoriteNav.tabBarItem = UITabBarItem(title: "Favourite", image: UIImage(systemName: "heart.fill"), tag: 3)
        plannerNav.tabBarItem = UITabBarItem(title: "Planner", image: UIImage(systemName: "calendar"), tag: 4)
        
        viewControllers = [homeNav, generatorNav, addNav, favoriteNav, plannerNav]
        
        view.backgroundColor = .white
        
        tabBar.tintColor = .systemBlue
        tabBar.barTintColor = .white
        tabBar.backgroundColor = .white
        tabBar.isTranslucent = false
    }
}
