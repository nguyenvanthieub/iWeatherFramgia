//
//  ViewController.swift
//  iWeather
//
//  Created by Văn Tiến Tú on 6/28/16.
//  Copyright © 2016 vantientu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    @IBOutlet weak var labelCity: UILabel!
    @IBOutlet weak var pageController: UIPageControl!
    var arrControllers: NSArray!
    var pageViewController: UIPageViewController!
    var pageIndex: Int!
    var identifies = ["TodayViewController", "EverydayViewController", "EveryHourViewController", "FactoriesLocationViewController"]
//    private(set) lazy var orderedViewControllers: [UIViewController] = {
//        // The view controllers will be shown in this order
//        return [self.viewControllerAtIndex(0),
//                self.viewControllerAtIndex(1),
//                self.viewControllerAtIndex(2),
//                self.viewControllerAtIndex(3)]
//        }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        let loginManager = LoginManager()
//        loginManager.doSigninWithEmail("", password: "");
        let todayVC = self.storyboard?.instantiateViewControllerWithIdentifier("TodayViewController") as! TodayViewController
        let everydayVC = self.storyboard?.instantiateViewControllerWithIdentifier("EverydayViewController") as! EverydayViewController
        let everyHourVC = self.storyboard?.instantiateViewControllerWithIdentifier("EveryHourViewController") as! EveryHourViewController
        let factoriesVC = self.storyboard?.instantiateViewControllerWithIdentifier("FactoriesLocationViewController") as! FactoriesLocationViewController
        self.arrControllers = NSArray(objects: todayVC, everydayVC, everyHourVC, factoriesVC)
        
        self.pageIndex = 0 as Int
        self.view.backgroundColor = UIColor.blueColor()
        self.pageController.numberOfPages = identifies.count as Int
        if let vc = self.storyboard?.instantiateViewControllerWithIdentifier("PageViewController")  {
            self.pageViewController = vc as! UIPageViewController
            self.pageViewController.dataSource = self;
            self.pageViewController.delegate = self
            self.pageViewController.setViewControllers([self.viewControllerAtIndex(0)!], direction: UIPageViewControllerNavigationDirection.Forward, animated: true, completion: nil)
            self.pageViewController.view.frame = CGRectMake(0, self.labelCity.frame.size.height + self.labelCity.bounds.size.height + 20, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height - 30 - 21 - 37 * 2)
            self.addChildViewController(self.pageViewController)
            self.view.addSubview(self.pageViewController.view)
            self.pageViewController.didMoveToParentViewController(self)
        }
    }
    //MARK: - array view controlles
    //MARK: - Return view controller
    func viewControllerAtIndex(index: Int) -> UIViewController? {
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("\(self.identifies[index])")
        return vc
    }
    // MARK: - Page viewcontroller data sources
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        if let index: Int = self.identifies.indexOf(viewController.restorationIdentifier!) {
            if index > 0 {
                return self.viewControllerAtIndex(index + 1)
            }
        }
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        if let index: Int = self.identifies.indexOf(viewController.restorationIdentifier!) {
            if index < self.identifies.count - 1 {
                return self.viewControllerAtIndex(index + 1)
            }
        }
        return nil
    }

    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return self.identifies.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }

}

