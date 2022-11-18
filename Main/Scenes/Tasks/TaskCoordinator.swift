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

    let service = FakeTaskServiceImpl()
    let viewModel = TaskListViewModel(service: service)
    let taskListVC = TaskListViewController(taskListViewModel: viewModel,navigation: self)

    navigationController.setViewControllers(
      [taskListVC],
      animated: false)
  }
}

extension TaskCoordinator: TaskListNavigation {
  func openAddTaskModal() {
    let addTaskVC = AddTaskViewController()
    let nav = UINavigationController(rootViewController: addTaskVC)
    nav.modalPresentationStyle = .pageSheet

    if let sheet = nav.sheetPresentationController {
      sheet.detents = [.custom {_ in 200}]
    }
    navigationController.viewControllers[0].present(nav, animated: true)
  }
}
