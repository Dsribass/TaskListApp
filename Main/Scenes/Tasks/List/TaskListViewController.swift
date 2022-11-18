//
//  TaskListViewController.swift
//  Main
//
//  Created by Daniel de Souza Ribas on 11/11/22.
//

import UIKit
import RxCocoa
import RxDataSources
import RxSwift

class TaskListViewController: SceneViewController<TaskListView> {

  typealias TaskSectionModel = SectionModel<String, Task>
  typealias DataSource = RxTableViewSectionedReloadDataSource<TaskSectionModel>

  // MARK: - Properties
  private let navigation: TaskListNavigation
  private let taskListViewModel: TaskListViewModel

  let dataSource: DataSource = {
    DataSource(
      configureCell: { (_, table, _, task) in
        let cell = table.dequeueReusableCell(withIdentifier: TaskCell.reuseIdentifier) as! TaskCell
        cell.configure(
          priority: {
            switch(task.priority) {
            case .high: return .high
            case .medium: return .medium
            case .low: return .low
            }
          }(),
          title: task.title)

        return cell
      },
      titleForHeaderInSection: { dataSource, sectionIndex in
        return dataSource[sectionIndex].model
      }
    )
  }()

  private let tasksSectionsSubject = BehaviorSubject<[TaskSectionModel]>(value: [])
  private var tasksSections: Observable<[TaskSectionModel]> {
    tasksSectionsSubject
  }

  // MARK: - Initializers
  init(taskListViewModel: TaskListViewModel, navigation: TaskListNavigation) {
    self.taskListViewModel = taskListViewModel
    self.navigation = navigation
    super.init(nibName: nil,bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupObservables()
  }

  // MARK: - Methods
  func setupObservables() {
    taskListViewModel.statesObservable
      .bind { [unowned self] states in
        switch states {
        case .loading:
          startLoading()
        case .error:
          stopLoading()
          showError()
        case .success(let tasks):
          stopLoading()
          showTasks(tasks)
        }
      }
      .disposed(by: bag)

    tasksSections
      .bind(to: contentView.tableView.rx
        .items(dataSource: dataSource)
      )
      .disposed(by: bag)

    navigationItem.rightBarButtonItem?.rx.tap
      .bind { [unowned self] _ in navigation.openAddTaskModal() }
      .disposed(by: bag)
  }

  override func setupLayout() {
    super.setupLayout()
    navigationItem.title = "Tarefas"
    navigationItem.rightBarButtonItem = UIBarButtonItem(
      title: "Adicionar",
      style: .plain,
      target: .none,
      action: .none)
  }

  override func setupSubviews() {
    super.setupSubviews()
  }

  override func setupConstraints() {
    super.setupConstraints()
  }
}

extension TaskListViewController: ViewStates {
  func showTasks(_ tasks: TaskListViewModel.TaskSectionsViewModel) {
    tasksSectionsSubject.onNext([
      SectionModel(model: "Pendentes", items: tasks.pending),
      SectionModel(model: "Concluídos", items: tasks.finished)
    ])
  }
}

protocol TaskListNavigation {
  func openAddTaskModal()
}
