//
//  TaskDetailViewController.swift
//  Main
//
//  Created by Daniel de Souza Ribas on 22/11/22.
//

import UIKit
import SnapKit

class TaskDetailViewController: SceneViewController<TaskDetailView> {
  private let id: UUID
  private let taskDetailViewModel: TaskDetailViewModel

  init(viewModel: TaskDetailViewModel, id: UUID) {
    self.taskDetailViewModel = viewModel
    self.id = id
    super.init(
      nibName: String(describing: TaskDetailViewController.self),
      bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setupObservables()
  }

  func setupObservables() {
    taskDetailViewModel.statesObservable
      .bind { [unowned self] states in
        switch states {
        case .loading:
          startLoading()
        case .error:
          stopLoading()
          showError()
        case .success(let task):
          stopLoading()
          showTaskDetail(task)
        }
      }
      .disposed(by: bag)
  }
}

extension TaskDetailViewController: ViewStates {
  func showTaskDetail(_ task: Task) {
    contentView.configure(title: task.title, description: task.description, priority: task.priority)
  }
}
