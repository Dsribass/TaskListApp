//
//  SceneViewController.swift
//  Main
//
//  Created by Daniel de Souza Ribas on 11/11/22.
//

import UIKit
import RxSwift

class UISceneViewController<View: UIView>: UIViewController, ViewCode {
  var contentView: View { view as! View }
  let bag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }

  override func loadView() {
    self.view = View()
  }

  func setupLayout() {}

  func setupSubviews() {}

  func setupConstraints() {}
}
