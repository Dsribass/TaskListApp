//
//  TaskServiceImpl.swift
//  Main
//
//  Created by Daniel de Souza Ribas on 01/12/22.
//

import Foundation
import CoreData
import RxSwift

class TaskServiceImpl: TaskService {
  private let localDataSource: LocalDataSource

  init(localDataSource: LocalDataSource) {
    self.localDataSource = localDataSource
  }

  func addTask(_ task: Task) -> Completable {
    localDataSource.addTask(task)
  }

  func removeTask(withId id: UUID) -> Completable {
    localDataSource.removeTask(withId: id)
  }

  func updateTask(with task: Task) -> Completable {
    localDataSource.updateTask(with: task)
  }

  func getTask(withId id: UUID) -> Single<Task> {
    localDataSource.getTask(withId: id).flatMap { task in
      do {
        return Single.just(try task.toModel())
      } catch(let error) {
        return Single.error(error)
      }
    }
  }

  func getTaskList() -> Single<[Task]> {
    localDataSource.getTaskList()
      .flatMap { taskEntityList in
        var taskList: [Task] = []
        for task in taskEntityList {
          do {
            taskList.append(try task.toModel())
          } catch(let error) {
            return Single.error(error)
          }
        }
        return Single.just(taskList)
      }
  }

  func finishTask(withId id: UUID) -> Completable {
    localDataSource.finishTask(withId: id)
  }
}
