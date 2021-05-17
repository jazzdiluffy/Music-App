//
//  Extensions.swift
//  Spotify
//
//  Created by Ilya Buldin on 11.05.2021.
//

import UIKit

extension UIView {
    var width: CGFloat {
        return frame.size.width
    }
    
    var height: CGFloat {
        return frame.size.height
    }
    
    var left: CGFloat {
        return frame.origin.x
    }
    
    var rigth: CGFloat {
        return left + width
    }
    
    var top: CGFloat {
        return frame.origin.y
    }
    
    var bottom: CGFloat {
        return top + height
    }
}


extension UIViewController {
    public func setupGradient(gradient: inout CAGradientLayer?, gradientView: UIView) {
        
        let height = getNavBarHeightAndWidth().height
        let color = UIColor.black.withAlphaComponent(0.5).cgColor
        let clear = UIColor.black.withAlphaComponent(0.0).cgColor
        gradient = setupGradient(height: height, topColor: color, bottomColor: clear)
        view.addSubview(gradientView)
        NSLayoutConstraint.activate([
            gradientView.topAnchor.constraint(equalTo: view.topAnchor),
            gradientView.leftAnchor.constraint(equalTo: view.leftAnchor),
        ])
        gradientView.layer.insertSublayer(gradient!, at: 0)
    }
    
    public func setupClearNavBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = .clear
        navigationController?.navigationBar.isTranslucent = true
    }
    
    public func setupGradient(height: CGFloat, topColor: CGColor, bottomColor: CGColor) ->  CAGradientLayer {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [topColor, bottomColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.5, y: -0.8)
        gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
        
        let width = getNavBarHeightAndWidth().width
        
        print(width)
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: width, height: height)
        
        return gradient
    }
    
    public func getNavBarHeightAndWidth() -> (height: CGFloat, width: CGFloat) {
        var width: CGFloat
        var height: CGFloat
        if let navigationBar = navigationController?.navigationBar {
            height = navigationBar.frame.size.height
            width = navigationBar.frame.size.width
        } else {
            width = 414
            height = 90
        }
        
        return (height, width)
    }
}

