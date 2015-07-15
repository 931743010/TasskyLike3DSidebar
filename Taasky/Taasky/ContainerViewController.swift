//
//  ContainerViewController.swift
//  Taasky
//
//  Created by wamaker on 15/7/14.
//  Copyright (c) 2015年 Ray Wenderlich. All rights reserved.
//

import UIKit

private var detailViewController: DetailViewController?

class ContainerViewController: UIViewController, UIScrollViewDelegate {
    
    var showingMenu = false
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var menuContainerView: UIView!

    var menuItem: NSDictionary? {
        didSet {
            hideOrShowMenu(false, animated: true)
            
            if let detailViewController = detailViewController {
                detailViewController.menuItem = menuItem
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Remove the drop shadow from the navigation bar
        hideOrShowMenu(false, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        hideOrShowMenu(showingMenu, animated: false)
        
        menuContainerView.layer.anchorPoint = CGPoint(x: 1.0, y: 0.5)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "DetailViewSegue" {
            let navigationController = segue.destinationViewController as! UINavigationController
            detailViewController = navigationController.topViewController as? DetailViewController
        }
    }
    
    func hideOrShowMenu(show: Bool, animated: Bool) {
        let menuOffset = CGRectGetWidth(menuContainerView.bounds)
        scrollView.setContentOffset(show ? CGPointZero : CGPoint(x: menuOffset, y: 0), animated: animated)
        
        showingMenu = show
    }
    
    func transformForFraction(fraction:CGFloat) -> CATransform3D {
        var identity = CATransform3DIdentity
        identity.m34 = -1.0 / 1000.0;
        let angle = Double(1.0 - fraction) * -M_PI_2
        let xOffset = CGRectGetWidth(menuContainerView.bounds) * 0.5
        let rotateTransform = CATransform3DRotate(identity, CGFloat(angle), 0.0, 1.0, 0.0)
        let translateTransform = CATransform3DMakeTranslation(xOffset, 0.0, 0.0)
        return CATransform3DConcat(rotateTransform, translateTransform)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        scrollView.pagingEnabled = scrollView.contentOffset.x < (scrollView.contentSize.width - CGRectGetWidth(scrollView.frame))
        
        let multiplier = 1.0 / CGRectGetWidth(menuContainerView.bounds)
        let offset = scrollView.contentOffset.x * multiplier
        let fraction = 1.0 - offset
        menuContainerView.layer.transform = transformForFraction(fraction)
        menuContainerView.alpha = fraction
        
        if let detailViewController = detailViewController {
            if let rotatingView = detailViewController.hamburgerView {
                rotatingView.rotate(fraction)
            }
        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let menuOffset = CGRectGetWidth(menuContainerView.bounds)
        showingMenu = !CGPointEqualToPoint(CGPoint(x: menuOffset, y: 0), scrollView.contentOffset)
    }

}
