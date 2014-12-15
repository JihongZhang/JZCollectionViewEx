//
//  AppDelegate.swift
//  JZCollectionViewEx
//
//  Created by Jihong Zhang on 12/12/14.
//  Copyright (c) 2014 Jihong Zhang. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication!, didFinishLaunchingWithOptions launchOptions: NSDictionary!) -> Bool {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        if let window = window {
            //let vc1:UIViewController = ViewController()
            let vc1:UIViewController = ProductsCollectionView()
            let nav1 = UINavigationController(rootViewController: vc1);
            
            let image1 = UIImage(named:"icon_shop");
            nav1.tabBarItem = UITabBarItem(title: "SHOP", image:image1, tag: 1);
            
            
            let vc2:UIViewController =  ProductsCollectionView()
            let nav2 = UINavigationController(rootViewController: vc2);
            let image2 = UIImage(named: "icon_consign");
            nav2.tabBarItem = UITabBarItem(title: "CONSIGN", image:image2, tag: 2);
            
            let vc3:UIViewController =  ProductsCollectionView()
            let nav3 = UINavigationController(rootViewController: vc3);
            let image3 = UIImage(named:"icon_me");
            nav3.tabBarItem = UITabBarItem(title: "ME", image:image3, tag: 3);
            
            let vc4:UIViewController =  ProductsCollectionView()
            let nav4 = UINavigationController(rootViewController: vc4);
            let image4 = UIImage(named:"my_feed_edit");
            nav4.tabBarItem = UITabBarItem(title: "FEEDS", image:image4, tag: 3);
            
            let vc5:UIViewController =  ProductsCollectionView()
            let nav5 = UINavigationController(rootViewController: vc5);
            let image5 = UIImage(named:"tabbar_search");
            nav5.tabBarItem = UITabBarItem(title: "SEARCH", image:image5, tag: 3);
            
            let arr = [nav1, nav2, nav3, nav4, nav5 ];
            let tabBarController = UITabBarController();
            tabBarController.viewControllers = arr;
            self.window!.rootViewController = tabBarController;
            
            
            window.backgroundColor = UIColor.whiteColor()
            window.makeKeyAndVisible()
            //window.rootViewController = nav1
        }
        return true
        
        if let window = window {
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window!.backgroundColor = UIColor.whiteColor()
        
        let vc1:UIViewController = ProductsCollectionView()
        let nav1 = UINavigationController(rootViewController: vc1);
        //let image1 = UIImage(named:"obsess_icon_selected");
        //nav1.tabBarItem = UITabBarItem(title: "First", image:image1, tag: 1);
        
        let vc2:UIViewController =  ProductsCollectionView()
        let nav2 = UINavigationController(rootViewController: vc2);
        //let image2 = UIImage(named: "globe");
        //nav2.tabBarItem = UITabBarItem(title: "Second", image:image2, tag: 2);
        
        let vc3:UIViewController =  ProductsCollectionView()
        let nav3 = UINavigationController(rootViewController: vc3);
        //let image3 = UIImage(named:"icon_settings");
        //nav3.tabBarItem = UITabBarItem(title: "Third", image:image3, tag: 3);
        
        let arr = [nav1, nav2, nav3];
        let tabBarController = UITabBarController();
        tabBarController.viewControllers = arr;
        self.window!.rootViewController = tabBarController;
        
        
        window.backgroundColor = UIColor.whiteColor()
        window.makeKeyAndVisible()
        window.rootViewController = nav1
        }
        
        return true

    }

    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

