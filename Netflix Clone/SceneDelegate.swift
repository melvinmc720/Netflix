//
//  SceneDelegate.swift
//  Netflix Clone
//
//  Created by milad marandi on 5/24/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowscene = (scene as? UIWindowScene) else { return }
        
        self.window = UIWindow(windowScene: windowscene)
        self.window?.frame = windowscene.screen.bounds
        self.window?.rootViewController = MainTabBarViewController()
        self.window?.makeKeyAndVisible()
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        print("Disconnect")
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        NotificationCenter.default.post(name: NSNotification.Name("PlayVideo"), object: nil)
    }

    func sceneWillResignActive(_ scene: UIScene) {
        NotificationCenter.default.post(name: NSNotification.Name("PauseVideo"), object: nil)
        
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        NotificationCenter.default.post(name: NSNotification.Name("PlayVideo"), object: nil)
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        NotificationCenter.default.post(name: NSNotification.Name("ReplayVideo"), object: nil)
    }


}

