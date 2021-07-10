//
//  RecommendedTrackCollectionViewCell.swift
//  Spotify
//
//  Created by Ilya Buldin on 19.05.2021.
//

import UIKit

class RecommendedTrackCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
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
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.numberOfLines = 2
        label.textAlignment = .left
        return label
    }()
    
    private let creatorNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .thin)
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    private let chevronImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "chevron.right"), highlightedImage: nil)
        imageView.tintColor = .quaternaryLabel
        return imageView
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .quaternaryLabel
        return view
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .clear
        contentView.addSubview(trackCoverImageView)
        contentView.addSubview(trackNameLabel)
        contentView.addSubview(creatorNameLabel)
        contentView.addSubview(chevronImageView)
        contentView.addSubview(separatorView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Methods
    func configure(with viewModel: RecommendedTracksCellViewModel) {
        trackNameLabel.text = viewModel.name
        creatorNameLabel.text = viewModel.artistName
        trackCoverImageView.sd_setImage(with: viewModel.artworkURL, completed: nil)
    }
    
    
    // MARK: - Layout
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
    
    private func setConstraints() {
        trackCoverImageView.translatesAutoresizingMaskIntoConstraints = false
        let imageSize = contentView.height - 14
        trackCoverImageView.heightAnchor.constraint(equalToConstant: imageSize).isActive = true
        trackCoverImageView.widthAnchor.constraint(equalToConstant: imageSize).isActive = true
        trackCoverImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        trackCoverImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        
        trackNameLabel.translatesAutoresizingMaskIntoConstraints = false
        trackNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        trackNameLabel.leadingAnchor.constraint(equalTo: trackCoverImageView.trailingAnchor, constant: 10).isActive = true
        trackNameLabel.widthAnchor.constraint(equalToConstant: contentView.width - imageSize - 60).isActive = true
        
        creatorNameLabel.translatesAutoresizingMaskIntoConstraints = false
        creatorNameLabel.leadingAnchor.constraint(equalTo: trackCoverImageView.trailingAnchor, constant: 10).isActive = true
        creatorNameLabel.topAnchor.constraint(equalTo: trackNameLabel.bottomAnchor, constant: 3).isActive = true
        creatorNameLabel.widthAnchor.constraint(equalToConstant: contentView.width - imageSize - 60).isActive = true
        
        chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        chevronImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        chevronImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15).isActive = true
        
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.heightAnchor.constraint(equalToConstant: 1 / UIScreen.main.scale).isActive = true
        separatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        separatorView.widthAnchor.constraint(equalToConstant: contentView.width - imageSize  - 10).isActive = true
        separatorView.leadingAnchor.constraint(equalTo: trackCoverImageView.trailingAnchor, constant: 10).isActive = true
    }
}
