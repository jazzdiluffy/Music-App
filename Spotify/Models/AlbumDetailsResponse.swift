//
//  AlbumDetailsResponse.swift
//  Spotify
//
//  Created by Ilya Buldin on 25.05.2021.
//

import Foundation

struct AlbumDetailsResponse: Codable {
    let album_type: String
    let artists: [Artist]
    let available_markets: [String]
    let external_urls: [String: String]
    let id: String
    let images: [APIImage]
    let label: String
    let name: String
    let tracks: AlbumTracksResponse
    
}

struct AlbumTracksResponse: Codable {
    let items: [AudioTrack]
}
