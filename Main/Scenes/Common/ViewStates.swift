//
//  ViewStates.swift
//  Main
//
//  Created by Daniel de Souza Ribas on 26/09/22.
//

import UIKit
import RxSwift

protocol ViewStates {
  func startLoading()
  func stopLoading()
  func showError()
}

private enum Tag {
  static let loadingView = 999
}

extension ViewStates where Self: ViewController {
  // MARK: - Loading State
  func startLoading() {
    let loadingView = UIView()
    loadingView.backgroundColor = .systemBackground
    loadingView.tag = Tag.loadingView
    loadingView.translatesAutoresizingMaskIntoConstraints = false

    let activityIndicator = UIActivityIndicatorView(style: .large)
    activityIndicator.color = .systemRed
    activityIndicator.translatesAutoresizingMaskIntoConstraints = false

    view.addSubview(loadingView)
    loadingView.addSubview(activityIndicator)
    view.bringSubviewToFront(loadingView)

    loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    loadingView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

    activityIndicator.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor).isActive = true
    activityIndicator.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor).isActive = true

    activityIndicator.startAnimating()
  }

  func stopLoading() {
    if let loadingView = view.viewWithTag(Tag.loadingView) {
      loadingView.removeFromSuperview()
    }
  }

  // MARK: - Error State
  func showError() {
    let errorView = ErrorView()
    errorView.configure(message: "Ocorreu um erro...", buttonLabel: "Tentar Novamente")
    errorView.translatesAutoresizingMaskIntoConstraints = false
    errorView.onTryAgain
      .bind(to: onTryAgainSubject)
      .disposed(by: bag)

    view.addSubview(errorView)

    errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    errorView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    errorView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
  }
}
