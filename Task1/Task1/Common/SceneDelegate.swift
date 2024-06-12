//
//  SceneDelegate.swift
//  Task1
//
//  Created by Евгений Митюля on 6/11/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        self.window = UIWindow(windowScene: windowScene)
        self.window?.rootViewController = CalculatorBuilder.setupModule()
        self.window?.makeKeyAndVisible()
    }
}

