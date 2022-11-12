//
//  TodoCell.swift
//  Main
//
//  Created by Daniel de Souza Ribas on 11/11/22.
//

import UIKit
import SnapKit

class TodoCell: UITableViewCell, ViewCode {
  enum Priority {
    case low, medium, high
  }

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupView()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  var title: UILabel = {
    let label = UILabel()
    label.font = UIFont.preferredFont(forTextStyle: .caption1)
    return label
  }()

  let priority = UIView()

  func configure(priority: Priority, title: String) {
    self.title.text = title
    self.priority.backgroundColor = {
      switch priority {
      case .low:
        return .green
      case .medium:
        return .yellow
      case .high:
        return .red
      }
    }()
  }

  func setupLayout() {
  }

  func setupSubviews() {
    addSubview(priority)
    addSubview(title)
  }

  func setupConstraints() {
    priority.snp.makeConstraints { [unowned self] make in
      make.width.height.equalTo(10)
      make.centerY.equalTo(self)
      make.leading.equalTo(self).offset(24)
    }

    title.snp.makeConstraints { [unowned self] make in
      make.centerY.equalTo(self)
      make.leading.equalTo(priority.snp.trailing).offset(8)
      make.trailing.equalTo(self).offset(24)
    }
  }
}
