//
//  AddTaskViewController.swift
//  Main
//
//  Created by Daniel de Souza Ribas on 17/11/22.
//

import UIKit
import RxSwift

class AddTaskViewController: SceneViewController<AddTaskView> {
  let onAddNewTaskSubject = PublishSubject<Task>()
  var onAddNewTask: Observable<Task> { onAddNewTaskSubject }

  override func viewDidLoad() {
    super.viewDidLoad()
    setupObservables()
  }

  override func setupLayout() {
    super.setupLayout()
  }

  func setupObservables() {
    contentView.submitButton.rx.tap
      .bind { [unowned self] _ in
        contentView.titleTextField.resignFirstResponder()
      }
      .disposed(by: bag)
  }
}
