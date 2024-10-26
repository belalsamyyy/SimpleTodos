//
//  ExamplesVC.swift
//  SimpleTodo
//
//  Created by Belal Samy on 10/26/24.
//

import Foundation
import UIKit

class ExamplesVC: BaseViewController {
    
    //MARK: - Outlets
     
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Properties
     
    private var coordinator: ExamplesCoordinator
     
    lazy var viewModel: ExamplesViewModelType = {
        return ExamplesViewModel(delegate: self, coordinator: coordinator)
    }()
    
    // MARK: - Init
     
    init(coordinator: ExamplesCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycle
     
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.getPlaceholders(search: "")
    }
    
    //MARK: - Methods
    
    private func setupNavBar() {
        navBarTitle = "More Examples"
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerNib(TodoCell.self)
    }
}

//MARK: - Extensions

extension ExamplesVC: UITableViewDelegate, UITableViewDataSource {
    // ====================================================================================== sections
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
     
    // ====================================================================================== rows
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells(section: section)
    }
     
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let cell = tableView.dequeue(TodoCell.self, for: indexPath)
        cell.selectionStyle = .none
         
        if let todo = viewModel.todo(section: section, index: indexPath.row) {
            cell.configure(data: todo, type: .placeholder)
        }
         
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let section = indexPath.section
        return viewModel.heightForRow(section: section)
    }
     
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let section = indexPath.section
        return swipeToAddToLocal(section: section, row: indexPath.row)
    }
     
    //MARK: - Helpers
     
    private func swipeToAddToLocal(section: Int, row: Int) -> UISwipeActionsConfiguration? {
        let addToLocalAction = UIContextualAction(style: .destructive, title: "Add to Local") { [weak self] (_, _, completionHandler) in
            guard let self else { return }
            if let todo = viewModel.todo(section: section, index: row) {
                self.viewModel.addTodo(todo)
                completionHandler(true)
            }
        }
         
        addToLocalAction.backgroundColor = .orange
        let configuration = UISwipeActionsConfiguration(actions: [addToLocalAction])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }
}

//MARK: - View Model Delegate

extension ExamplesVC: ExamplesViewModelDelegate {
    func reloadData() {
        self.tableView.reloadData()
    }
    
    func didExitWithError(error: String) {
        print("something went wrong: \(error)")
    }
}


