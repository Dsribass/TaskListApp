//
//  TaskRepository.swift
//  Main
//
//  Created by Daniel de Souza Ribas on 18/11/22.
//

import Foundation
import RxSwift

protocol TaskService {
  func addTask(_ task: Task) -> Completable
  func removeTask(withId id: UUID) -> Completable
  func updateTask(with task: Task) -> Completable
  func getTask(withId id: UUID) -> Single<Task>
  func getTaskList() -> Single<[Task]>
  func finishTask(withId id: UUID) -> Completable
}
