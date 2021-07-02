//
//  SettingsModels.swift
//  Spotify
//
//  Created by Ilya Buldin on 14.05.2021.
//

import Foundation

struct Section {
    let title: String
    let options: [Option]
}

struct Option {
    let title: String
    let handler: () -> Void
}
