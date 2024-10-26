//
//  HomeVC.swift
//  SimpleTodo
//
//  Created by Belal Samy on 10/26/24.
//

import UIKit
import Combine

class HomeVC: BaseViewController {
    
    //MARK: - Outlets
     
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var moreExamplesBtn: UIButton!
    
    private lazy var refreshControl : UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .black
        refreshControl.addTarget(self, action: #selector(refreshView(_:)), for: .valueChanged)
        return refreshControl
    }()
    
    //MARK: - Properties
     
    private var cancellables: Set<AnyCancellable> = []
    private var coordinator: HomeCoordinator
     
    lazy var viewModel: HomeViewModelType = {
        return HomeViewModel(delegate: self, coordinator: coordinator)
    }()
    
    // MARK: - Init
     
    init(coordinator: HomeCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
    //MARK: - LifeCycle
     
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavBar()
        setupTableView()
        bindVM()
    }
     
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.restartTodoList()
        self.viewModel.restartPlaceholders()
    }
    
    //MARK: - Methods
     
    private func setupUI() {
        searchBar.delegate = self
        moreExamplesBtn.setTitle("MORE EXAMPLES", for: .normal)
    }
     
    private func setupNavBar() {
        navBarTitle = "To-Do List"
        navButtonTitle = "+ New"
        navButtonAction = { [weak self] in
            guard let self else { return }
            self.handleAddBtnTapped()
        }
    }
     
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerNib(TodoCell.self)
        tableView.refreshControl = refreshControl
    }
     
    private func bindVM() {
        viewModel.search.sink { [weak self] searchText in
            guard let self = self else { return }
            self.viewModel.getPlaceholders(search: searchText)
            self.viewModel.getTodoList(search: searchText)
        }.store(in: &cancellables)
    }
     
    @objc private func refreshView(_ sender: Any) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.refreshControl.endRefreshing()
            self.viewModel.restartPlaceholders()
            self.viewModel.restartTodoList()
        }
    }
    
    //MARK: - Actions
     
    private func handleAddBtnTapped() {
        print("Add Btn tapped ...")
        self.presentAlertWithTextField(title: "Add New Todo", message: "Ex. Buy milk, Clean room, ....", actionTitle: "Add") { [weak self] textFieldText in
            guard let self else { return }
            guard !textFieldText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
            let newTodo = TodoListItemModel(title: textFieldText, completed: false)
            self.viewModel.addTodo(newTodo)
        }
    }
    
    @IBAction func moreExamplesBtnTapped(_ sender: Any) {
        print("more examples btn tapped ...")
        self.viewModel.moreExamplesButtonTapped()
    }
    
}

//MARK: - Extensions

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    // ====================================================================================== sections
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    
    // ====================================================================================== headers
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.headerTitle(section: section)
    }
     
    // ====================================================================================== rows
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells(section: section)
    }
     
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let cell = tableView.dequeue(TodoCell.self, for: indexPath)
        cell.selectionStyle = .none
         
        switch section {
        case 0:
            if let todo = viewModel.todo(section: section, index: indexPath.row) {
                cell.configure(data: todo, type: .addedToMyList)
            }
            
        case 1:
            if let todo = viewModel.todo(section: section, index: indexPath.row) {
                cell.configure(data: todo, type: .placeholder)
            }
            
        default:
            return UITableViewCell()
        }
         
        return cell
    }
     
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightForRow()
    }
     
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = indexPath.section
         
        switch section {
        case 0:
            if let todo = viewModel.todo(section: section, index: indexPath.row) {
                self.viewModel.toggleCompleted(todo, isCompleted: todo.completed)
            }
            
        case 1:
            print("do nothing, when tap on remote todos")
            
        default:
            print("selected section, not found !!")
        }
    }
     
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let section = indexPath.section
        
        switch section {
        case 0:
            return swipeToDelete(section: section, row: indexPath.row)
            
        case 1:
            return swipeToAddToLocal(section: section, row: indexPath.row)
            
        default:
            return nil
        }
    }
     
    //MARK: - Helpers
     
    private func swipeToDelete(section: Int, row: Int) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (_, _, completionHandler) in
            guard let self else { return }
            if let todo = viewModel.todo(section: section, index: row) {
                self.viewModel.deleteTodo(todo)
                completionHandler(true)
            }
        }
         
        deleteAction.backgroundColor = .red
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }
     
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

//MARK: - Search Bar Delegate

extension HomeVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Search text: \(searchText)")
        viewModel.search.send(searchText)
    }
     
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("search bar: did end editing ...")
    }
}

//MARK: - View Model Delegate
 
extension HomeVC: HomeViewModelDelegate {
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
     
    func didExitWithError(error: String) {
        print("something went wrong: \(error)")
    }
}
