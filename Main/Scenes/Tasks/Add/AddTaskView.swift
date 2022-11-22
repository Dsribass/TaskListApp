//
//  AddTaskView.swift
//  Main
//
//  Created by Daniel de Souza Ribas on 17/11/22.
//

import UIKit

class AddTaskView: UIViewCode {
  private var initialTag = 0

  let container = UIView()

  let pageTitle: UILabel = {
    let lb = UILabel()
    lb.text = "Nova Tarefa"
    lb.font = UIFont.boldSystemFont(ofSize: 24)

    return lb
  }()

  let form: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.spacing = 12

    return stackView
  }()

  let titleTextFieldContainer: UITextFieldContainer = {
    let tf = UITextFieldContainer(label: "Titulo")
    tf.textField.keyboardType = .alphabet
    tf.textField.returnKeyType = .next
    tf.textField.tag = 1
    return tf
  }()

  let descriptionTextFieldContainer: UITextViewContainer = {
    let tv = UITextViewContainer(label: "Descrição")
    tv.textView.keyboardType = .default
    tv.textView.returnKeyType = .done
    tv.textView.tag = 2
    return tv
  }()

  let priorityContainer: UISegmentedControlContainer = {
    let sgControl = UISegmentedControlContainer(
      label: "Prioridade",
      items: ["Baixo", "Médio", "Alto"])
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
    titleTextFieldContainer.textField.delegate = self
    descriptionTextFieldContainer.textView.delegate = self

    backgroundColor = .systemBackground
  }

  override func setupSubviews() {
    super.setupSubviews()
    addSubview(container)
    container.addSubview(pageTitle)
    container.addSubview(form)
    form.addArrangedSubview(titleTextFieldContainer)
    form.addArrangedSubview(descriptionTextFieldContainer)
    form.addArrangedSubview(priorityContainer)
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

    form.snp.makeConstraints { make in
      make.top.equalTo(pageTitle.snp.bottom).offset(32)
      make.leading.equalTo(container)
      make.trailing.equalTo(container)
    }

    submitButton.snp.makeConstraints { make in
      make.height.equalTo(48)
      make.top.equalTo(form.snp.bottom).offset(24)
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
