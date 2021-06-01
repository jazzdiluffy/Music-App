//
//  RecommendedTrackCollectionViewCell.swift
//  Spotify
//
//  Created by Ilya Buldin on 19.05.2021.
//

import UIKit

class RecommendedTrackCollectionViewCell: UICollectionViewCell {
    static let identifier = "RecommendedTrackCollectionViewCell"
    
    private let trackCoverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 6
        return imageView
    }()
    
    private let trackNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    
    private let creatorNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .thin)
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemFill
        contentView.addSubview(trackCoverImageView)
        contentView.addSubview(trackNameLabel)
        contentView.addSubview(creatorNameLabel)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        trackCoverImageView.sizeToFit()
        trackNameLabel.sizeToFit()
        creatorNameLabel.sizeToFit()
        setConstraints()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        trackNameLabel.text = nil
        creatorNameLabel.text = nil
        trackCoverImageView.image = nil
        
    }
    
    func configure(with viewModel: RecommendedTracksCellViewModel) {
        trackNameLabel.text = viewModel.name
        creatorNameLabel.text = viewModel.artistName
        trackCoverImageView.sd_setImage(with: viewModel.artworkURL, completed: nil)
    }
    
    private func setConstraints() {
        trackCoverImageView.translatesAutoresizingMaskIntoConstraints = false
        let imageSize = contentView.height
        trackCoverImageView.heightAnchor.constraint(equalToConstant: imageSize).isActive = true
        trackCoverImageView.widthAnchor.constraint(equalToConstant: imageSize).isActive = true
        trackCoverImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        
        trackNameLabel.translatesAutoresizingMaskIntoConstraints = false
        trackNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        trackNameLabel.leadingAnchor.constraint(equalTo: trackCoverImageView.trailingAnchor, constant: 20).isActive = true
        trackNameLabel.widthAnchor.constraint(equalToConstant: contentView.width - imageSize - 30).isActive = true
        
        creatorNameLabel.translatesAutoresizingMaskIntoConstraints = false
        creatorNameLabel.leadingAnchor.constraint(equalTo: trackCoverImageView.trailingAnchor, constant: 20).isActive = true
        creatorNameLabel.topAnchor.constraint(equalTo: trackNameLabel.bottomAnchor, constant: 10).isActive = true
        creatorNameLabel.widthAnchor.constraint(equalToConstant: contentView.width - imageSize - 30).isActive = true
    }
    
}
