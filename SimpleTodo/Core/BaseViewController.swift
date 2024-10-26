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
    
    // activity indicator
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        setupNavigationBar()
        setupActivityIndicator()
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
     
    private func setupActivityIndicator() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    //MARK: - Helpers
     
    func startLoading() {
        activityIndicator.startAnimating()
        activityIndicator.color = .black
        view.isUserInteractionEnabled = false
    }
     
    func stopLoading() {
        activityIndicator.stopAnimating()
        activityIndicator.color = .black
        view.isUserInteractionEnabled = true
    }
     
    
    //MARK: - Actions
    
    @objc private func navButtonTapped() {
        navButtonAction?()
    }
}

