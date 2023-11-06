//
//  HomeViewController.swift
//  The Movie
//
//  Created by tinit on 04/11/2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let globalLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupData()
    }
    
    func setupData() {
        welcomeLabel.text = "Welcome To The Movie App"
        globalLogo.image = UIImage(systemName: "global")
    }
    
    // Setup UI
    func setupUI() {
        view.addSubview(welcomeLabel)
        NSLayoutConstraint.activate([
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        setupNavBar()
    }
    
    func setupNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(logoutButtonTapped))
    }
    
    // Catch Action
    @objc
    func logoutButtonTapped() {
        let viewController = ViewController()
        DispatchQueue.main.async {
            self.navigationController?.setViewControllers([viewController], animated: true)
        }
    }
    
}
