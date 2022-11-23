//
//  TaskDetailView.swift
//  Main
//
//  Created by Daniel de Souza Ribas on 22/11/22.
//

import UIKit
import SnapKit

class TaskDetailView: UIViewCode {
  private let scrollView = UIScrollView()

  private let stackView: UIStackView = {
    let stack = UIStackView()
    stack.axis = .vertical
    stack.spacing = 12
    return stack
  }()

  let titleText: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 28)
    return label
  }()

  let descriptionText: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 16)
    label.numberOfLines = 0
    label.lineBreakMode = .byWordWrapping
    return label
  }()

  let priorityContainer: UIStackView = {
    let stack = UIStackView()
    stack.axis = .horizontal
    stack.alignment = .center
    stack.spacing = 8
    return stack
  }()

  let priority: UIView = {
    let view = UIView()
    view.layer.cornerRadius = 5
    return view
  }()

  let labelForPriority: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 16)
    return label
  }()

  func configure(
    title: String,
    description: String,
    priority: Task.Priority
  ) {
    self.titleText.text = title
    self.descriptionText.text = description
    self.priority.backgroundColor = {
      switch priority {
      case .high: return .systemRed
      case .medium: return .systemYellow
      case .low: return .systemGreen
      }
    }()
    self.labelForPriority.text = {
      switch priority {
      case .high: return "Alto"
      case .medium: return "Médio"
      case .low: return "Baixo"
      }
    }()
  }

  override func setupLayout() {
    super.setupLayout()
    backgroundColor = .systemBackground
  }

  override func setupSubviews() {
    super.setupSubviews()
    addSubview(scrollView)
    scrollView.addSubview(stackView)
    stackView.addArrangedSubview(titleText)
    stackView.addArrangedSubview(descriptionText)
    priorityContainer.addArrangedSubview(priority)
    priorityContainer.addArrangedSubview(labelForPriority)
    stackView.addArrangedSubview(priorityContainer)
  }

  override func setupConstraints() {
    super.setupConstraints()
    scrollView.snp.makeConstraints { make in
      make.top.equalTo(safeAreaLayoutGuide.snp.top)
      make.leading.equalTo(self).offset(24)
      make.trailing.equalTo(self).offset(-24)
      make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
    }

    stackView.snp.makeConstraints { make in
      make.width.equalTo(scrollView)
      make.top.equalTo(scrollView)
      make.leading.equalTo(scrollView)
      make.trailing.equalTo(scrollView)
    }

    priority.snp.makeConstraints { make in
      make.width.equalTo(30)
      make.height.equalTo(10)
    }
  }
}
