//
//  AppCoordinator.swift
//  Main
//
//  Created by Daniel de Souza Ribas on 11/11/22.
//

import UIKit

class AppCoordinator: Coordinator {
  init(window: UIWindow) {
    self.window = window
  }

  private let window: UIWindow
  var children: [Coordinator] = []

  func start() {
    let nav = UINavigationController()
    let todoListCoordinator = TodoListCoordinator(navigationController: nav)
    children.append(todoListCoordinator)
    window.rootViewController = nav
    window.makeKeyAndVisible()

    todoListCoordinator.start()
  }
}

