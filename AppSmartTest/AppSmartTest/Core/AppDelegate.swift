//
//  AppDelegate.swift
//  AppSmartTest
//
//  Created by Vitaly Khomatov on 01.03.2021.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navController = UINavigationController()
 //   private let network = NetworkMonitor()
    var viewController = CharactersCollectionViewController()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
                
        //let viewController = CharactersCollectionViewController()
        navController = UINavigationController.init(rootViewController: viewController)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navController
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
        
        return true
    }
    
    /*private func startNetworkMonitor() {
        if !network.getNetworkStatus() {
            DispatchQueue.main.async {
                guard let navcontroller = self.navController.view else { return }
                let errorMessage = ErrorMessage(view: navcontroller)
                errorMessage.showError(reverse: true, message: "Offline Mode", delay: 3.0)
            }
        }
        
        self.network.monitor.pathUpdateHandler = { [weak self] path in
            guard let self = self else { return }
            if path.status == .satisfied {
                DispatchQueue.main.async {
                    guard let navcontroller = self.navController.view else { return }

                    let errorMessage = ErrorMessage(view: navcontroller)
                        errorMessage.showError(reverse: true, message: "Back to Online", delay: 3.0)
                }
            } else if path.status == .unsatisfied {
                DispatchQueue.main.async {
                    guard let navcontroller = self.navController.view else { return }
                    let errorMessage = ErrorMessage(view: navcontroller)
                        errorMessage.showError(reverse: true, message: "Offline Mode", delay: 3.0)
                }
            }
        }
    } */

    func applicationWillResignActive(_ application: UIApplication) {
        
//        viewController.startNetworkMonitor()
//        if !viewController.network.getNetworkStatus() {
//            DispatchQueue.main.async {
//                let errorMessage = ErrorMessage(view: self.navController.view)
//                errorMessage.showError(reverse: true, message: "Offline Mode", delay: 3.0)
//            }
//        }
        
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

