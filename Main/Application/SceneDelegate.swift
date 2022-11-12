//
//  SceneDelegate.swift
//  TodoListApp
//
//  Created by Daniel de Souza Ribas on 11/11/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?
  var appCoordinator: AppCoordinator?

  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let window = createUIWindow(scene: scene) else {
      return
    }
    let appCoordinator = AppCoordinator(window: window)
    appCoordinator.start()

    self.window = window
    self.appCoordinator = appCoordinator
  }

  private func createUIWindow(scene: UIScene) -> UIWindow? {
    guard let windowScene = (scene as? UIWindowScene) else { return nil }
    let window = UIWindow(windowScene: windowScene)
    window.frame = UIScreen.main.bounds
    
    return window
  }
}
