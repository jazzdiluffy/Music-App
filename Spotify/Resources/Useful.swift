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

public func getNavBarHeightAndWidth(vc: UIViewController) -> (height: CGFloat, width: CGFloat) {
    var width: CGFloat
    var height: CGFloat
    if let navigationBar = vc.navigationController?.navigationBar {
        height = navigationBar.frame.size.height
        width = navigationBar.frame.size.width
    } else {
        width = 414
        height = 90
    }
    
    return (height, width)
}
