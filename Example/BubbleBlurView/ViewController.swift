//
//  ViewController.swift
//  BubbleBlurView
//
//  Created by wfltaylor@gmail.com on 04/12/2019.
//  Copyright (c) 2019 wfltaylor@gmail.com. All rights reserved.
//

import UIKit
import BubbleBlurView

class ViewController: UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet weak var backgroundView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var hideButton: UIButton!
    
    //MARK: Overriden Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHideButton()
        setupBubbleView()
    }
    
    //MARK: Setup Button
    
    func setupHideButton() {
        hideButton.backgroundColor = UIColor.white
        
        hideButton.layer.cornerRadius = 20
        
        hideButton.layer.shadowRadius = 30
        hideButton.layer.shadowOpacity = 0.6
    }
    
    func setupBubbleView() {
        let bubbleView = BubbleBlurView()
        
        backgroundView.addSubview(bubbleView)
        
        bubbleView.translatesAutoresizingMaskIntoConstraints = false
        bubbleView.topAnchor.constraint(equalTo: backgroundView.topAnchor).isActive = true
        bubbleView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor).isActive = true
        bubbleView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor).isActive = true
        bubbleView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor).isActive = true
        
        bubbleView.startBubbles()
    }
    
    //MARK: UI Actions
    
    @IBAction func hideLabelsTap(_ sender: Any) {
        UIView.animate(withDuration: 0.4) {
            self.titleLabel.alpha = 0.0
            self.hideButton.alpha = 0.0
        }
    }
    
    
    //MARK: Overriden Variables

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var prefersHomeIndicatorAutoHidden: Bool {
        return true
    }
}

