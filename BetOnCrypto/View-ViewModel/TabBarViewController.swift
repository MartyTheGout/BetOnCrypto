//
//  TabBarViewController.swift
//  BetOnCrypto
//
//  Created by marty.academy on 3/7/25.
//

import UIKit

final class TabBarViewController: UITabBarController {

    let unselectedColor = DesignSystem.Color.Background.segment.inUIColor()
    let selectedColor = DesignSystem.Color.Tint.main.inUIColor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewControllers()
        
        tabBar.tintColor = selectedColor
    }
    
    private func configureViewControllers() {
        
        let marketVCSymbol = DesignSystem.Icon.Info.exchange.toUIImage().withTintColor(unselectedColor)
        let mainNC = UINavigationController(rootViewController: MarketViewController())
        mainNC.tabBarItem = UITabBarItem(title: "거래소", image: marketVCSymbol, tag: 0)
        
        let searchVCSymbol = DesignSystem.Icon.Info.coinAndNft.toUIImage().withTintColor(unselectedColor)
        let searchNC = UINavigationController(rootViewController: TrendingViewController())
        searchNC.tabBarItem = UITabBarItem(title: "코인정보", image: searchVCSymbol, tag: 1)
        
        let portfolioVCSymbol = DesignSystem.Icon.Input.star.toUIImage().withTintColor(unselectedColor)
        let portfolioVC = PortfolioViewController()
        portfolioVC.tabBarItem = UITabBarItem(title: "포트폴리오", image: portfolioVCSymbol, tag: 2)
        
        setViewControllers([mainNC, searchNC, portfolioVC], animated: true)
    }
}

extension TabBarViewController: UITabBarControllerDelegate {}
