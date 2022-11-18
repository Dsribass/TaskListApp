//
//  AddTaskViewController.swift
//  Main
//
//  Created by Daniel de Souza Ribas on 17/11/22.
//

import UIKit

class AddTaskViewController: SceneViewController<AddTaskView> {
  override func viewDidLoad() {
    super.viewDidLoad()
    setupObservables()
  }

  override func setupLayout() {
    super.setupLayout()
    navigationItem.title = "Nova Tarefa"
  }

  func setupObservables() {
    contentView.submitButton.rx.tap
      .bind { [unowned self] _ in
        contentView.textField.resignFirstResponder()
      }
      .disposed(by: bag)
  }
}
