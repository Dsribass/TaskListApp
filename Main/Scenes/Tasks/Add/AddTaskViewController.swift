//
//  AddTaskViewController.swift
//  Main
//
//  Created by Daniel de Souza Ribas on 17/11/22.
//

import UIKit
import RxSwift

class AddTaskViewController: SceneViewController<AddTaskView> {
  private let addTaskViewModel: AddTaskViewModel

  let onAddNewTaskSubject = PublishSubject<Task>()
  var onAddNewTask: Observable<Task> { onAddNewTaskSubject }

  init(addTaskViewModel: AddTaskViewModel) {
    self.addTaskViewModel = addTaskViewModel
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setupObservables()
  }

  override func setupLayout() {
    super.setupLayout()
  }

  func setupObservables() {
    contentView.titleTextField.rx.text
      .bind(to: addTaskViewModel.onTitleTextFieldSubject)
      .disposed(by: bag)

    contentView.descriptionTextField.rx.text
      .bind(to: addTaskViewModel.onDescriptionTextFieldSubject)
      .disposed(by: bag)

    contentView.priority.rx.selectedSegmentIndex
      .bind(to: addTaskViewModel.onPriorityOptionSubject)
      .disposed(by: bag)

    addTaskViewModel.onEnabledSubmitButton
      .bind { [unowned self] isEnabled in
        contentView.submitButton.isEnabled = isEnabled
      }
      .disposed(by: bag)

    contentView.submitButton.rx.tap
      .bind { [unowned self] _ in
        contentView.titleTextField.resignFirstResponder()
      }
      .disposed(by: bag)
  }
}
