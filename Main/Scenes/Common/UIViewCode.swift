//
//  UIViewCode.swift
//  Main
//
//  Created by Daniel de Souza Ribas on 11/11/22.
//

import UIKit

class UIViewCode: UIView, ViewCode {
  convenience init() {
    self.init(frame: .zero)
    setupView()
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }

  required init?(coder: NSCoder) {
    super.init(coder:coder)
    setupView()
  }

  func setupLayout() {}

  func setupSubviews() {}

  func setupConstraints() {}
}
