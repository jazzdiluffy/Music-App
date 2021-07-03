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
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.isHidden = true
        tableView.showsVerticalScrollIndicator = false
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
        print(result)
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        switch result {
        case .artist(let model):
            cell.textLabel?.text = model.name
        case .album(let model):
            cell.textLabel?.text = model.name
        case .playlist(let model):
            cell.textLabel?.text = model.name
        case .track(let model):
            cell.textLabel?.text = model.name
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }
    
    // Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let result = sections[indexPath.section].results[indexPath.row]
        delegate?.didTapResult(result)
    }
}
