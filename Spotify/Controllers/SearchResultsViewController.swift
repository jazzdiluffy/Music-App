//
//  SearchResultsViewController.swift
//  Spotify
//
//  Created by Ilya Buldin on 10.05.2021.
//

import UIKit

struct SearchSection {
    let title: String
    let results: [SearchResult]
}

protocol SearchResultsViewControllerDelegate: AnyObject {
    func didTapResult(_ result: SearchResult)
}

class SearchResultsViewController: UIViewController {
    
    // MARK: - Properties
    private var sections: [SearchSection] = []
    
    weak var delegate: SearchResultsViewControllerDelegate?
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(SearchResultDefaultTableViewCell.self, forCellReuseIdentifier: SearchResultDefaultTableViewCell.identifier)
        tableView.register(SearchResultSubtitleTableViewCell.self, forCellReuseIdentifier: SearchResultSubtitleTableViewCell.identifier)
        tableView.isHidden = true
        tableView.showsVerticalScrollIndicator = false
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
    }
    
    
    // MARK: - Layout
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    
    // MARK: - Methods
    func update(with results: [SearchResult]) {
        let artists = results.filter({
            switch $0 {
            case .artist:
                return true
            default:
                return false
            }
        })
        let tracks = results.filter({
            switch $0 {
            case .track:
                return true
            default:
                return false
            }
        })
        let playlists = results.filter({
            switch $0 {
            case .playlist:
                return true
            default:
                return false
            }
        })
        let albums = results.filter({
            switch $0 {
            case .album:
                return true
            default:
                return false
            }
        })
        self.sections = [
            SearchSection(title: "Tracks", results: tracks),
            SearchSection(title: "Artists", results: artists),
            SearchSection(title: "Albums", results: albums),
            SearchSection(title: "Playlists", results: playlists)
        ]
        tableView.reloadData()
        tableView.isHidden = results.isEmpty
    }
}


// MARK: - Delegate and DataSource
extension SearchResultsViewController: UITableViewDelegate, UITableViewDataSource {
    // Data Source
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let result = sections[indexPath.section].results[indexPath.row]
        switch result {
        case .artist(let artist):
            guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: SearchResultDefaultTableViewCell.identifier,
                    for: indexPath) as? SearchResultDefaultTableViewCell else {
                return UITableViewCell()
            }
            let viewModel = SearchResultDefaultTableViewCellViewModel(
                title: artist.name,
                imageURL: URL(string: artist.images?.first?.url ?? "")
             )
            cell.configure(with: viewModel)
            return cell
        case .album(let album):
            guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: SearchResultSubtitleTableViewCell.identifier,
                    for: indexPath) as? SearchResultSubtitleTableViewCell else {
                return UITableViewCell()
            }
            let viewModel = SearchResultSubtitleTableViewCellViewModel(
                title: album.name,
                subtitle: album.artists.first?.name ?? "",
                imageURL: URL(string: album.images.first?.url ?? "")
            )
            cell.configure(with: viewModel)
            return cell
        case .playlist(let playlist):
            guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: SearchResultSubtitleTableViewCell.identifier,
                    for: indexPath) as? SearchResultSubtitleTableViewCell else {
                return UITableViewCell()
            }
            let viewModel = SearchResultSubtitleTableViewCellViewModel(
                title: playlist.name,
                subtitle: playlist.owner.display_name,
                imageURL: URL(string: playlist.images.first?.url ?? "")
            )
            cell.configure(with: viewModel)
            return cell
        case .track(let track):
            guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: SearchResultSubtitleTableViewCell.identifier,
                    for: indexPath) as? SearchResultSubtitleTableViewCell else {
                return UITableViewCell()
            }
            let viewModel = SearchResultSubtitleTableViewCellViewModel(
                title: track.name,
                subtitle: track.artists.first?.name ?? "",
                imageURL: URL(string: track.album?.images.first?.url ?? "")
            )
            cell.configure(with: viewModel)
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // "Artist" section
        if indexPath.section == 1 {
            return 90
        }
        return 60
    }
    
    // Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let result = sections[indexPath.section].results[indexPath.row]
        delegate?.didTapResult(result)
    }
}
