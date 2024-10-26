//
//  ExamplesVC.swift
//  SimpleTodo
//
//  Created by Belal Samy on 10/26/24.
//

import Foundation
import UIKit

class ExamplesVC: BaseViewController {
    
    //MARK: - Properties
     
    private var coordinator: ExamplesCoordinator
     
    lazy var viewModel: ExamplesViewModelType = {
        return ExamplesViewModel(coordinator: coordinator)
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
    }
    
    //MARK: - Methods
    
    private func setupNavBar() {
        navBarTitle = "More Examples"
    }
}

