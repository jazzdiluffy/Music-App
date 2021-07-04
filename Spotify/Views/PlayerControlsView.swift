//
//  PlayerControlsView.swift
//  Spotify
//
//  Created by Ilya Buldin on 04.07.2021.
//

import UIKit

final class PlayerControlsView: UIView {
    
    // MARK: - Properties
    private let volumeSlider: UISlider = {
        let slider = UISlider()
        slider.value = 0.5
        return slider
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 28, weight: .semibold)
        label.text = "Магистральная, 310"
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textColor = .secondaryLabel
        label.text = "Из альбома: sexmusic"
        return label
    }()
    
    private let backwardButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        let image = UIImage(
            systemName: "backward.fill",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .bold)
        )
        button.setImage(image, for: .normal)
        return button
    }()
    
    private let forwardButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        let image = UIImage(
            systemName: "forward.fill",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .bold)
        )
        button.setImage(image, for: .normal)
        return button
    }()
    
    private let playPauseButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        let image = UIImage(
            systemName: "pause.fill",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 34, weight: .bold)
        )
        button.setImage(image, for: .normal)
        return button
    }()
    
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(nameLabel)
        addSubview(subtitleLabel)
        addSubview(volumeSlider)
        addSubview(backwardButton)
        addSubview(forwardButton)
        addSubview(playPauseButton)
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        setConstraints()
    }
    
    private func setConstraints() {
        volumeSlider.translatesAutoresizingMaskIntoConstraints = false
        volumeSlider.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        volumeSlider.widthAnchor.constraint(equalToConstant: width - 40).isActive = true
        volumeSlider.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        playPauseButton.translatesAutoresizingMaskIntoConstraints = false
        playPauseButton.centerXAnchor.constraint(equalTo: volumeSlider.centerXAnchor).isActive = true
        playPauseButton.topAnchor.constraint(equalTo: volumeSlider.bottomAnchor, constant: height / 6).isActive = true
        
        backwardButton.translatesAutoresizingMaskIntoConstraints = false
        backwardButton.centerYAnchor.constraint(equalTo: playPauseButton.centerYAnchor).isActive = true
        backwardButton.rightAnchor.constraint(equalTo: playPauseButton.leftAnchor, constant: -(width / 4)).isActive = true
        
        forwardButton.translatesAutoresizingMaskIntoConstraints = false
        forwardButton.centerYAnchor.constraint(equalTo: playPauseButton.centerYAnchor).isActive = true
        forwardButton.leftAnchor.constraint(equalTo: playPauseButton.rightAnchor, constant: width / 4).isActive = true
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: width - 40).isActive = true
        nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        subtitleLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20).isActive = true
        subtitleLabel.widthAnchor.constraint(equalToConstant: width - 40).isActive = true
    }
}
