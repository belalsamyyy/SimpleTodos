//
//  HomeVC.swift
//  SimpleTodo
//
//  Created by Belal Samy on 10/26/24.
//

import UIKit

class HomeVC: UIViewController {
    
    //MARK: - Properties
     
    private var coordinator: HomeCoordinator
     
    lazy var viewModel: HomeViewModelType = {
        return HomeViewModel(coordinator: coordinator)
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
    }
}
