//
//  FakeTaskService.swift
//  Main
//
//  Created by Daniel de Souza Ribas on 01/12/22.
//

import Foundation
import RxSwift

class FakeTaskService: TaskService {
  func addTask(_ task: Task) -> Completable {
    tasks.append(task)
    return Completable.empty()
  }

  func removeTask(withId id: UUID) -> Completable {
    tasks.removeAll { $0.id == id }
    return Completable.empty()
  }

  func updateTask(with task: Task) -> Completable {
    return removeTask(withId: task.id)
      .andThen(addTask(task))
  }

  func getTask(withId id: UUID) -> Single<Task> {
    let task = tasks.first { $0.id == id }
    guard let task = task else {
      return Single.error(ApplicationErrors.notFound)
    }
    return Single.just(task)
  }

  func getTaskList() -> Single<[Task]> {
    Single.just(tasks)
  }

  func finishTask(withId id: UUID) -> Completable {
    getTask(withId: id)
      .flatMapCompletable { [unowned self] task in
        let finishedTask = Task(
          id: task.id,
          title: task.title,
          description: task.description,
          priority: task.priority,
          status: .finished)
        return updateTask(with: finishedTask)
    }
  }
}

private var tasks: [Task] = [
  .init(id: UUID(), title: "Tarefa 1", description: "Descrição da Tarefa 1", priority: .low, status: .pending),
  .init(id: UUID(), title: "Tarefa 2", description: "Descrição da Tarefa 2", priority: .medium, status: .finished),
  .init(id: UUID(), title: "Tarefa 3", description: "Descrição da Tarefa 3", priority: .high, status: .pending),
  .init(id: UUID(), title: "Tarefa 4", description: "Descrição da Tarefa 4", priority: .medium, status: .pending),
  .init(id: UUID(), title: "Tarefa 5", description: "Descrição da Tarefa 5", priority: .low, status: .finished),
  .init(id: UUID(), title: "Tarefa 6", description: "Descrição da Tarefa 6", priority: .high, status: .pending),
  .init(id: UUID(), title: "Tarefa 7", description: "Descrição da Tarefa 7", priority: .high, status: .finished)
]
