//
//  TaskListViewModel.swift
//  Main
//
//  Created by Daniel de Souza Ribas on 18/11/22.
//

import RxSwift

class TaskListViewModel {
  struct TaskSectionsViewModel {
    private let tasks: [Task]

    init(tasks: [Task]) {
      self.tasks = tasks
    }

    var pending: [Task] { tasks.filter {$0.status == .pending} }
    var finished: [Task] { tasks.filter {$0.status == .finished} }
  }

  enum State {
    case loading, error, success(TaskSectionsViewModel)
  }

  private let service: TaskService
  private let bag = DisposeBag()
  private let stateSubject = BehaviorSubject<State>(value: .loading)
  var statesObservable: Observable<State> { stateSubject.asObservable() }

  init(service: TaskService) {
    self.service = service
    getTasks()
  }

  func getTasks() {
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
