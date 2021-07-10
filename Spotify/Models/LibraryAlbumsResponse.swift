//
//  LibraryAlbumsResponse.swift
//  Spotify
//
//  Created by Ilya Buldin on 10.07.2021.
//

import Foundation

struct LibraryAlbumsResponse: Codable {
    let items: [SavedAlbum]
}

struct SavedAlbum: Codable {
    let added_at: String
    let album: Album
}
