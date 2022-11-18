//
//  Task.swift
//  Main
//
//  Created by Daniel de Souza Ribas on 18/11/22.
//

import Foundation

struct Task: Equatable {

  enum Priority {
    case high, medium, low
  }

  enum Status {
    case finished, pending
  }

  let id: UUID
  let title: String
  let description: String
  let priority: Priority
  let status: Status
}
