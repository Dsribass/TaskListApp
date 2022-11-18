//
//  AddTaskView.swift
//  Main
//
//  Created by Daniel de Souza Ribas on 17/11/22.
//

import UIKit

class AddTaskView: UIViewCode {

  private let container = UIView()

  let textField: UITextField = {
    let tf = UITextField()
    tf.placeholder = "Digite o nome da tarefa"
    tf.borderStyle = .roundedRect
    tf.clearButtonMode = .whileEditing
    tf.keyboardType = .alphabet
    tf.returnKeyType = .done
    return tf
  }()

  let submitButton: UIButton = {
    let button = UIButton(configuration: .filled())
    button.setTitle("Criar Tarefa", for: .normal)
    button.setImage(UIImage(systemName: "plus.app"), for: .normal)
    return button
  }()


  override func setupLayout() {
    super.setupLayout()
    textField.delegate = self

    backgroundColor = .systemBackground
  }

  override func setupSubviews() {
    super.setupSubviews()
    addSubview(container)
    container.addSubview(textField)
    container.addSubview(submitButton)
  }

  override func setupConstraints() {
    super.setupConstraints()

    container.snp.makeConstraints { make in
      make.edges.equalTo(self).inset(UIEdgeInsets(top: 48, left: 24, bottom: 24, right: 24))
    }

    textField.snp.makeConstraints { make in
      make.height.equalTo(48)
      make.top.equalTo(container)
      make.leading.equalTo(container)
      make.trailing.equalTo(container)
    }

    submitButton.snp.makeConstraints { make in
      make.height.equalTo(48)
      make.top.equalTo(textField.snp.bottom).offset(12)
      make.leading.equalTo(container)
      make.trailing.equalTo(container)
    }
  }
}

extension AddTaskView: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      textField.endEditing(true)
      return false
  }
}
