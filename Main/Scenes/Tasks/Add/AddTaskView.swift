//
//  AddTaskView.swift
//  Main
//
//  Created by Daniel de Souza Ribas on 17/11/22.
//

import UIKit

class AddTaskView: UIViewCode {
  private var initialTag = 0
  private let container = UIView()

  let pageTitle: UILabel = {
    let lb = UILabel()
    lb.text = "Nova Tarefa"
    lb.font = UIFont.boldSystemFont(ofSize: 24)

    return lb
  }()

  let labelForTitle: UILabel = {
    let lb = UILabel()
    lb.text = "Titulo"
    lb.font = UIFont.boldSystemFont(ofSize: 14)
    return lb
  }()

  let titleTextField: UITextField = {
    let tf = UITextField()
    tf.borderStyle = .roundedRect
    tf.clearButtonMode = .whileEditing
    tf.keyboardType = .alphabet
    tf.returnKeyType = .next
    tf.tag = 1
    return tf
  }()

  let labelForDescription: UILabel = {
    let lb = UILabel()
    lb.text = "Descrição"
    lb.font = UIFont.boldSystemFont(ofSize: 14)
    return lb
  }()

  let descriptionTextField: UITextView = {
    let tv = UITextView()
    tv.keyboardType = .default
    tv.font = UIFont.preferredFont(forTextStyle: .body)
    tv.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
    tv.layer.borderWidth = 1.0
    tv.layer.cornerRadius = 8
    tv.returnKeyType = .done
    tv.tag = 2
    return tv
  }()

  let labelForPriority: UILabel = {
    let lb = UILabel()
    lb.text = "Prioridade"
    lb.font = UIFont.boldSystemFont(ofSize: 14)
    return lb
  }()

  let priority: UISegmentedControl = {
    let sgControl = UISegmentedControl(items: ["Baixo", "Médio", "Alto"])
    sgControl.selectedSegmentTintColor = .tintColor
    return sgControl
  }()

  let submitButton: UIButton = {
    let button = UIButton(configuration: .filled())
    button.isEnabled = false
    button.setTitle("Criar Tarefa", for: .normal)
    button.setImage(UIImage(systemName: "plus.app"), for: .normal)
    return button
  }()


  override func setupLayout() {
    super.setupLayout()
    titleTextField.delegate = self
    descriptionTextField.delegate = self

    backgroundColor = .systemBackground
  }

  override func setupSubviews() {
    super.setupSubviews()
    addSubview(container)
    container.addSubview(pageTitle)

    container.addSubview(labelForTitle)
    container.addSubview(titleTextField)

    container.addSubview(labelForDescription)
    container.addSubview(descriptionTextField)

    container.addSubview(labelForPriority)
    container.addSubview(priority)

    container.addSubview(submitButton)
  }

  override func setupConstraints() {
    super.setupConstraints()

    container.snp.makeConstraints { make in
      make.edges.equalTo(self).inset(UIEdgeInsets(top: 48, left: 24, bottom: 24, right: 24))
    }

    pageTitle.snp.makeConstraints { make in
      make.top.equalTo(container)
      make.leading.equalTo(container)
      make.trailing.equalTo(container)
    }

    labelForTitle.snp.makeConstraints { make in
      make.top.equalTo(pageTitle.snp.bottom).offset(32)
      make.leading.equalTo(container)
      make.trailing.equalTo(container)
    }

    titleTextField.snp.makeConstraints { make in
      make.height.equalTo(48)
      make.top.equalTo(labelForTitle.snp.bottom).offset(4)
      make.leading.equalTo(container)
      make.trailing.equalTo(container)
    }

    labelForDescription.snp.makeConstraints { make in
      make.top.equalTo(titleTextField.snp.bottom).offset(12)
      make.leading.equalTo(container)
      make.trailing.equalTo(container)
    }

    descriptionTextField.snp.makeConstraints { make in
      make.height.equalTo(96)
      make.top.equalTo(labelForDescription.snp.bottom).offset(4)
      make.leading.equalTo(container)
      make.trailing.equalTo(container)
    }

    labelForPriority.snp.makeConstraints { make in
      make.top.equalTo(descriptionTextField.snp.bottom).offset(12)
      make.leading.equalTo(container)
      make.trailing.equalTo(container)
    }

    priority.snp.makeConstraints { make in
      make.top.equalTo(labelForPriority.snp.bottom).offset(4)
      make.leading.equalTo(container)
      make.trailing.equalTo(container)
    }

    submitButton.snp.makeConstraints { make in
      make.height.equalTo(48)
      make.top.equalTo(priority.snp.bottom).offset(24)
      make.leading.equalTo(container)
      make.trailing.equalTo(container)
    }
  }
}

extension AddTaskView: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextView {
           nextField.becomeFirstResponder()
        } else {
           textField.resignFirstResponder()
        }
        return false
     }
}

extension AddTaskView: UITextViewDelegate {
  func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
          if(text == "\n") {
              textView.resignFirstResponder()
              return false
          }
          return true
      }
}
