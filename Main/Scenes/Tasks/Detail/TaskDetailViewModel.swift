//
//  TaskDetailViewModel.swift
//  Main
//
//  Created by Daniel de Souza Ribas on 23/11/22.
//

import RxSwift
import Foundation

class TaskDetailViewModel {
  enum State {
    case loading, error, success(Task), finished
  }

  private let service: TaskService
  private let id: UUID
  private let bag = DisposeBag()

  private let stateSubject = BehaviorSubject<State>(value: .loading)
  var statesObservable: Observable<State> { stateSubject.asObservable() }

  let onTryAgainSubject = PublishSubject<Void>()
  var onTryAgain: Observable<Void> { onTryAgainSubject }

  let onFinishTaskSubject = PublishSubject<Void>()
  var onFinishTask: Observable<Void> { onFinishTaskSubject }

  init(id: UUID, service: TaskService) {
    self.id = id
    self.service = service

    Observable.merge(
      Observable.just(()),
      onTryAgain
    )
    .bind { [unowned self] _ in getTaskDetail(id: id) }
    .disposed(by: bag)

    onFinishTaskSubject
      .bind { [unowned self] _ in finishTask() }
      .disposed(by: bag)
  }

  private func finishTask() {
    stateSubject.onNext(.loading)

    service.finishTask(withId: id)
      .subscribe(
        onCompleted: { [unowned self] in
          stateSubject.onNext(.finished)
        }, onError: { [unowned self] _ in
          stateSubject.onNext(.error)
        })
      .disposed(by: bag)
  }

  private func getTaskDetail(id: UUID) {
    stateSubject.onNext(.loading)

    service.getTask(withId: id)
      .subscribe { [unowned self] task in
        stateSubject.onNext(.success(task))
      } onFailure: { [unowned self] error in
        stateSubject.onNext(.error)
      }
      .disposed(by: bag)
  }
}
