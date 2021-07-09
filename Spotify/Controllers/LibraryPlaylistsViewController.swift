//
//  LibraryPlaylistsViewController.swift
//  Spotify
//
//  Created by Ilya Buldin on 08.07.2021.
//

import UIKit

class LibraryPlaylistsViewController: UIViewController {
    
    // MARK: - Properties
    var playlists = [Playlist]()
    
    private let noPlaylistsView = ActionLabelView()

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(
            SearchResultSubtitleTableViewCell.self,
            forCellReuseIdentifier: SearchResultSubtitleTableViewCell.identifier
        )
        tableView.isHidden = true
        tableView.separatorColor = .clear
        return tableView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        setUpNoPlaylistsView()
        fetchData()
    }
    
    
    // MARK: - Layout
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setConstraints()
        tableView.frame = view.bounds
    }
    
    private func setConstraints() {
        noPlaylistsView.translatesAutoresizingMaskIntoConstraints = false
        noPlaylistsView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        noPlaylistsView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        noPlaylistsView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        noPlaylistsView.heightAnchor.constraint(equalToConstant: 250).isActive = true
    }
    
    // MARK: - Methods
    private func updateUI() {
        if playlists.isEmpty {
            noPlaylistsView.isHidden = false
            tableView.isHidden = true
        } else {
            // Show table
            tableView.reloadData()
            print("IM HERE")
            tableView.isHidden = false
            noPlaylistsView.isHidden = true
        }
    }
    
    private func setUpNoPlaylistsView() {
        view.addSubview(noPlaylistsView)
        noPlaylistsView.delegate = self
        noPlaylistsView.configure(
            with: ActionLabelViewViewModel(
                text: "You don't have any playlists yet.",
                actionTitle: "Create!"
            )
        )
    }
    
    private func fetchData() {
        APICaller.shared.getCurrentUserPlaylists { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let playlists):
                    self?.playlists = playlists
                    self?.updateUI()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    public func showCreatePlaylistAlert() {
        let alert = UIAlertController(
            title: "New Playlists",
            message: "Enter playlist name",
            preferredStyle: .alert
        )
        alert.addTextField { textField in
            textField.placeholder = "Playlist..."
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Create", style: .default, handler: { _ in
            guard let field = alert.textFields?.first,
                  let text = field.text,
                  !text.trimmingCharacters(in: .whitespaces).isEmpty else {
                return
            }
            
            APICaller.shared.createPlaylist(with: text) { success in
                if success {
                    // Refresh list of playlists
                } else {
                    print("Failed to create a playlist")
                }
            }
            
        }))
        present(alert, animated: true, completion: nil)
    }
}


// MARK: - Delegate
extension LibraryPlaylistsViewController: ActionLabelViewDelegate {
    func actionLabelViewDidTapButton(_ actionView: ActionLabelView) {
        // Show creation ui
        showCreatePlaylistAlert()
    }
}

extension LibraryPlaylistsViewController: UITableViewDelegate {
    
}


// MARK: - Data Source
extension LibraryPlaylistsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(playlists.count)
        return playlists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: SearchResultSubtitleTableViewCell.identifier,
            for: indexPath
        ) as? SearchResultSubtitleTableViewCell else {
            return UITableViewCell()
        }
        let playlist = playlists[indexPath.row]
        cell.configure(
            with: SearchResultSubtitleTableViewCellViewModel(
                title: playlist.name,
                subtitle: playlist.owner.display_name,
                imageURL: URL(string: playlist.images.first?.url ?? "")
            )
        )
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
