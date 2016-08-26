//
//  ViewController.swift
//  PageViewControllerDemo
//
//  Created by Shilpa S on 26/08/16.
//  Copyright © 2016 Shilpa S. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var pageViewController : UIPageViewController!
    var currentIndex : Int = -1
    lazy var controllers : [UIViewController] = {
        let collectionController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("CollectionViewController")
        let collectionController2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("CollectionViewController")
        let collectionController3 = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("CollectionViewController")
        return [collectionController,collectionController2,collectionController3]
    }()
    
    subscript(index : Int) -> UIViewController {
        return controllers[index]
    }
    
    func after(viewController : UIViewController) -> UIViewController? {
        if let index = self.controllers.indexOf(viewController) {
            if (index + 1) < self.controllers.count {
                return self[index+1]
            }
        }
       return nil
    }
    func before(viewController : UIViewController) -> UIViewController? {
        if let index = self.controllers.indexOf(viewController) {
            if index > 0 {
                return self[index-1]
            }
        }
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pageViewController = UIPageViewController(transitionStyle: UIPageViewControllerTransitionStyle.Scroll, navigationOrientation: UIPageViewControllerNavigationOrientation.Horizontal, options: nil);
        
            self.addChildViewController(self.pageViewController)
        self.pageViewController.view.frame = self.view.bounds
        self.pageViewController.view.backgroundColor = UIColor.blueColor()
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMoveToParentViewController(self)
        
     self.pageViewController.setViewControllers([self[0]], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
        
        self.pageViewController.dataSource = self
//        self.pageViewController.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController : UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    //Data source methods
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        return self.after(viewController)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
            return self.before(viewController)
    }
    
}

