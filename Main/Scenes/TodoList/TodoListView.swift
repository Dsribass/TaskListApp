//
//  TodoListView.swift
//  Main
//
//  Created by Daniel de Souza Ribas on 11/11/22.
//

import UIKit
import SnapKit

class TodoListView: UIViewCode {
  var tableView: UITableView = {
    let table = UITableView(frame: .zero, style: .insetGrouped)
    table.register(TodoCell.self, forCellReuseIdentifier: "TodoCell")
    return table
  }()

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

