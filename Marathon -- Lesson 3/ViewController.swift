//
//  ViewController.swift
//  Marathon -- Lesson 3
//
//  Created by Magomet Bekov on 07.03.2023.
//

import UIKit

class ViewController: UIViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
        view.backgroundColor = .white
        
        view.addSubview(slider)
        view.addSubview(box)
        
        view.subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false}
        
    }
    
    let animator = UIViewPropertyAnimator(duration: 0.3, curve: .linear)
    
    var box: UIView {
        let box = UIView()
        let boxSide = view.frame.width * 0.2
        box.frame = CGRect(x: view.layoutMargins.left, y: 100, width: boxSide, height: boxSide)
        box.backgroundColor = .systemIndigo
        box.layer.cornerRadius = 8
        let endPoint = CGRect(x: view.frame.width - box.frame.width * 1.5, y: box.frame.origin.y, width: box.frame.width, height: box.frame.height)
        
        animator.pausesOnCompletion = true
        animator.addAnimations {
            box.frame = endPoint
            box.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2).scaledBy(x: 1.5, y: 1.5)
        }
        return box
    }
    
    lazy var slider: UISlider = {
        let slider = UISlider()
        slider.frame = CGRect(x: view.layoutMargins.left, y: box.frame.width * 1.5 + 120, width: view.frame.width - view.layoutMargins.left - view.layoutMargins.right, height: 20)
        slider.thumbTintColor = .systemBlue
        slider.maximumTrackTintColor = .systemBlue
        slider.maximumTrackTintColor = .systemGray
        slider.addTarget(self, action: #selector(self.changeValue(sender: )), for: .valueChanged)
        slider.addTarget(self, action: #selector(releaseSlider), for: .touchUpInside)
        return slider
        
    }()
    
    @objc func changeValue(sender: UISlider) {
        animator.fractionComplete = CGFloat(sender.value)
    }
    
    @objc func releaseSlider() {
        if animator.isRunning {
            slider.value = Float(animator.fractionComplete)
        }
        slider.setValue(slider.maximumValue, animated: true)
        animator.startAnimation()
    }
}
