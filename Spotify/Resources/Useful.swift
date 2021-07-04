//
//  Useful.swift
//  Spotify
//
//  Created by Ilya Buldin on 15.05.2021.
//

import UIKit


public func getImageFrom(gradientLayer:CAGradientLayer) -> UIImage? {
    var gradientImage:UIImage?
    UIGraphicsBeginImageContext(gradientLayer.frame.size)
    if let context = UIGraphicsGetCurrentContext() {
        gradientLayer.render(in: context)
        gradientImage = UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch)
    }
    UIGraphicsEndImageContext()
    return gradientImage
}
 
