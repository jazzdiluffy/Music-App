//
//  FeaturedPlaylistCollectionViewCell.swift
//  Spotify
//
//  Created by Ilya Buldin on 19.05.2021.
//

import UIKit

class FeaturedPlaylistCollectionViewCell: UICollectionViewCell {
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
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.minimumScaleFactor = 0.7
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    
    private let creatorNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .thin)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(playlistCoverImageView)
        contentView.addSubview(playlistNameLabel)
        contentView.addSubview(creatorNameLabel)
        contentView.layer.cornerRadius = 6
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    
    func configure(with viewModel: FeaturedPlaylistCellViewModel) {
        playlistNameLabel.text = viewModel.name
        creatorNameLabel.text = "• \(viewModel.creatorName)"
        playlistCoverImageView.sd_setImage(with: viewModel.artworkURL, completed: nil)
    }
    
    private func setConstraints() {
        playlistCoverImageView.translatesAutoresizingMaskIntoConstraints = false
        playlistCoverImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        let imageSize = contentView.width - 50
        playlistCoverImageView.widthAnchor.constraint(equalToConstant: imageSize).isActive = true
        playlistCoverImageView.heightAnchor.constraint(equalToConstant: imageSize).isActive = true
        playlistCoverImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        
        playlistNameLabel.translatesAutoresizingMaskIntoConstraints = false
        playlistNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        playlistNameLabel.topAnchor.constraint(equalTo: playlistCoverImageView.bottomAnchor, constant: 3).isActive = true
        playlistNameLabel.widthAnchor.constraint(equalToConstant: contentView.width - 20).isActive = true
        playlistNameLabel.heightAnchor.constraint(equalToConstant: contentView.height - imageSize - 10 - 10 - 8).isActive = true
        
        creatorNameLabel.translatesAutoresizingMaskIntoConstraints = false
        creatorNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        creatorNameLabel.topAnchor.constraint(equalTo: playlistNameLabel.bottomAnchor).isActive = true
        creatorNameLabel.widthAnchor.constraint(equalToConstant: contentView.width - 20).isActive = true
    }
}
