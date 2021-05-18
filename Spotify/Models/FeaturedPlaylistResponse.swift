//
//  FeaturedPlaylistResponse.swift
//  Spotify
//
//  Created by Ilya Buldin on 18.05.2021.
//

import UIKit

struct FeaturedPlaylistResponse: Codable {
    let playlists: PlaylistResponse
}

struct PlaylistResponse: Codable {
    let items: [Playlist]
}


struct User: Codable {
    let display_name: String
    let external_urls: [String: String]
    let id: String
}

