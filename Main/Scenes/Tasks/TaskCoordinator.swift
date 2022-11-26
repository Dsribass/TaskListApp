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
  func openDetail(_ id: UUID) {
    let service = FakeTaskServiceImpl()
    let viewModel = TaskDetailViewModel(id: id, service: service)
    let taskDetail = TaskDetailViewController(
      viewModel: viewModel,
      navigation: self,
      id: id)
    navigationController.pushViewController(taskDetail, animated: true)
  }

  func openAddTaskModal(onDismiss: @escaping () -> Void) {
    let service = FakeTaskServiceImpl()
    let viewModel = AddTaskViewModel(service: service)
    let addTaskVC = AddTaskViewController(
      addTaskViewModel: viewModel,
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
