//
//  SceneDelegate.swift
//  CocktailApp
//
//  Created by Новый пользователь on 11.03.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
 
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        let navigationController = UINavigationController(rootViewController: CocktailViewController())
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}


