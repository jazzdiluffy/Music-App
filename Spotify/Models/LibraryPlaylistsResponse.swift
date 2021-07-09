//
//  LibraryPlaylistsResponse.swift
//  Spotify
//
//  Created by Ilya Buldin on 09.07.2021.
//

import Foundation

struct LibraryPlaylistsResponse: Codable {
    let items: [Playlist]
}
