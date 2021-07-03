//
//  CategoryCollectionViewCell.swift
//  Spotify
//
//  Created by Ilya Buldin on 03.06.2021.
//

import UIKit
import SDWebImage

class CategoryCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let identifier = "CategoryCollectionViewCell"
    
    private let colors: [UIColor] = [
        .systemPink,
        .systemTeal,
        .systemGreen,
        .systemIndigo,
        .systemYellow,
        .systemOrange,
        .systemRed,
        .systemGray
    ]
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        imageView.image = UIImage(systemName: "music.quarternote.3", withConfiguration: UIImage.SymbolConfiguration(pointSize: 50, weight: .regular))
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.numberOfLines = 4
        return label
    }()
    
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 8
        contentView.addSubview(imageView)
        contentView.addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Methods
    func configure(with viewModel: CategoryCollectionViewCellViewModel) {
        label.text = viewModel.title
        imageView.sd_setImage(with: viewModel.artworkURL, completed: nil)
        contentView.backgroundColor = colors.randomElement()
    }
    
    
    // MARK: - Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        setConstraints()
        imageView.transform = CGAffineTransform(rotationAngle: (18.0 * .pi) / 180.0)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
        imageView.image = UIImage(
            systemName: "music.quarternote.3",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 50, weight: .regular)
        )
    }
    
    // TODO: Set constrainsts using EasyPeasy
    private func setConstraints() {
        let imageSize = height / 1.5
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3).isActive = true
        imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 12).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: imageSize).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: imageSize).isActive = true
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 7).isActive = true
        label.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 7).isActive = true
        label.widthAnchor.constraint(equalToConstant: contentView.width - imageSize - 20).isActive = true
    }
}
