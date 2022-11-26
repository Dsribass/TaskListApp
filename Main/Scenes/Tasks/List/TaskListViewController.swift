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

  typealias TaskSectionModel = SectionModel<String, TaskListViewModel.TaskViewModel>
  typealias DataSource = RxTableViewSectionedReloadDataSource<TaskSectionModel>

  // MARK: - Properties
  private let navigation: TaskListNavigation
  private let taskListViewModel: TaskListViewModel

  let dataSource: DataSource = {
    DataSource(
      configureCell: { (_, table, _, task) in
        let cell = table.dequeueReusableCell(withIdentifier: TaskCell.reuseIdentifier) as! TaskCell
        cell.configure(
          title: task.title,
          priority: {
            switch(task.priority) {
            case .high: return .high
            case .medium: return .medium
            case .low: return .low
            }
          }(),
          status: {
            switch(task.status) {
            case .finished: return .finished
            case .pending: return .pending
            }
          }())

        return cell
      },
      titleForHeaderInSection: { dataSource, sectionIndex in
        return dataSource[sectionIndex].model
      }
    )
  }()

  private let tasksSectionsSubject = BehaviorSubject<[TaskSectionModel]>(value: [])
  private var tasksSections: Observable<[TaskSectionModel]> { tasksSectionsSubject }

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

  override func viewWillAppear(_ animated: Bool) {
    onTryAgainSubject.onNext(())
  }

  // MARK: - Methods
  func setupObservables() {
    onTryAgainSubject
      .bind(to: taskListViewModel.onTryAgainSubject)
      .disposed(by: bag)

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

    contentView.tableView.rx
      .itemMoved
      .bind { [unowned self] itemMoved in
        let sourceIndex = itemMoved.sourceIndex
        let destinationIndex = itemMoved.destinationIndex
        let hasChangeSection = sourceIndex.section != destinationIndex.section
        let movedPendingToFinishedSection = sourceIndex.section == 0 && destinationIndex.section == 1
        let movedFinishedToPendingSection = sourceIndex.section == 1 && destinationIndex.section == 0

        var task = dataSource[destinationIndex]

        if hasChangeSection && movedFinishedToPendingSection {
          task.status = .pending
          taskListViewModel.onMoveTaskFromSectionSubject
            .onNext(task)
        }

        if hasChangeSection && movedPendingToFinishedSection {
          task.status = .finished
          taskListViewModel.onMoveTaskFromSectionSubject
            .onNext(task)
        }
      }
      .disposed(by: bag)

    contentView.tableView.rx
      .itemDeleted
      .bind { [unowned self] index in
        taskListViewModel.onDeleteTaskSubject.onNext(dataSource[index].id)
      }
      .disposed(by: bag)

    contentView.tableView.rx
      .itemSelected
      .bind { [unowned self] index in
        navigation.openDetail(dataSource[index].id)
      }
      .disposed(by: bag)

    navigationItem.rightBarButtonItem?.rx.tap
      .bind { [unowned self] _ in
        navigation.openAddTaskModal {
          onTryAgainSubject.onNext(())
        }
      }
      .disposed(by: bag)

    navigationItem.leftBarButtonItem?.rx.tap
      .bind { [unowned self] _ in
        contentView.toggleEditMode()
        navigationItem.leftBarButtonItem?.title = contentView.isEditing ? "Concluir" : "Editar"
      }
      .disposed(by: bag)
  }

  override func setupLayout() {
    super.setupLayout()
    navigationItem.title = "Tarefas"
    navigationItem.rightBarButtonItem = UIBarButtonItem(
      barButtonSystemItem: .add,
      target: .none,
      action: .none)
    navigationItem.leftBarButtonItem = UIBarButtonItem(
      title: "Editar",
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
  func openAddTaskModal(onDismiss: @escaping () -> Void)
  func openDetail(_ id: UUID)
}
