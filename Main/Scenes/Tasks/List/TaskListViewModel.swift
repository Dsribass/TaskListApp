//
//  TaskListViewModel.swift
//  Main
//
//  Created by Daniel de Souza Ribas on 18/11/22.
//

import RxSwift
import Foundation

class TaskListViewModel {
  struct TaskViewModel {
    var id: UUID
    var title: String
    var description: String
    var priority: Task.Priority
    var status: Task.Status
  }

  struct TaskSectionsViewModel {
    fileprivate let tasks: [Task]

    init(tasks: [Task]) {
      self.tasks = tasks
    }

    var pending: [TaskViewModel] {
      tasks
        .filter {$0.status == .pending}
        .map { task in
          TaskViewModel(
            id: task.id,
            title: task.title,
            description: task.description,
            priority: task.priority,
            status: task.status)
        }
    }
    var finished: [TaskViewModel] {
      tasks
        .filter {$0.status == .finished}
        .map { task in
          TaskViewModel(
            id: task.id,
            title: task.title,
            description: task.description,
            priority: task.priority,
            status: task.status)
        }}
  }

  enum State {
    case loading, error, success(TaskSectionsViewModel)
  }

  private let service: TaskService
  private let bag = DisposeBag()

  private let stateSubject = BehaviorSubject<State>(value: .loading)
  var statesObservable: Observable<State> { stateSubject.asObservable() }

  let onMoveTaskFromSectionSubject = PublishSubject<TaskViewModel>()
  var onMoveTaskFromSection: Observable<TaskViewModel> { onMoveTaskFromSectionSubject }

  let onDeleteTaskSubject = PublishSubject<UUID>()
  var onDeleteTask: Observable<UUID> { onDeleteTaskSubject }

  let onTryAgainSubject = PublishSubject<Void>()
  var onTryAgain: Observable<Void> { onTryAgainSubject }

  init(service: TaskService) {
    self.service = service
    Observable.merge(
      Observable.just(()),
      onTryAgain
    )
    .bind { [unowned self] _ in getTasks() }
    .disposed(by: bag)

    onMoveTaskFromSection
      .bind { [unowned self] task in updateTask(task) }
      .disposed(by: bag)

    onDeleteTask
      .bind { [unowned self] id in deleteTask(id) }
      .disposed(by: bag)
  }

  private func updateTask(_ task: TaskViewModel) {
    service
      .updateTask(
        with: Task(
          id: task.id,
          title: task.title,
          description: task.description,
          priority: task.priority,
          status: task.status
        ))
      .subscribe(onCompleted:  {
        self.onTryAgainSubject.onNext(())
      })
      .disposed(by: bag)
  }

  private func deleteTask(_ id: UUID) {
    service
      .removeTask(withId: id)
      .subscribe(onCompleted:  {
        self.onTryAgainSubject.onNext(())
      })
      .disposed(by: bag)
  }

  private func getTasks() {
    stateSubject.onNext(.loading)

    service.getTaskList()
      .subscribe { [unowned self] tasks in
        stateSubject.onNext(.success(
          TaskSectionsViewModel(tasks: tasks)
        ))
      } onFailure: { [unowned self] error in
        stateSubject.onNext(.error)
      }
      .disposed(by: bag)
  }
}
