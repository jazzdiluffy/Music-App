//
//  AlbumViewController.swift
//  Spotify
//
//  Created by Ilya Buldin on 24.05.2021.
//

import UIKit

class AlbumViewController: UIViewController {
    private let album: Album
    
    init(album: Album) {
        self.album = album
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = album.name
        view.backgroundColor = .systemGreen
    }


}
