//
//  TabBarViewController.swift
//  BetOnCrypto
//
//  Created by marty.academy on 3/7/25.
//

import UIKit

final class TabBarViewController: UITabBarController {
    
    let unselectedColor = DesignSystem.Color.Background.segment.inUIColor()
    let selectedColor = DesignSystem.Color.Renewal.tint.inUIColor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewControllers()
        configureTabBarAppearance()
        
        tabBar.tintColor = selectedColor
    }
    
    private func configureViewControllers() {
        
        let searchVCSymbol = DesignSystem.Icon.Info.coinAndNft.toUIImage().withTintColor(unselectedColor)
        let searchVCSymbolSelected = DesignSystem.Icon.Info.coinAndNft.toUIImage().withTintColor(selectedColor)
        let searchNC = UINavigationController(rootViewController: TrendingViewController())
        searchNC.tabBarItem = UITabBarItem(title: "", image: searchVCSymbol, selectedImage: searchVCSymbolSelected)
        //UITabBarItem(title: "", image: searchVCSymbol, tag: 0)
        
        
        let marketVCSymbol = DesignSystem.Icon.Info.exchange.toUIImage().withTintColor(unselectedColor)
        let marketVCSymbolSelected = DesignSystem.Icon.Info.exchange.toUIImage().withTintColor(selectedColor)
        let mainNC = UINavigationController(rootViewController: MarketViewController())
        mainNC.tabBarItem = UITabBarItem(title: "", image: marketVCSymbol, selectedImage: marketVCSymbolSelected)
        //UITabBarItem(title: "", image: marketVCSymbol, tag: 1)
        
        setViewControllers([searchNC, mainNC], animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let inset: CGFloat = 16
        let height: CGFloat = 60
        let tabFrame = CGRect(
            x: inset,
            y: view.bounds.height - height - view.safeAreaInsets.bottom - 10,
            width: view.bounds.width - (inset * 2),
            height: height
        )

        tabBar.frame = tabFrame
        tabBar.layer.cornerRadius = 24
        tabBar.layer.masksToBounds = true
        tabBar.layer.borderWidth = 0
    }
    
    private func configureTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithDefaultBackground()
        
        // 블러 효과 + 반투명 백그라운드 (dock 느낌)
        appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        appearance.backgroundColor = UIColor.white.withAlphaComponent(0.05)
        
        // 그림자 제거
        appearance.shadowImage = nil
        appearance.shadowColor = nil
        
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
    }
}

extension TabBarViewController: UITabBarControllerDelegate {}
