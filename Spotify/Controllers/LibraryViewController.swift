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
    
    private let playlistsVC = LibraryPlaylistsViewController()
    
    private let albumsVC = LibraryAlbumsViewController()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private let toggleView = LibraryToggleView()

    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Library"
        setupGradient(gradient: &gradient, gradientView: gradientView)
        view.addSubview(toggleView)
        toggleView.delegate = self
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: view.width * 2, height: scrollView.height)
        view.addSubview(scrollView)
        addChildren()
        updateBarButtons()
    }
    
    
    // MARK: - Methods
    private func addChildren() {
        addChild(playlistsVC)
        scrollView.addSubview(playlistsVC.view)
        playlistsVC.view.frame = CGRect(x: 0, y: 0, width: scrollView.width, height: scrollView.height)
        playlistsVC.didMove(toParent: self)
        
        addChild(albumsVC)
        scrollView.addSubview(albumsVC.view)
        albumsVC.view.frame = CGRect(x: view.width, y: 0, width: scrollView.width, height: scrollView.height)
        albumsVC.didMove(toParent: self)
    }

    private func updateBarButtons() {
        switch toggleView.state {
        case .playlist:
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        case .album:
            navigationItem.rightBarButtonItem = nil
        }
    }
    
    @objc private func didTapAdd() {
        playlistsVC.showCreatePlaylistAlert()
    }
    
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
    
    override func viewWillLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setConstraints()
    }
    
    private func setConstraints() {
        toggleView.translatesAutoresizingMaskIntoConstraints = false
        toggleView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        toggleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        toggleView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        toggleView.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 65).isActive = true
        scrollView.widthAnchor.constraint(equalToConstant: view.width).isActive = true
        scrollView.heightAnchor.constraint(equalToConstant: view.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom - 55).isActive = true
    }
}


// MARK: - Delegate
extension LibraryViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x >= (view.width - 100) {
            toggleView.update(for: .album)
            updateBarButtons()
        } else {
            toggleView.update(for: .playlist)
            updateBarButtons()
        }
    }
}

extension LibraryViewController: LibraryToggleViewDelegate {
    func libraryToggleViewDidTapPlaylists(_ toggleView: LibraryToggleView) {
        scrollView.setContentOffset(.zero, animated: true)
        updateBarButtons()
    }
    
    func libraryToggleViewDidTapAlbums(_ toggleView: LibraryToggleView) {
        scrollView.setContentOffset(CGPoint(x: view.width, y: 0), animated: true)
        updateBarButtons()
    }
}
