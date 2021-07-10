//
//  SearchResultDefaultTableViewCell.swift
//  Spotify
//
//  Created by Ilya Buldin on 04.07.2021.
//

import UIKit
import SDWebImage

class SearchResultDefaultTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    static let identifier = "SearchResultDefaultTableViewCell"
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .semibold) 
        label.numberOfLines = 1
        return label
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
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
        iconImageView.layer.cornerRadius = (contentView.height - 10) / 2
        iconImageView.layer.masksToBounds = true
        setConstrainsts()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        label.text = nil
    }
    
    private func setConstrainsts() {
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5).isActive = true
        iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        let iconImageViewSize = contentView.height - 10
        iconImageView.heightAnchor.constraint(equalToConstant: iconImageViewSize).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: iconImageViewSize).isActive = true
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 8).isActive = true
        label.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor).isActive = true
        label.widthAnchor.constraint(equalToConstant: contentView.width - 15 - iconImageViewSize).isActive = true
        
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.heightAnchor.constraint(equalToConstant: 1 / UIScreen.main.scale).isActive = true
        separatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        separatorView.widthAnchor.constraint(equalToConstant: contentView.width - iconImageViewSize  - 10).isActive = true
        separatorView.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 10).isActive = true
    }
    
    // MARK: - Methods
    func configure(with viewModel: SearchResultDefaultTableViewCellViewModel) {
        label.text = viewModel.title
        guard let photoURL = viewModel.imageURL else {
            let imagePlaceholder = UIImage(systemName: "photo.on.rectangle.angled")
            iconImageView.image = imagePlaceholder
            iconImageView.tintColor = .secondaryLabel
            return
        }
        iconImageView.sd_setImage(with: photoURL, completed: nil)
        return
    }
}
