//
//  NewReleaseCollectionViewCell.swift
//  Spotify
//
//  Created by Ilya Buldin on 19.05.2021.
//

import UIKit
import SDWebImage

class NewReleaseCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let identifier = "NewReleaseCollectionViewCell"
    
    private let albumCoverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 6
        return imageView
    }()
    
    private let albumNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.numberOfLines = 2
        label.minimumScaleFactor = 0.9
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let numberOfTracksLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 1
        return label
    }()
    
    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .clear
        contentView.addSubview(albumCoverImageView)
        contentView.addSubview(albumNameLabel)
        contentView.addSubview(artistNameLabel)
        contentView.addSubview(numberOfTracksLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Methods
    func configure(with viewModel: NewReleasesCellViewModel) {
        albumNameLabel.text = viewModel.name
        artistNameLabel.text = viewModel.artistName
        numberOfTracksLabel.text = "Tracks: \(viewModel.numberOfTracks)"
        albumCoverImageView.sd_setImage(with: viewModel.artworkURL, completed: nil)
    }
    
    
    // MARK: - Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        albumNameLabel.sizeToFit()
        artistNameLabel.sizeToFit()
        numberOfTracksLabel.sizeToFit()
        setConstraints()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        albumNameLabel.text = nil
        artistNameLabel.text = nil
        numberOfTracksLabel.text = nil
        albumCoverImageView.image = nil
    }
    
    // TODO: - Set Constrainsts using EasyPeasy
    private func setConstraints() {
        albumCoverImageView.translatesAutoresizingMaskIntoConstraints = false
        albumCoverImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5).isActive = true
        albumCoverImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        let imageSize = contentView.height - 10
        albumCoverImageView.widthAnchor.constraint(equalToConstant: imageSize).isActive = true
        albumCoverImageView.heightAnchor.constraint(equalToConstant: imageSize).isActive = true
        
        albumNameLabel.translatesAutoresizingMaskIntoConstraints = false
        albumNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        albumNameLabel.leftAnchor.constraint(equalTo: albumCoverImageView.rightAnchor, constant: 10).isActive = true
        albumNameLabel.widthAnchor.constraint(equalToConstant: contentView.width - imageSize - 60).isActive = true
        
        artistNameLabel.translatesAutoresizingMaskIntoConstraints = false
        artistNameLabel.leftAnchor.constraint(equalTo: albumCoverImageView.rightAnchor, constant: 10).isActive = true
        artistNameLabel.topAnchor.constraint(equalTo: albumNameLabel.bottomAnchor, constant: 2).isActive = true
        artistNameLabel.widthAnchor.constraint(equalToConstant: contentView.width - imageSize - 60).isActive = true
        
        numberOfTracksLabel.translatesAutoresizingMaskIntoConstraints = false
        numberOfTracksLabel.leftAnchor.constraint(equalTo: albumCoverImageView.rightAnchor, constant: 10).isActive = true
        numberOfTracksLabel.topAnchor.constraint(equalTo: artistNameLabel.bottomAnchor, constant: 2).isActive = true
        numberOfTracksLabel.widthAnchor.constraint(equalToConstant: contentView.width - imageSize - 60).isActive = true
    }
}
