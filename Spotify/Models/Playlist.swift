//
//  Playlist.swift
//  Spotify
//
//  Created by Ilya Buldin on 10.05.2021.
//

import UIKit


struct Playlist: Codable {
    let description: String
    let external_urls: [String: String]
    let id: String
    let images: [APIImage]
    let name: String
    let owner: User
}
