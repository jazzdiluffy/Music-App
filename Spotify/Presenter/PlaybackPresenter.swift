//
//  PlaybackPresenter.swift
//  Spotify
//
//  Created by Ilya Buldin on 04.07.2021.
//

import UIKit

final class PlaybackPresenter {
    
    // MARK: - Methods
    static func startPlayback(from viewController: UIViewController, track: AudioTrack) {
        let vc = PlayerViewController()
        vc.title = track.name
        viewController.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
    }
    
    static func startPlayback(from viewController: UIViewController, tracks: [AudioTrack]) {
        let vc = PlayerViewController()
        viewController.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
    }
}
