//
//  LibraryToggleView.swift
//  Spotify
//
//  Created by Ilya Buldin on 08.07.2021.
//

import UIKit

protocol LibraryToggleViewDelegate: AnyObject {
    func libraryToggleViewDidTapPlaylists(_ toggleView: LibraryToggleView)
    func libraryToggleViewDidTapAlbums(_ toggleView: LibraryToggleView)
}

class LibraryToggleView: UIView {
    
    // MARK: - Properties
    weak var delegate: LibraryToggleViewDelegate?
    
    private let playlistButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("Playlists", for: .normal)
        return button
    }()
    
    private let albumsButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("Albums", for: .normal)
        return button
    }()
    
    private let indicatorView: UIView = {
        let indicator = UIView()
        indicator.backgroundColor = .systemGreen
        indicator.layer.masksToBounds = true
        indicator.layer.cornerRadius = 2
        return indicator
    }()
    
    enum State {
        case playlist
        case album
    }
    
    var state: State = .playlist
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(playlistButton)
        addSubview(albumsButton)
        addSubview(indicatorView)
        playlistButton.addTarget(self, action: #selector(didTapPlaylists), for: .touchUpInside)
        albumsButton.addTarget(self, action: #selector(didTapAlbums), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Methods
    @objc private func didTapPlaylists() {
        state = .playlist
        UIView.animate(withDuration: 0.2) {
            self.updateIndicatorPosition()
        }
        delegate?.libraryToggleViewDidTapPlaylists(self)
    }
    
    @objc private func didTapAlbums() {
        state = .album
        UIView.animate(withDuration: 0.2) {
            self.updateIndicatorPosition()
        }
        delegate?.libraryToggleViewDidTapAlbums(self)
    }
    
    func update(for state: State) {
        self.state = state
        UIView.animate(withDuration: 0.2) {
            self.updateIndicatorPosition()
        } 
    }
    
    
    // MARK: - Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        setConstraints()
    }
    
    private func setConstraints() {
        playlistButton.translatesAutoresizingMaskIntoConstraints = false
        playlistButton.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        playlistButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        playlistButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        playlistButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
            
        albumsButton.translatesAutoresizingMaskIntoConstraints = false
        albumsButton.leftAnchor.constraint(equalTo: playlistButton.rightAnchor).isActive = true
        albumsButton.centerYAnchor.constraint(equalTo: playlistButton.centerYAnchor).isActive = true
        albumsButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        albumsButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        indicatorView.heightAnchor.constraint(equalToConstant: 4).isActive = true
        indicatorView.topAnchor.constraint(equalTo: albumsButton.bottomAnchor).isActive = true
        updateIndicatorPosition()
    }
    
    private func updateIndicatorPosition() {
        switch state {
        case .playlist:
            indicatorView.frame = CGRect(x: 10, y: playlistButton.bottom, width: 80, height: 4)
        case .album:
            indicatorView.frame = CGRect(x: 110, y: playlistButton.bottom, width: 80, height: 4)
        }
    }
}
