//
//  TaskDetailView.swift
//  Main
//
//  Created by Daniel de Souza Ribas on 22/11/22.
//

import UIKit
import SnapKit

class TaskDetailView: UIViewCode {
  let contentView = UIView()

  let title: UILabel = {
    let label = UILabel()
    label.text = "Hello World!"
    label.font = UIFont.boldSystemFont(ofSize: 28)
    return label
  }()

  override func setupLayout() {
    super.setupLayout()
    backgroundColor = .systemBackground
  }

  override func setupSubviews() {
    super.setupSubviews()
    addSubview(contentView)
    contentView.addSubview(title)
  }

  override func setupConstraints() {
    super.setupConstraints()
    contentView.snp.makeConstraints { make in
      make.top.equalTo(safeAreaLayoutGuide.snp.top)
      make.leading.equalTo(self).offset(24)
      make.trailing.equalTo(self).offset(-24)
      make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
    }

    title.snp.makeConstraints { make in
      make.leading.equalTo(contentView)
      make.trailing.equalTo(contentView)
      make.top.equalTo(contentView)
    }
  }
}

