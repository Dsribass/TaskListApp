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
  private let navigation: TaskDetailNavigation

  private let finishButton: UIBarButtonItem = {
    return UIBarButtonItem(
      title: "Concluir",
      style: .done,
      target: .none,
      action: .none)
  }()

  init(viewModel: TaskDetailViewModel, navigation: TaskDetailNavigation, id: UUID) {
    self.taskDetailViewModel = viewModel
    self.id = id
    self.navigation = navigation
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
    finishButton.rx.tap
      .bind(to: taskDetailViewModel.onFinishTaskSubject)
      .disposed(by: bag)

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
        case .finished:
          stopLoading()
          navigation.returnToTasks()
        }
      }
      .disposed(by: bag)
  }

  override func setupLayout() {
    super.setupLayout()
  }
}

extension TaskDetailViewController: ViewStates {
  func showTaskDetail(_ task: Task) {
    contentView.configure(title: task.title, description: task.description, priority: task.priority)
    if task.status == .pending {
      self.navigationController?.isToolbarHidden = false
      var items = [UIBarButtonItem]()
      items.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: .none, action: .none))
      items.append(finishButton)
      self.toolbarItems = items
    }
  }
}

protocol TaskDetailNavigation {
  func returnToTasks()
}
