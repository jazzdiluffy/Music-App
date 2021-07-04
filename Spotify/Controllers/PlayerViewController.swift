//
//  PlayerViewController.swift
//  Spotify
//
//  Created by Ilya Buldin on 10.05.2021.
//

import UIKit

class PlayerViewController: UIViewController {
    
    // MARK: - Properties
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.backgroundColor = .systemBlue
        return imageView
    }()
    
    private let controlsView = PlayerControlsView()
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(imageView)
        view.addSubview(controlsView)
        configureBarButtons()
    }
    
    
    // MARK: - Layout
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setConstrainsts()
    }
    
    private func setConstrainsts() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: view.width).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: view.width).isActive = true
        
        controlsView.translatesAutoresizingMaskIntoConstraints = false
        let controlsViewSize = view.height - view.width - view.safeAreaInsets.top - view.safeAreaInsets.bottom - 15
        controlsView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        controlsView.heightAnchor.constraint(equalToConstant: controlsViewSize).isActive = true
        controlsView.widthAnchor.constraint(equalToConstant: view.width - 20).isActive = true
        controlsView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10).isActive = true
    }
    
    
    // MARK: - Methods
    private func configureBarButtons() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapClose))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapAction))

    }
    
    @objc private func didTapClose() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapAction() {
        // Some action
    }
}
