//
//  ViewCode.swift
//  Main
//
//  Created by Daniel de Souza Ribas on 11/11/22.
//

import UIKit

protocol ViewCode {
  func setupView()
  func setupLayout()
  func setupSubviews()
  func setupConstraints()
}

extension ViewCode {
  func setupView()  {
    setupLayout()
    setupSubviews()
    setupConstraints()
  }
}
