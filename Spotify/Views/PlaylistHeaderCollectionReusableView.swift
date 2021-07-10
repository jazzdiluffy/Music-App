//
//  PlaylistHeaderCollectionReusableView.swift
//  Spotify
//
//  Created by Ilya Buldin on 28.05.2021.
//

import SDWebImage
import UIKit

protocol PlaylistHeaderCollectionReusableViewDelegate: AnyObject {
    func playlistHeaderCollectionReusableViewDidTapPlayAll(_ header: PlaylistHeaderCollectionReusableView)
}


final class PlaylistHeaderCollectionReusableView: UICollectionReusableView {
    
    // MARK: - Properties
    static let identifier = "PlaylistHeaderCollectionReusableView"
    
    weak var delegate: PlaylistHeaderCollectionReusableViewDelegate?
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 30, weight: .bold)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 4
        label.minimumScaleFactor = 0.9
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "photo")
        imageView.layer.shadowColor = UIColor.darkGray.cgColor
        imageView.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        imageView.layer.shadowRadius = 20.0
        imageView.layer.shadowOpacity = 0.9
        imageView.tintColor = .white
        return imageView
    }()
    
    private let playAllButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        let image = UIImage(
            systemName: "play.fill",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 33, weight: .regular)
        )
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 30
        return button
    }()
    
    
    // MARK: -Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(descriptionLabel)
        addSubview(playAllButton)
        playAllButton.addTarget(self, action: #selector(didTapPlayAll), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Methods
    @objc func didTapPlayAll() {
        delegate?.playlistHeaderCollectionReusableViewDidTapPlayAll(self)
    }
    
    func configure(with viewModel: PlaylistHeaderReusableViewViewModel) {
        nameLabel.text = viewModel.name
        descriptionLabel.text = viewModel.description
        imageView.sd_setImage(
            with: viewModel.artworkURL,
            placeholderImage: UIImage(systemName: "photo.on.rectangle.angled"),
            completed: nil
        )
        
        if let averageColor = imageView.image?.averageColor {
            backgroundColor = averageColor
        }
        
        if let brightnessFlag = backgroundColor?.isLight(), brightnessFlag {
            nameLabel.textColor = .black
            descriptionLabel.textColor = .black
        } else {
            nameLabel.textColor = .white
            descriptionLabel.textColor = .white
        }
    }
    
    
    // MARK: - Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        let imageSize: CGFloat = width / 1.3
        imageView.frame = CGRect(
            x: (width - imageSize) / 2,
            y: 40,
            width: imageSize,
            height: imageSize
        )
        nameLabel.frame = CGRect(
            x: 15,
            y: imageView.bottom + 15,
            width: width - 20,
            height: 32
        )
        descriptionLabel.frame = CGRect(
            x: 15,
            y: nameLabel.bottom,
            width: width - 90,
            height: 80
        )
        descriptionLabel.sizeToFit()
        playAllButton.frame = CGRect(x: width - 70, y: height - 70, width: 60, height: 60)
    }
}
