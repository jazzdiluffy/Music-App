//
//  PlaylistViewController.swift
//  Spotify
//
//  Created by Ilya Buldin on 10.05.2021.
//

import UIKit

class PlaylistViewController: UIViewController {
    
    // MARK: - Properties
    private let playlist: Playlist
    
    public var isOwner = false
    
    private var viewModels = [RecommendedTracksCellViewModel]()
    
    private var tracks = [AudioTrack]()
    
    private let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: { _, _ in
            // Item
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0)
                )
            )
            item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            
            //  Group
            let group = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(80)
                ),
                subitem: item,
                count: 1
            )
            
            // Section
            let section = NSCollectionLayoutSection(group: group)
            section.boundarySupplementaryItems = [
                NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .fractionalWidth(1.2) 
                    ),
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top
                )
            ]
            section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0)
            return section
        })
    )
    
    
    // MARK: - Init
    init(playlist: Playlist) {
        self.playlist = playlist
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = playlist.name
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        collectionView.backgroundColor = .clear
        collectionView.register(
            RecommendedTrackCollectionViewCell.self,
            forCellWithReuseIdentifier: RecommendedTrackCollectionViewCell.identifier
        )
        collectionView.register(
            PlaylistHeaderCollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: PlaylistHeaderCollectionReusableView.identifier
        )
        collectionView.dataSource = self
        collectionView.delegate = self
        
        APICaller.shared.getPlaylistDetails(for: playlist) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    self?.tracks = model.tracks.items.compactMap( {$0.track} )
                    self?.viewModels = model.tracks.items.compactMap({
                        RecommendedTracksCellViewModel(
                            name: $0.track.name,
                            artistName: $0.track.artists.first?.name ?? "-",
                            artworkURL: URL(string: $0.track.album?.images.first?.url ?? "")
                        )
                    })
                    self?.collectionView.reloadData()
                    
                case .failure(let error):
                    print(error)
                    break
                }
            }
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .action,
            target: self,
            action: #selector(didTapShare)
        )
        if isOwner {
            let gesture = UILongPressGestureRecognizer(target: self, action: #selector(didLongPress(_:)))
            collectionView.addGestureRecognizer(gesture)
        }
    }
    
    
    // MARK: - Methods
    @objc private func didTapShare() {
        guard let url = URL(string: playlist.external_urls["spotify"] ?? "") else {
            return
        }
        let vc = UIActivityViewController(
            activityItems: [url],
            applicationActivities: []
        )
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true, completion: nil)
    }
    
    @objc private func didLongPress(_ gesture: UILongPressGestureRecognizer) {
        guard gesture.state == .began else {
            return
        }
        let touchPoint = gesture.location(in: collectionView)
        guard let indexPath = collectionView.indexPathForItem(at: touchPoint) else {
            return
        }
        let trackToDelete = tracks[indexPath.row]
        let actionSheet = UIAlertController(
            title: "Remove",
            message: "Would you like to remove this from playlist?",
            preferredStyle: .actionSheet
        )
        actionSheet.addAction(
            UIAlertAction(
                title: "Cancel",
                style: .cancel,
                handler: nil
            )
        )
        actionSheet.addAction(
            UIAlertAction(
                title: "Remove",
                style: .destructive,
                handler: { [weak self] _ in
                    guard let strongSelf = self else {
                        return
                    }
                    APICaller.shared.removeTrackFromPlaylist(
                        track: trackToDelete,
                        playlist: strongSelf.playlist
                    ) { success in
                        DispatchQueue.main.async {
                            if success {
                                strongSelf.tracks.remove(at: indexPath.row)
                                strongSelf.viewModels.remove(at: indexPath.row)
                                strongSelf.collectionView.reloadData()
                            } else {
                                print("Failed to remove")
                            }
                        }
                    }
                }
            )
        )
        present(actionSheet, animated: true, completion: nil)
    }
    
    
    // MARK: - Layout
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
}


// MARK: - Delegate and DataSource
extension PlaylistViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    // Data Source
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RecommendedTrackCollectionViewCell.identifier,
            for: indexPath
        ) as? RecommendedTrackCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: PlaylistHeaderCollectionReusableView.identifier,
                for: indexPath
        ) as? PlaylistHeaderCollectionReusableView, kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        let headerViewModel = PlaylistHeaderReusableViewViewModel(
            name: playlist.name,
            ownerName: playlist.owner.display_name,
            description: playlist.description,
            artworkURL: URL(string: playlist.images.first?.url ?? "")
        )
        header.configure(with: headerViewModel)
        header.delegate = self
        return header
    }

    // Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let index = indexPath.row
        let track = tracks[index]
        PlaybackPresenter.shared.startPlayback(from: self, track: track)
    }
}


extension PlaylistViewController: PlaylistHeaderCollectionReusableViewDelegate {
    func playlistHeaderCollectionReusableViewDidTapPlayAll(_ header: PlaylistHeaderCollectionReusableView) {
        // Start playing all songs in queue order
        PlaybackPresenter.shared.startPlayback(from: self, tracks: tracks)
    }
}
