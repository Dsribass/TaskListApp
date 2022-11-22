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

  enum Status {
    case pending, finished
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

  func configure(title: String, priority: Priority, status: Status) {
    self.title.attributedText = status == .finished
    ? textWithStrikethrough(title: title)
    : NSMutableAttributedString(string: title)
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
        return CGAffineTransform(rotationAngle: .pi / 2)
      case .medium:
        return CGAffineTransform(rotationAngle: .pi)
      case .high:
        return CGAffineTransform(rotationAngle: .pi * 1.5)
      }
    }()
  }

  private func textWithStrikethrough(title: String) -> NSMutableAttributedString  {
    let attributeString = NSMutableAttributedString(string: title)
    attributeString.addAttribute(
      NSAttributedString.Key.strikethroughStyle,
      value: 2,
      range: NSRange(location: 0, length: attributeString.length))
    return attributeString
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
