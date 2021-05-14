//
//  UserProfile.swift
//  Spotify
//
//  Created by Ilya Buldin on 10.05.2021.
//

import UIKit

struct UserProfile: Codable {
    let country: String
    let display_name: String
    let email: String
    let explicit_content: [String: Bool]
    let external_urls: [String: String]
    let id: String
    let images: [UserImage]
    let product: String

}

struct UserImage: Codable {
    let url: String
}

