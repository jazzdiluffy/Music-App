//
//  FeaturedPlaylistCollectionViewCell.swift
//  Spotify
//
//  Created by Ilya Buldin on 19.05.2021.
//

import UIKit

class FeaturedPlaylistCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let identifier = "FeaturedPlaylistCollectionViewCell"
    
    private let playlistCoverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 6
        return imageView
    }()
    
    private let playlistNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.minimumScaleFactor = 0.9
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let creatorNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.minimumScaleFactor = 0.9
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .clear
        contentView.addSubview(playlistCoverImageView)
        contentView.addSubview(playlistNameLabel)
        contentView.addSubview(creatorNameLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Methods
    func configure(with viewModel: FeaturedPlaylistCellViewModel) {
        playlistNameLabel.text = viewModel.name
        creatorNameLabel.text = "• \(viewModel.creatorName)"
        playlistCoverImageView.sd_setImage(with: viewModel.artworkURL, completed: nil)
    }
    
    
    // MARK: - Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        playlistCoverImageView.sizeToFit()
        playlistNameLabel.sizeToFit()
        creatorNameLabel.sizeToFit()
        setConstraints()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        playlistNameLabel.text = nil
        creatorNameLabel.text = nil
        playlistCoverImageView.image = nil
    }
    
    // TODO: - Set constrainsts using EasyPeasy
    private func setConstraints() {
        playlistCoverImageView.translatesAutoresizingMaskIntoConstraints = false
        playlistCoverImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        let imageSize = contentView.width - 40
        playlistCoverImageView.widthAnchor.constraint(equalToConstant: imageSize).isActive = true
        playlistCoverImageView.heightAnchor.constraint(equalToConstant: imageSize).isActive = true
        playlistCoverImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        
        playlistNameLabel.translatesAutoresizingMaskIntoConstraints = false
        playlistNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        playlistNameLabel.topAnchor.constraint(equalTo: playlistCoverImageView.bottomAnchor, constant: 2).isActive = true
        playlistNameLabel.widthAnchor.constraint(equalToConstant: contentView.width - 20).isActive = true
        playlistNameLabel.heightAnchor.constraint(equalToConstant: contentView.height - imageSize - 10 - 10 - 2).isActive = true
        
        creatorNameLabel.translatesAutoresizingMaskIntoConstraints = false
        creatorNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        creatorNameLabel.topAnchor.constraint(equalTo: playlistNameLabel.bottomAnchor).isActive = true
        creatorNameLabel.widthAnchor.constraint(equalToConstant: contentView.width - 20).isActive = true
    }
}
