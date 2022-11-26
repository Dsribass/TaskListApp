//
//  AddTaskViewModel.swift
//  Main
//
//  Created by Daniel de Souza Ribas on 21/11/22.
//

import RxSwift
import Foundation

class AddTaskViewModel {
  private let service: TaskService
  let bag = DisposeBag()

  private let isTextFieldsFilledSubject = BehaviorSubject<Bool>(value: false)
  private var isTextFieldsFilled: Observable<Bool> { isTextFieldsFilledSubject }

  private let isSegmentControlSelectSubject = BehaviorSubject<Bool>(value: false)
  private var isSegmentControlSelect: Observable<Bool> { isSegmentControlSelectSubject }

  let onEnabledSubmitButtonSubject = BehaviorSubject<Bool>(value: false)
  var onEnabledSubmitButton: Observable<Bool> { onEnabledSubmitButtonSubject }

  let onTitleTextFieldSubject = BehaviorSubject<String?>(value: nil)
  var onTitleTextField: Observable<String?> { onTitleTextFieldSubject }
  var titleValue: String? { try? onTitleTextFieldSubject.value() }

  let onDescriptionTextFieldSubject = BehaviorSubject<String?>(value: nil)
  var onDescriptionTextField: Observable<String?> { onDescriptionTextFieldSubject }
  var descriptionValue: String? { try? onDescriptionTextFieldSubject.value()}

  let onPriorityOptionSubject = BehaviorSubject<Int?>(value: nil)
  var onPriorityOption: Observable<Int?> { onPriorityOptionSubject }
  var priorityValue: Int? { try? onPriorityOptionSubject.value() }

  let onSubmitButtonSubject = PublishSubject<Void>()
  var onSubmitButton: Observable<Void> { onSubmitButtonSubject }

  let onCompleteSubmitSubject = PublishSubject<Void>()
  var onCompleteSubmit: Observable<Void> { onCompleteSubmitSubject }

  init(service: TaskService) {
    self.service = service

    Observable.combineLatest(
      onTitleTextField,
      onDescriptionTextField
    )
    .flatMap { [unowned self] title, description in
      let titleHasValue = textFieldHasValue(title)
      let descriptionHasValue = textFieldHasValue(description)
      return Observable.just(titleHasValue && descriptionHasValue)
    }
    .bind(to: isTextFieldsFilledSubject)
    .disposed(by: bag)

    onPriorityOption
      .flatMap { Observable.just($0 != nil && $0 != -1) }
      .bind(to: isSegmentControlSelectSubject)
      .disposed(by: bag)

    Observable.combineLatest(
      isTextFieldsFilled,
      isSegmentControlSelect
    ) { isTextFieldsFilled, isSegmentControlSelected in
      return isTextFieldsFilled && isSegmentControlSelected
    }
    .bind(to: onEnabledSubmitButtonSubject)
    .disposed(by: bag)

    onSubmitButton
      .bind { [unowned self] _ in addTask() }
      .disposed(by: bag)
  }

  private func addTask() {
    guard let title = titleValue,
          let description = descriptionValue,
          let priority = priorityValue else {
      return
    }

    let task = Task(
      id: UUID(),
      title: title,
      description: description,
      priority: .allCases[priority],
      status: .pending)

    service.addTask(task)
      .subscribe(onCompleted: { [unowned self] in
        onCompleteSubmitSubject.onNext(())
      })
      .disposed(by: bag)
  }

  private func textFieldHasValue(_  value: String?) -> Bool {
    guard let value = value else {
      return false
    }

    return !value.isEmpty
  }
}
