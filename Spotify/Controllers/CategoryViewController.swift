//
//  CategoryViewController.swift
//  Spotify
//
//  Created by Ilya Buldin on 02.07.2021.
//

import UIKit

class CategoryViewController: UIViewController {
    // MARK: -Properties
    
    let category: Category
    private var playlists = [Playlist]()
    
    // MARK: -Init
    
    init(category: Category) {
        self.category = category
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: -Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = category.name
        
        APICaller.shared.getCategoryPlaylists(category: category) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let playlists):
                    self?.playlists = playlists
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}
