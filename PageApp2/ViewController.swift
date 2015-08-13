//
//  ViewController.swift
//  PageApp2
//
//  Created by Calvin Cheng on 13/8/15.
//  Copyright © 2015 Hello HQ Pte. Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPageViewControllerDataSource {

    var pageController: UIPageViewController?
    var pageImages: NSArray!
    
    @IBAction func skipButtonTapped(sender: AnyObject) {
        
        let nextView: TheNextViewController = self.storyboard?.instantiateViewControllerWithIdentifier("TheNextViewController") as! TheNextViewController
        
        let appdelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        appdelegate.window!.rootViewController = nextView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        pageImages = NSArray(objects: "screen1", "screen2", "screen3")

        pageController = self.storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as? UIPageViewController
        pageController!.dataSource = self

        let startingViewController: ContentViewController = viewControllerAtIndex(0)!
        let viewControllers: NSArray = [startingViewController]
        pageController!.setViewControllers(viewControllers as? [UIViewController], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
    
        // Making our pageController show up in this view controller
        pageController!.view.frame = CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height - 100)
        self.addChildViewController(pageController!)
        self.view.addSubview(pageController!.view)
        pageController?.didMoveToParentViewController(self)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // convenience functions
    func viewControllerAtIndex(index: Int) -> ContentViewController? {
        
        // Check if the page being requested is outside the bounds of available pages by checking if
        // the index reference is zero or greater than the number of items in the pageContent array
//        if (pageImages.count == 0) || (index >= pageImages.count) {
//            return nil
//        }
        
        // if within bounds, let's load up our ContentViewController instance and return it
        let storyBoard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let dataViewController = storyBoard.instantiateViewControllerWithIdentifier("ContentViewController") as! ContentViewController
        dataViewController.imageFileName = pageImages[index] as! String
        dataViewController.pageIndex = index
        print("index")
        print(index)
        print(dataViewController.imageFileName)
        return dataViewController
    }
    
    func indexOfViewController(viewController: ContentViewController) -> Int {
        
        if let dataObject: AnyObject = viewController.imageFileName {
            return pageImages.indexOfObject(dataObject)
        } else {
            return NSNotFound
        }
        
    }

    // required methods
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        let viewController = viewController as! ContentViewController
        var index = viewController.pageIndex as Int
        
        print("2222", "\(index)")
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        
        index--
        
        return viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        let viewController = viewController as! ContentViewController
        var index = viewController.pageIndex as Int
        
        if index == NSNotFound {
            return nil
        }
        
        index++
        
        if index == pageImages.count {
            return nil
        }
        
        return viewControllerAtIndex(index)
    }

    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return pageImages.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
}

