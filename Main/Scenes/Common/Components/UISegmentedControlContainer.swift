//
//  UISegmentedControlContainer.swift
//  Main
//
//  Created by Daniel de Souza Ribas on 22/11/22.
//

import UIKit
import SnapKit

class UISegmentedControlContainer: UIViewCode {
  let labelForSegmentedControl: UILabel = {
    let lb = UILabel()
    lb.font = UIFont.boldSystemFont(ofSize: 14)
    return lb
  }()

  let segmentedControl: UISegmentedControl = {
    let sgControl = UISegmentedControl()
    sgControl.selectedSegmentTintColor = .tintColor
    return sgControl
  }()

  init(label: String, items: [String]) {
    super.init(frame: .zero)
    labelForSegmentedControl.text = label
    items.forEach { title in
      segmentedControl.insertSegment(withTitle: title, at: 0, animated: false)
    }
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func setupLayout() {
    super.setupLayout()
  }

  override func setupSubviews() {
    super.setupSubviews()
    addSubview(labelForSegmentedControl)
    addSubview(segmentedControl)
  }

  override func setupConstraints() {
    super.setupConstraints()
    labelForSegmentedControl.snp.makeConstraints { make in
      make.top.equalTo(self)
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
    }

    segmentedControl.snp.makeConstraints { make in
      make.top.equalTo(labelForSegmentedControl.snp.bottom).offset(4)
      make.leading.equalTo(self)
      make.trailing.equalTo(self)
      make.bottom.equalTo(self)
    }
  }
}
