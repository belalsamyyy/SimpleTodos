//
//  BaseViewController.swift
//  SimpleTodo
//
//  Created by Belal Samy on 10/26/24.
//

import UIKit

class BaseViewController: UIViewController {

    //MARK: - Properties
     
    // nav bar title
    var navBarTitle: String? {
        didSet {
            self.title = navBarTitle
        }
    }
    
    // bav bar button
    var navButtonTitle: String? {
        didSet {
            setupNavButton()
        }
    }
    
    var navButtonAction: (() -> Void)?
    
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
     
    private func setupNavButton() {
        if let buttonTitle = navButtonTitle {
            let button = UIBarButtonItem(title: buttonTitle, style: .plain, target: self, action: #selector(navButtonTapped))
            navigationItem.rightBarButtonItem = button
        }
    }
     
    @objc private func navButtonTapped() {
        navButtonAction?()
    }
}

