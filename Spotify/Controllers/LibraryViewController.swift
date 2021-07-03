//
//  LibraryViewController.swift
//  Spotify
//
//  Created by Ilya Buldin on 10.05.2021.
//

import UIKit

class LibraryViewController: UIViewController {
    
    // MARK: - Properties
    var gradient : CAGradientLayer?
    
    let gradientView : UIView = {
        let view = UIView()
        return view
    }()

    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Library"
        setupGradient(gradient: &gradient, gradientView: gradientView)
    }
    
    
    // MARK: - Methods

    
    // MARK: - Layout
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradient?.frame = CGRect(
            x: 0.0,
            y: 0.0,
            width: getNavBarHeightAndWidth().width,
            height: getNavBarHeightAndWidth().height
        )
    }
}
