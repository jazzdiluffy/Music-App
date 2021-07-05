//
//  AudioTrack.swift
//  Spotify
//
//  Created by Ilya Buldin on 10.05.2021.
//

import Foundation

struct AudioTrack: Codable {
    let album: Album?
    let artists: [Artist]
    let available_markets: [String]
    let disc_number: Int
    let duration_ms: Int
    let explicit: Bool
    let external_urls: [String: String]
    let id: String
    let name: String
    let popularity: Int?
    let preview_url: String?
}
