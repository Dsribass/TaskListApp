//
//  UITextFieldContainer.swift
//  Main
//
//  Created by Daniel de Souza Ribas on 22/11/22.
//

import UIKit
import SnapKit

class UITextFieldContainer: UIViewCode {
  let labelForTextField: UILabel = {
    let lb = UILabel()
    lb.font = UIFont.boldSystemFont(ofSize: 14)
    return lb
  }()

  let textField: UITextField = {
    let tf = UITextField()
    tf.borderStyle = .roundedRect
    tf.clearButtonMode = .whileEditing
    return tf
  }()

  init(label: String) {
    super.init(frame: .zero)
    labelForTextField.text = label
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func setupLayout() {
    super.setupLayout()
  }

  override func setupSubviews() {
    super.setupSubviews()
    addSubview(labelForTextField)
    addSubview(textField)
  }

  override func setupConstraints() {
    super.setupConstraints()
    labelForTextField.snp.makeConstraints { make in
      make.top.equalTo(self)
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
    }

    textField.snp.makeConstraints { make in
      make.height.equalTo(48)
      make.top.equalTo(labelForTextField.snp.bottom).offset(4)
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
      make.bottom.equalTo(self)
    }
  }
}

