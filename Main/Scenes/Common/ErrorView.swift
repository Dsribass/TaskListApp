//
//  ErrorView.swift
//  Main
//
//  Created by Daniel de Souza Ribas on 27/06/22.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class ErrorView: UIViewCode {
  let bag = DisposeBag()

  var contentView: UIView = {
    let view = UIView()
    view.backgroundColor = .systemBackground
    return view
  }()

  var message: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    label.font = UIFont.preferredFont(forTextStyle: .title3)
    label.textColor = .black
    label.lineBreakMode = NSLineBreakMode.byWordWrapping
    label.numberOfLines = 0
    label.sizeToFit()

    return label
  }()

  var button: UIButton = UIButton(configuration: .filled())

  private let onTryAgainSubject = PublishSubject<Void>()
  var onTryAgain: Observable<Void> { onTryAgainSubject }

  func configure(message: String, buttonLabel: String) {
    self.message.text = message
    self.button.setTitle(buttonLabel, for: .normal)

    self.button.rx.tap
      .asObservable()
      .do(onNext: { [unowned self] _ in self.removeFromSuperview() })
      .bind(to: onTryAgainSubject)
      .disposed(by: bag)
  }

  override func setupLayout() {
    super.setupLayout()
    backgroundColor = .systemBackground
  }

  override func setupSubviews() {
    super.setupSubviews()
    addSubview(contentView)
    contentView.addSubview(message)
    contentView.addSubview(button)
  }

  override func setupConstraints() {
    super.setupConstraints()

    contentView.snp.makeConstraints { make in
      make.centerY.equalTo(self)
      make.leading.equalTo(self).inset(8)
      make.trailing.equalTo(self).inset(8)
    }

    message.snp.makeConstraints { make in
      make.top.equalTo(contentView)
      make.leading.equalTo(contentView)
      make.trailing.equalTo(contentView)
    }
    
    button.snp.makeConstraints { make in
      make.top.equalTo(message.snp.bottom).offset(32)
      make.bottom.equalTo(contentView)
      make.leading.equalTo(contentView)
      make.trailing.equalTo(contentView)
      make.height.equalTo(40)
    }
  }
}
