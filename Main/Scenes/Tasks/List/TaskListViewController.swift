//
//  TaskListViewController.swift
//  Main
//
//  Created by Daniel de Souza Ribas on 11/11/22.
//

import UIKit
import RxCocoa
import RxDataSources
import RxSwift

class TaskListViewController: UISceneViewController<TaskListView> {
  typealias DataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, String>>
  // MARK: - Properties
  private let navigation: TaskListNavigation
  let sampleData = [
    "Tarefa 1",
    "Tarefa 2",
    "Tarefa 3",
  ]

  lazy var items: Observable<[SectionModel<String, String>]> = {
    Observable.just([
      SectionModel(model: "Pendentes", items: sampleData),
      SectionModel(model: "Concluidos", items: sampleData)
    ])
  }()
  // MARK: - Initializers
  init(navigation: TaskListNavigation) {
    self.navigation = navigation
    super.init(nibName: nil,bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    let dataSource = DataSource(
      configureCell: { (_, table, _, data) in
        let cell = table.dequeueReusableCell(withIdentifier: TaskCell.reuseIdentifier) as! TaskCell
        cell.configure(priority: .high, title: data)
        return cell
      },
      titleForHeaderInSection: { dataSource, sectionIndex in
        return dataSource[sectionIndex].model
      }
    )

    items
      .bind(to: contentView.tableView.rx
        .items(dataSource: dataSource)
      )
      .disposed(by: bag)

    navigationItem.rightBarButtonItem?.rx.tap
      .debug()
      .bind { self.navigation.openAddTaskModal() }
      .disposed(by: bag)
  }

  // MARK: - Methods
  override func setupLayout() {
    super.setupLayout()
    navigationItem.title = "Tarefas"
    navigationItem.rightBarButtonItem = UIBarButtonItem(
      title: "Adicionar",
      style: .plain,
      target: .none,
      action: .none)
  }

  override func setupSubviews() {
    super.setupSubviews()
  }

  override func setupConstraints() {
    super.setupConstraints()
  }
}

protocol TaskListNavigation {
  func openAddTaskModal()
}
