//
//  Factory.swift
//  Main
//
//  Created by Daniel de Souza Ribas on 01/12/22.
//

import Foundation
import UIKit
import CoreData

enum Factory {
  static func getCoreDataContext() -> NSManagedObjectContext {
    return (UIApplication.shared.delegate as! AppDelegate)
      .persistentContainer
      .viewContext
  }

  static func makeLocalDataSource() -> LocalDataSource {
    LocalDataSource(context: getCoreDataContext())
  }

  static func makeTaskService() -> TaskService {
    TaskServiceImpl(localDataSource: makeLocalDataSource())
  }

  static func makeTaskListViewModel() -> TaskListViewModel {
    TaskListViewModel(service: makeTaskService())
  }

  static func makeTaskDetailViewModel(_ id: UUID) -> TaskDetailViewModel {
    TaskDetailViewModel(id: id, service: makeTaskService())
  }

  static func makeAddTaskViewModel() -> AddTaskViewModel {
    AddTaskViewModel(service: makeTaskService())
  }
}
