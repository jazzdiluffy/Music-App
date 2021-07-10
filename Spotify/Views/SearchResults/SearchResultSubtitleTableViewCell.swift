//
//  SearchResultsSubtitleTableViewCell.swift
//  Spotify
//
//  Created by Ilya Buldin on 04.07.2021.
//

import UIKit
import SDWebImage

class SearchResultSubtitleTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    static let identifier = "SearchResultSubtitleTableViewCell"
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.numberOfLines = 1
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 13)
        label.numberOfLines = 1
        return label
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 6
        return imageView
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .quaternaryLabel
        return view
    }()
    
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(label)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(iconImageView)
        contentView.addSubview(separatorView)
        contentView.clipsToBounds = true
        accessoryType = .disclosureIndicator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        setConstrainsts()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        label.text = nil
        subtitleLabel.text = nil
    }
    
    private func setConstrainsts() {
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5).isActive = true
        iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        let iconImageViewSize = contentView.height - 14
        iconImageView.heightAnchor.constraint(equalToConstant: iconImageViewSize).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: iconImageViewSize).isActive = true
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 10).isActive = true
        label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        label.widthAnchor.constraint(equalToConstant: contentView.width - 15 - iconImageViewSize).isActive = true
        
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 10).isActive = true
        subtitleLabel.topAnchor.constraint(equalTo: label.bottomAnchor).isActive = true
        subtitleLabel.widthAnchor.constraint(equalToConstant: contentView.width - 15 - iconImageViewSize).isActive = true
        
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.heightAnchor.constraint(equalToConstant: 1 / UIScreen.main.scale).isActive = true
        separatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        separatorView.widthAnchor.constraint(equalToConstant: contentView.width - iconImageViewSize  - 10).isActive = true
        separatorView.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 10).isActive = true
    }
    
    // MARK: - Methods
    func configure(with viewModel: SearchResultSubtitleTableViewCellViewModel) {
        label.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        guard let photoURL = viewModel.imageURL else {
            let imagePlaceholder = UIImage(systemName: "photo.on.rectangle.angled")
            iconImageView.image = imagePlaceholder
            iconImageView.tintColor = .secondaryLabel
            return
        }
        iconImageView.sd_setImage(with: photoURL, completed: nil)
    }
}
