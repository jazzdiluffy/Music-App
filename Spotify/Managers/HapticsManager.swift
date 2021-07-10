//
//  HapticsManager.swift
//  Spotify
//
//  Created by Ilya Buldin on 10.05.2021.
//

import UIKit

final class HapticsManager {
    
    // MARK: - Properties
    static let shared = HapticsManager()
    
    
    // MARK: - Init
    private init() {
         
    }
    
    
    // MARK: - Methods
    public func vibrateForSelection() {
        DispatchQueue.main.async {
            let generator = UISelectionFeedbackGenerator()
            generator.prepare()
            generator.selectionChanged()
        }
    }
    
    public func vibrate(for type: UINotificationFeedbackGenerator.FeedbackType) {
        DispatchQueue.main.async {
            let generator = UINotificationFeedbackGenerator()
            generator.prepare()
            generator.notificationOccurred(type)
        }
    }
}
