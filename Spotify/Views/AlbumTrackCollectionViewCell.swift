//
//  AlbumTrackCollectionViewCell.swift
//  Spotify
//
//  Created by Ilya Buldin on 01.06.2021.
//

import UIKit


class AlbumTrackCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let identifier = "AlbumTrackCollectionViewCell"
    
    private let trackNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 19, weight: .semibold)
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
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
        contentView.addSubview(trackNameLabel)
        contentView.addSubview(separatorView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Methods
    func configure(with viewModel: AlbumCollectionViewCellViewModel) {
        trackNameLabel.text = viewModel.name
    }
    
    
    // MARK: - Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        trackNameLabel.sizeToFit()
        setConstraints()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        trackNameLabel.text = nil
    }
    
    // TODO: - Set constrainsts using EasyPeasy
    private func setConstraints() {
        trackNameLabel.translatesAutoresizingMaskIntoConstraints = false
        trackNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15).isActive = true
        trackNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        trackNameLabel.widthAnchor.constraint(equalToConstant: contentView.width - 30).isActive = true
        
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.heightAnchor.constraint(equalToConstant: 1 / UIScreen.main.scale).isActive = true
        separatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        separatorView.widthAnchor.constraint(equalToConstant: contentView.width - 15).isActive = true
        separatorView.leadingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -(contentView.width - 15)).isActive = true
    }
}

