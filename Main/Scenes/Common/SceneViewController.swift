//
//  SceneViewController.swift
//  Main
//
//  Created by Daniel de Souza Ribas on 11/11/22.
//

import UIKit

class UISceneViewController<View: UIView>: UIViewController, ViewCode {
  var contentView: View { view as! View }

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setupView()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupView()
  }

  override func loadView() {
    self.view = View()
  }

  func setupLayout() {}

  func setupSubviews() {}

  func setupConstraints() {}
}
