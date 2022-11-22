//
//  UITextViewContainer.swift
//  Main
//
//  Created by Daniel de Souza Ribas on 22/11/22.
//

import UIKit
import SnapKit

class UITextViewContainer: UIViewCode {
  let labelForTextView: UILabel = {
    let lb = UILabel()
    lb.font = UIFont.boldSystemFont(ofSize: 14)
    return lb
  }()

  let textView: UITextView = {
    let tv = UITextView()
    tv.font = UIFont.preferredFont(forTextStyle: .body)
    tv.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
    tv.layer.borderWidth = 1.0
    tv.layer.cornerRadius = 8
    return tv
  }()

  init(label: String) {
    super.init(frame: .zero)
    labelForTextView.text = label
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func setupLayout() {
    super.setupLayout()
  }

  override func setupSubviews() {
    super.setupSubviews()
    addSubview(labelForTextView)
    addSubview(textView)
  }

  override func setupConstraints() {
    super.setupConstraints()
    labelForTextView.snp.makeConstraints { make in
      make.top.equalTo(self)
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
    }

    textView.snp.makeConstraints { make in
      make.height.equalTo(96)
      make.top.equalTo(labelForTextView.snp.bottom).offset(4)
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
      make.bottom.equalTo(self)
    }
  }
}
