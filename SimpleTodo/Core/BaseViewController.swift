//
//  BaseViewController.swift
//  SimpleTodo
//
//  Created by Belal Samy on 10/26/24.
//

import UIKit

class BaseViewController: UIViewController {

    //MARK: - Properties
     
    // nav bar
    var navBarTitle: String? {
        didSet {
            self.title = navBarTitle
        }
    }
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        setupNavigationBar()
    }

    //MARK: - Methods
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = navBarTitle
    }
}

