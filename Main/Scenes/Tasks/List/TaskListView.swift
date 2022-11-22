//
//  TaskListView.swift
//  Main
//
//  Created by Daniel de Souza Ribas on 11/11/22.
//

import UIKit
import SnapKit

class TaskListView: UIViewCode {
  var isEditing = false

  var tableView: UITableView = {
    let table = UITableView(frame: .zero, style: .insetGrouped)
    table.register(TaskCell.self, forCellReuseIdentifier: TaskCell.reuseIdentifier)
    return table
  }()

  func toggleEditMode() {
    isEditing = !isEditing
    tableView.isEditing = isEditing
  }

  override func setupLayout() {
    super.setupLayout()
    backgroundColor = .systemBackground
  }

  override func setupSubviews() {
    super.setupSubviews()
    addSubview(tableView)
  }

  override func setupConstraints() {
    super.setupConstraints()

    tableView.snp.makeConstraints { [unowned self] make in
      make.edges.equalTo(self)
    }
  }
}

