//
//  SceneDelegate.swift
//  P_App
//
//  Created by Александр Мараенко on 03.04.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let myWindow = UIWindow(windowScene: windowScene )
        myWindow.rootViewController = createUITapBarContoller()
        myWindow.makeKeyAndVisible()
        self.window = myWindow
        
    }

    func createUITapBarContoller() -> UITabBarController {

        let tapBarController = UITabBarController()
        tapBarController.tabBar.backgroundColor = .white
        UITabBar.appearance().tintColor = UIColor(red: 0.99, green: 0.23, blue: 0.41, alpha: 1.00)
        tapBarController.viewControllers = createControllers()
        return tapBarController

    }

    
    func createControllers() -> [UIViewController] {
        
        let viewController = MenuViewController()
        let mvpPresenter = MenuViewControllerPresenter()
        mvpPresenter.mvpView = viewController
        viewController.mvpPresenter = mvpPresenter
        
        let firstNavigationController = UINavigationController(rootViewController: viewController)
//        let image = UIImage(named: "menuTabIcon")
        firstNavigationController.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "menuTabIcon"), tag: 0)
        
        let secondViewController = UIViewController()
        secondViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "contactsTabIcon"), tag: 0)
        
        let thirdViewController = UIViewController()
        thirdViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "profileTabIcon"), tag: 0)
        
        let fourthViewController = UIViewController()
        fourthViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "basketTabIcon"), tag: 0)
        
        return [firstNavigationController, secondViewController, thirdViewController, fourthViewController]
   
    }


    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

