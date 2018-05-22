//
//  UIViewController+Extension.swift
//  SideMenu
//
//  Created by Vision Mkhabela on 5/15/18.
//  Copyright © 2018 Shivono. All rights reserved.
//

import Foundation
import UIKit

public extension UIViewController {
    
    func addRightSideMenu() {
        let bundle = Bundle(for: RightSideMenuViewController.self)
        let customView = getViewController(with: MenuConfig.storyboardName, viewControllerId: MenuConfig.viewControllerId, bundle: bundle)
        self.addRightParentViewContoller(childViewController: customView, sideMenuName: menuStroryboard, sideMenuId: rightMenuId )
    }
    
    func addLeftSideMenu() {
        let bundle = Bundle(for: LeftSideMenuViewController.self)
        let customView = getViewController(with: MenuConfig.storyboardName, viewControllerId: MenuConfig.viewControllerId, bundle: bundle)
        self.addLeftParentViewContoller(childViewController: customView, sideMenuName: menuStroryboard, sideMenuId: leftMenuId )
    }
    
    func addLeftParentViewContoller(childViewController: UIViewController, sideMenuName: String, sideMenuId: String) {
        
        let bundle = Bundle(for: LeftSideMenuViewController.self)

        guard let sideMenuVc = getViewController(with: sideMenuName, viewControllerId: sideMenuId, bundle: bundle) as? LeftSideMenuViewController else {
            return
        }
        
        self.addChildViewController(sideMenuVc)
        sideMenuVc.view.tag = 30
        self.view.addSubview(sideMenuVc.view)
        sideMenuVc.view.anchor(top: self.view.topAnchor, leading: self.view.leadingAnchor, bottom: nil, trailing: nil, size: CGSize(width: self.view.frame.width, height:  self.view.frame.height - MenuConfig.heightDiff))
        sideMenuVc.didMove(toParentViewController: self)
        
        
        sideMenuVc.addChildViewController(childViewController)
        sideMenuVc.containerView.addSubview(childViewController.view)
        childViewController.view.anchor(top: sideMenuVc.containerView.topAnchor, leading: sideMenuVc.containerView.leadingAnchor, bottom: sideMenuVc.containerView.bottomAnchor, trailing: sideMenuVc.containerView.trailingAnchor)
        
        childViewController.didMove(toParentViewController: sideMenuVc)
        
        self.prepareMenuForAnimation(menuType: .leftMenu)
    }
    
    func addRightParentViewContoller(childViewController: UIViewController, sideMenuName: String, sideMenuId: String) {
        
        let bundle = Bundle(for: RightSideMenuViewController.self)

        guard let sideMenuVc = getViewController(with: sideMenuName, viewControllerId: sideMenuId, bundle: bundle) as? RightSideMenuViewController else {
            return
        }
        
        self.addChildViewController(sideMenuVc)
        sideMenuVc.view.tag = 10
        self.view.addSubview(sideMenuVc.view)
        sideMenuVc.view.anchor(top: self.view.topAnchor, leading: nil, bottom: nil, trailing: self.view.trailingAnchor, size: CGSize(width: self.view.frame.width, height:  self.view.frame.height - MenuConfig.heightDiff))
        sideMenuVc.didMove(toParentViewController: self)
        
        
        sideMenuVc.addChildViewController(childViewController)
        sideMenuVc.containerView.addSubview(childViewController.view)
        childViewController.view.anchor(top: sideMenuVc.containerView.topAnchor, leading: sideMenuVc.containerView.leadingAnchor, bottom: sideMenuVc.containerView.bottomAnchor, trailing: sideMenuVc.containerView.trailingAnchor)
        
        childViewController.didMove(toParentViewController: sideMenuVc)
        
        self.prepareMenuForAnimation(menuType: .rightMenu)
    }
    
    func getViewController(with storyboardName: String, viewControllerId: String, bundle: Bundle?) -> UIViewController {
        let childStoryboard = UIStoryboard(name: storyboardName, bundle: bundle)
        let childViewController = childStoryboard.instantiateViewController(withIdentifier: viewControllerId)
        return childViewController
    }
    
    func prepareMenuForAnimation(menuType: MenuType) {
        
        let menuParams = getViewParams(menuType: menuType)
        
        for subView in self.view.subviews where subView.tag == menuParams.viewTag {
            subView.isHidden = true
            for constraint in subView.constraints where constraint.identifier == menuParams.constraintId {
                constraint.constant = self.getSubViewPosition(menuType: menuType)
            }
        }
    }

    func showOffsetView(menuType: MenuType) {
        
        let viewTags = self.getNestedTags(menuType: menuType)
        for subView in self.view.subviews where subView.tag == viewTags.superViewTag {
            for innerView in subView.subviews where innerView.tag == viewTags.superViewTag  {
                UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations: {
                    innerView.isHidden = false
                    innerView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
                }, completion: nil)
            }
        }
    }
    
    func hideOffsetView(menuType: MenuType) {
        let viewTags = self.getNestedTags(menuType: menuType)
        for subView in self.view.subviews where subView.tag == viewTags.superViewTag {
            for innerView in subView.subviews where innerView.tag == viewTags.superViewTag  {
                UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations: {
                    innerView.isHidden = true
                }, completion: nil)
            }
        }
    }
    
    func closeMenu(menuType: MenuType) {
        
         MenuToggleStatus.isMenuOpen = false
        let menuParams = getViewParams(menuType: menuType)
        
        for subView in self.view.subviews where subView.tag == menuParams.viewTag {
            subView.isHidden = false
            for constraint in subView.constraints where constraint.identifier == menuParams.constraintId {
                UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                    constraint.constant = self.getSubViewPosition(menuType: menuType)
                    subView.layoutIfNeeded()
                }, completion: nil)
            }
        }
        self.hideOffsetView(menuType: menuType)
    }
    
    func openMenu(menuType: MenuType) {
        
        MenuToggleStatus.isMenuOpen = true
        let menuParams = getViewParams(menuType: menuType)
        
        for subView in self.view.subviews where subView.tag == menuParams.viewTag {
            subView.isHidden = false
            for constraint in subView.constraints where constraint.identifier == menuParams.constraintId {
                UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                    constraint.constant = 0
                    subView.layoutIfNeeded()
                }, completion: nil)
            }
        }
        self.showOffsetView(menuType: menuType)
    }
    
    func getViewParams(menuType: MenuType) -> (viewTag: Int, constraintId: String) {
        
        switch menuType {
        case .leftMenu:
            return (30, leading)
        default:
            return (10, trailing)
        }
    }
    
    func getSubViewPosition(menuType: MenuType) -> CGFloat {
        switch menuType {
        case .leftMenu:
            return -(self.view.frame.width)
        default:
            return self.view.frame.width
        }
    }
    
    func toggleMenu(menuType: MenuType) {
        
        if  MenuToggleStatus.isMenuOpen {
            self.closeMenu(menuType: menuType)
        } else {
            self.openMenu(menuType: menuType)
        }
    }
    
    func getNestedTags(menuType: MenuType) -> (superViewTag: Int, subViewTag: Int) {
        
        switch menuType {
        case .leftMenu:
            return (30, 40)
        default:
            return (10, 20)
        }
    }
}

public enum MenuType {
    case rightMenu
    case leftMenu
}
