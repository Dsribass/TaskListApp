//
//  TodoListCoordinator.swift
//  Main
//
//  Created by Daniel de Souza Ribas on 11/11/22.
//

import UIKit

class TaskCoordinator: Coordinator {
  let navigationController: UINavigationController

  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }

  func start() {
    navigationController.navigationBar.prefersLargeTitles = true
    let taskListVC = TaskListViewController()

    navigationController.setViewControllers(
      [taskListVC],
      animated: false)
  }
}
