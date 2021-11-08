// HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import UIKit

enum VCFactory {
    static func buildAuthVC() -> UIViewController? {
        let vc = StoryboardScene.Auth.initialScene.instantiate()
        let authService = CoreFactory.buildAuthService()
        let snacker = CoreFactory.snacker
        vc.setup(with: authService, snacker)
        return vc
    }

    static func buildTabBarVC() -> UIViewController? {
        let tabBarVC = StoryboardScene.TabBar.initialScene.instantiate()
        tabBarVC.viewControllers?.forEach { vc in
            guard let nvc = vc as? UINavigationController, let rootVC = nvc.viewControllers.first else {
                return
            }
            nvc.navigationBar.prefersLargeTitles = true
            switch rootVC {
            case let vc as ProfileVC:
                
                let dataService = CoreFactory.dataService
                let authService = CoreFactory.buildAuthService()
               // let snacker = CoreFactory.snacker
                vc.setup(with: authService, dataService: dataService)
                
            case let vc as HistoryVC:
                let historyService = CoreFactory.buildHistoryService()
                vc.setup(with: historyService)

            
            case let vc as CatalogVC:
                vc.catalogService = CoreFactory.buildCatalogService()
                vc.snacker = CoreFactory.snacker
            default:
                break
            }
        }
        return tabBarVC
    }

    static func buildProductVC(with product: Product) -> UIViewController {
        let vc = ProductVC()
        vc.product = product
        return vc
    }
    static func buildOrderVC(with product: Product) -> UIViewController {
        let vc = OrderVC()
        let orderServise = CoreFactory.buildOrderService()
        let snacker = CoreFactory.snacker
        vc.setup(with: orderServise, snacker: snacker )
        vc.product = product
        return vc
    }
    static func buildBottomSheetController(with contentView: UIView, onEveryTapOut: (() -> Void)?) -> UIViewController {
        let parameters = BottomSheetParameters(contentView: contentView, onEveryTapOut: onEveryTapOut)
        let vc = BottomSheetController(arguments: parameters)
        vc.transitioningDelegate = vc
        return vc
    }
    
    static func buildEtidPage(with profile: Profile) -> UIViewController {
        let vc = EditProfileVC()
        vc.profile = profile
        let authService = CoreFactory.buildEditServise()
        let snacker = CoreFactory.snacker
        vc.setup(with: authService, snacker )
        return vc
    }
    
    
}
