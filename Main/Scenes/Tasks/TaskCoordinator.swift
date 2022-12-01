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
    let taskListVC = TaskListViewController(
      taskListViewModel: Factory.makeTaskListViewModel(),
      navigation: self)

    navigationController.setViewControllers(
      [taskListVC],
      animated: false)
  }
}

extension TaskCoordinator: TaskListNavigation {
  func openDetail(_ id: UUID) {
    let taskDetail = TaskDetailViewController(
      viewModel: Factory.makeTaskDetailViewModel(id),
      navigation: self,
      id: id)
    navigationController.pushViewController(taskDetail, animated: true)
  }

  func openAddTaskModal(onDismiss: @escaping () -> Void) {
    let addTaskVC = AddTaskViewController(
      addTaskViewModel: Factory.makeAddTaskViewModel(),
      navigation: self,
      onDismiss: onDismiss)
    let nav = UINavigationController(rootViewController: addTaskVC)
    nav.modalPresentationStyle = .pageSheet

    if let sheet = nav.sheetPresentationController {
      sheet.detents = [.large()]
    }
    navigationController.viewControllers[0].present(nav, animated: true)
  }
}

extension TaskCoordinator: TaskDetailNavigation {
  func returnToTasks() {
    navigationController.popViewController(animated: true)
  }
}

extension TaskCoordinator: AddTaskNavigation {
  func closeModal() {
    navigationController.viewControllers[0].dismiss(animated: true)
  }
}
