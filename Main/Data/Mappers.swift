//
//  Mappers.swift
//  Main
//
//  Created by Daniel de Souza Ribas on 01/12/22.
//

import Foundation
import CoreData

extension TaskEntity {
  func toModel() throws -> Task {
    guard let id = id,
          let title = title,
          let information = information else {
      throw ApplicationErrors.missingValue
    }

    return Task(
      id: id,
      title: title,
      description: information,
      priority: Task.Priority.allCases[Int(priority)],
      status: Task.Status.allCases[Int(status)])
  }

  func withTask(_ task: Task) {
    id = task.id
    title = task.title
    information = task.description
    priority = Int64(task.priority.index!)
    status = Int64(task.status.index!)
  }
}
