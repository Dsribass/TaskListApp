//
//  LocalDataSource.swift
//  Main
//
//  Created by Daniel de Souza Ribas on 01/12/22.
//

import Foundation
import CoreData
import RxSwift

class LocalDataSource {
  private let context: NSManagedObjectContext

  init(context: NSManagedObjectContext) {
    self.context = context
  }

  func addTask(_ task: Task) -> Completable {
    let taskEntity = TaskEntity(context: context)
    taskEntity.withTask(task)
    context.insert(taskEntity)
    return saveContext()
  }

  func removeTask(withId id: UUID) -> Completable {
    getTask(withId: id).flatMapCompletable { [unowned self] task in
      context.delete(task)
      return saveContext()
    }
  }

  func updateTask(with task: Task) -> Completable {
    let taskEntity = TaskEntity(context: context)
    taskEntity.withTask(task)
    return saveContext()
  }

  func getTask(withId id: UUID) -> Single<TaskEntity> {
    let request = TaskEntity.fetchRequest()
    request.predicate = NSPredicate(format: "%K == %@", "id", id as CVarArg)
    return fetchOneResult(request: request)
  }

  func getTaskList() -> Single<[TaskEntity]> {
    fetch(request: TaskEntity.fetchRequest())
  }

  func finishTask(withId id: UUID) -> Completable {
    getTask(withId: id).flatMapCompletable { [unowned self] task in
      task.status = Int64(Task.Status.finished.index!)
      return saveContext()
    }
  }
}

extension LocalDataSource {
  private func fetch<Result>(request: NSFetchRequest<Result>) -> Single<[Result]> {
    do {
      let result = try context.fetch(request)
      return Single.just(result)
    } catch {
      return Single.error(ApplicationErrors.unexpected)
    }
  }

  private func fetchOneResult<Result>(request: NSFetchRequest<Result>) -> Single<Result> {
    do {
      let result = try context.fetch(request)

      guard let firstResult = result.first else {
        return Single.error(ApplicationErrors.notFound)
      }

      return Single.just(firstResult)
    } catch {
      return Single.error(ApplicationErrors.unexpected)
    }
  }

  private func saveContext() -> Completable {
    do {
      try context.save()
      return Completable.empty()
    } catch {
      return Completable.error(ApplicationErrors.unexpected)
    }
  }
}

