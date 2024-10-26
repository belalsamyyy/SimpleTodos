//
//  SplashVC.swift
//  SimpleTodo
//
//  Created by Belal Samy on 10/26/24.
//

import UIKit

class SplashVC: UIViewController {
    
    //MARK: - Properties
     
    private var coordinator: SplashCoordinator
     
    lazy var viewModel: SplashViewModelType = {
        return SplashViewModel(coordinator: coordinator)
    }()
    
    //MARK: - Init
    
    init(coordinator: SplashCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.setupFirstScreen()
    }
}
