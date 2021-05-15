//
//  ViewController.swift
//  Spotify
//
//  Created by Ilya Buldin on 09.05.2021.
//

import UIKit

class HomeViewController: UIViewController {
    
    var gradient : CAGradientLayer?
    let gradientView : UIView = {
        let view = UIView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        view.backgroundColor = .systemIndigo
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .done, target: self, action: #selector(didTapSettings))
       
        // TODO: bad gradient in landscape mode
        setupClearNavBar()
        setupGradient()
        
        
    }
    
    @objc func didTapSettings() {
        let vc = SettingsViewController()
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func setupGradient(height: CGFloat, topColor: CGColor, bottomColor: CGColor) ->  CAGradientLayer {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [topColor, bottomColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.5, y: -0.8)
        gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: height)
        return gradient
    }
    
    func setupClearNavBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = .clear
        navigationController?.navigationBar.isTranslucent = true
    }
    
    func setupGradient() {
        let height : CGFloat
        if let navigationBar = navigationController?.navigationBar {
            height = navigationBar.frame.size.height
        } else {
            height = 90
        }
        let color = UIColor.black.withAlphaComponent(0.5).cgColor // You can mess with opacity to your liking
        let clear = UIColor.black.withAlphaComponent(0.0).cgColor
        gradient = setupGradient(height: height, topColor: color, bottomColor: clear)
        view.addSubview(gradientView)
        NSLayoutConstraint.activate([
            gradientView.topAnchor.constraint(equalTo: view.topAnchor),
            gradientView.leftAnchor.constraint(equalTo: view.leftAnchor),
        ])
        gradientView.layer.insertSublayer(gradient!, at: 0)
    }
}

