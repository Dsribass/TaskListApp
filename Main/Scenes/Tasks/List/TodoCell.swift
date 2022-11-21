//
//  TodoCell.swift
//  Main
//
//  Created by Daniel de Souza Ribas on 11/11/22.
//

import UIKit
import SnapKit

class TaskCell: UITableViewCell, ViewCode {
  enum Priority {
    case low, medium, high
  }

  static let reuseIdentifier = String(describing: TaskCell.self)

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

  let priority: UIImageView = {
    let view = UIImageView()
    return view
  }()

  func configure(priority: Priority, title: String) {
    self.title.text = title
    self.priority.image = {
      switch priority {
      case .low:
        return UIImage(
          named: "priority.arrow"
        )?.withTintColor(.systemGreen)
      case .medium:
        return UIImage(
          named: "priority.line"
        )?.withTintColor(.systemYellow)
      case .high:
        return UIImage(
          named: "priority.arrow"
        )?.withTintColor(.systemRed)
      }
    }()
    self.priority.transform = {
      switch priority {
      case .low:
        return self.priority.transform.rotated(by: .pi / 2)
      case .medium:
        return self.priority.transform.rotated(by: .pi)
      case .high:
        return self.priority.transform.rotated(by: .pi * 1.5)
      }
    }()
  }

  func setupLayout() {}

  func setupSubviews() {
    addSubview(priority)
    addSubview(title)
  }

  func setupConstraints() {
    priority.snp.makeConstraints { [unowned self] make in
      make.width.height.equalTo(14)
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
