//
//  AuthManager.swift
//  Spotify
//
//  Created by Ilya Buldin on 10.05.2021.
//

import UIKit

final class AuthManager {
    static let shared = AuthManager()
    
    struct Constants {
        static let clientID = "8dc5fe23fc764d8fb64da68e5b4b2c7e"
        static let clientSecret = "90bbf0ee4761425fab89710818052eb1"
    }
    
    private init() {}
    
    public var signInURL: URL? {
        let base = "https://accounts.spotify.com/authorize"
        let scopes = "user-read-private"
        let redirectURI = "https://github.com/jazzdiluffy"
        let string = "\(base)?response_type=code&client_id=\(Constants.clientID)&scope=\(scopes)&redirect_uri=\(redirectURI)&show_dialog=TRUE"
        return URL(string: string)
    }
    
    var isSignedIn: Bool {
        return false
    }
    
    private var accessToken: String? {
        return nil
    }
    
    private var refreshToken: String? {
        return nil
    }
    
    private var tokenExpirationDate: Date? {
        return nil
    }
    
    private var shouldRefreshToken: Bool {
        return false
    }
    
    public func exchangeCodeForToken(code: String,
                                     completion: @escaping ((Bool) -> Void)
    ) {
        // Get Token
    }
    
    public func refreshAccessToken() {
        
    }
    
    private func cacheToken() {
        
    }
}
