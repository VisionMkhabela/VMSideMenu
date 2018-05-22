//
//  RightSideMenuViewController.swift
//  SideMenu
//
//  Created by Vision Mkhabela on 5/17/18.
//  Copyright © 2018 Shivono. All rights reserved.
//

import Foundation
import UIKit

class LeftSideMenuViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var offsetView: UIView!
    @IBOutlet weak var sideMenuView: UIView!
    private var originalX: CGFloat = 0.0
    private var originalY: CGFloat = 0.0
    @IBOutlet weak var leadingCnstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let panGuesture = UIPanGestureRecognizer(target: self, action: #selector(moveSideMenu))
        self.sideMenuView.addGestureRecognizer(panGuesture)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedSideView))
        self.offsetView.addGestureRecognizer(tapGesture)
    }
    
    @objc func moveSideMenu(_ panGesture: UIPanGestureRecognizer) {
        
        guard let panView = panGesture.view else {
            return
        }
        
        self.view.bringSubview(toFront: panView)
        var translatePoint = panGesture.translation(in: self.view)
        
        if panGesture.state == .began {
            originalX = panView.center.x
            originalY = panView.center.y
        }
        
        translatePoint = CGPoint(x: originalX + translatePoint.x, y: originalY )
        
        if panView.frame.origin.x <= self.view.frame.origin.x {
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations: {
                panView.center = translatePoint
            }, completion: nil)
        }

        if panGesture.state == .ended {
            
            if translatePoint.x > self.view.frame.width * 0.2 {
                UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseInOut, animations: {
                    panView.center.x = self.view.frame.width/2
                }, completion: nil)
            } else {
                UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseInOut, animations: {
                    MenuToggleStatus.isMenuOpen = false
                    self.leadingCnstraint.constant = -(self.view.frame.width)
                    self.view.layoutIfNeeded()
                }, completion: nil)
            }
        }
    }
    
    @objc func tappedSideView(_ tapGesture: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseInOut, animations: {
            self.leadingCnstraint.constant = -(self.view.frame.width)
            self.view.layoutIfNeeded()
            MenuToggleStatus.isMenuOpen = false
        }, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
