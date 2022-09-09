//
//  MainViewController.swift
//  SnapKitLayout
//
//  Created by JUNO on 2022/09/02.
//

import UIKit

protocol CollectionControlDelegate: AnyObject {
    func deleteCell(indexPath: Int)
}

class MainViewController: UITabBarController {
    
    private lazy var tableview: UINavigationController = {
        let viewController = TableVC()
        
        viewController.title = "TableView"
        viewController.navigationItem.largeTitleDisplayMode = .always
        
        let navigationView = UINavigationController(rootViewController: viewController)
        navigationView.navigationBar.isTranslucent = false
        
        viewController.tabBarItem = UITabBarItem (
            title: "테이블",
            image: UIImage(systemName: "table"),
            selectedImage: UIImage(systemName: "table.fill")
        )
        return navigationView
    }()
    
    private lazy var vertical: UINavigationController = {
        let viewController = VerticalCollectionVC()
        
        viewController.title = "Vertical CV"
        viewController.navigationItem.largeTitleDisplayMode = .always
        
        let navigationView = UINavigationController(rootViewController: viewController)
        navigationView.navigationBar.isTranslucent = false
        
        viewController.tabBarItem = UITabBarItem (
            title: "수직",
            image: UIImage(systemName: "arrow.up.and.down.square"),
            selectedImage: UIImage(systemName: "arrow.up.and.down.square.fill")
        )
        return navigationView
    }()
    
    private lazy var horizontal: UINavigationController = {
        let viewController = HorizontalCollectionVC()
        
        viewController.title = "Horizontal CV"
        viewController.navigationItem.largeTitleDisplayMode = .always
        
        let navigationView = UINavigationController(rootViewController: viewController)
        navigationView.navigationBar.isTranslucent = false
        
        viewController.tabBarItem = UITabBarItem (
            title: "수평",
            image: UIImage(systemName: "arrow.left.and.right.square"),
            selectedImage: UIImage(systemName: "arrow.left.and.right.square.fill")
        )
        return navigationView
    }()
    
    private lazy var grid: UINavigationController = {
        let viewController = GridCollectionVC()
        
        viewController.title = "Grid CV"
        viewController.navigationItem.largeTitleDisplayMode = .always
        
        let navigationView = UINavigationController(rootViewController: viewController)
        navigationView.navigationBar.isTranslucent = false
        
        viewController.tabBarItem = UITabBarItem (
            title: "그리드",
            image: UIImage(systemName: "square.grid.2x2"),
            selectedImage: UIImage(systemName: "square.grid.2x2.fill")
        )
        return navigationView
    }()
    
    private lazy var composite: UINavigationController = {
        let viewController = CompositeCollectionVC()
        
        viewController.title = "Composite CV"
        viewController.navigationItem.largeTitleDisplayMode = .always
        
        let navigationView = UINavigationController(rootViewController: viewController)
        navigationView.navigationBar.isTranslucent = false
        
        viewController.tabBarItem = UITabBarItem (
            title: "복합",
            image: UIImage(systemName: "cube"),
            selectedImage: UIImage(systemName: "cube.fill")
        )
        return navigationView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [
            tableview,
            vertical,
            horizontal,
            grid,
            composite
        ]
        
        setTabBarBackground()
    }

    func setTabBarBackground(){
        tabBar.backgroundColor = .systemBackground
        //tabBar.isTranslucent = false
    }
}

