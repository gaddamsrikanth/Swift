
import UIKit

class SixthViewController: UIPageViewController, UIPageViewControllerDataSource
{
    var pageViewController : UIPageViewController?
    var pageTitles : Array<String> = ["God vs Man", "Cool Breeze", "Fire Sky"]
    //var pageImages : Array<String> = ["page1.png", "page2.png", "page3.png"]
    var currentIndex : Int = 0
    var pageControl: UIPageControl!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController!.dataSource = self
        
        pageControl = UIPageControl()
        pageControl.numberOfPages = self.pageTitles.count
        pageControl.frame = CGRect(x:20,y:60,width:100,height:50)
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .black
        pageViewController?.view.addSubview(pageControl)
        
        let startingViewController: InstructionView = viewControllerAtIndex(index: 0)!
        let viewControllers = [startingViewController]
        pageViewController!.setViewControllers(viewControllers , direction: .forward, animated: true, completion: nil)
        
        addChildViewController(pageViewController!)
        view.addSubview(pageViewController!.view)
        pageViewController!.didMove(toParentViewController: self)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?
    {
        var index = (viewController as! InstructionView).pageIndex
        
        if (index == 0) || (index == NSNotFound) {
            index = 0
        }else{
            index -= 1
        }
        return viewControllerAtIndex(index: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?
    {
        var index = (viewController as! InstructionView).pageIndex
        
//        if index == NSNotFound {
//            return nil
//        }
        index += 1
        if(index == self.pageTitles.count){
           return nil
        }
        self.pageControl.currentPage = index
        return viewControllerAtIndex(index: index)
    }
    
    func viewControllerAtIndex(index: Int) -> InstructionView?
    {
//        if self.pageTitles.count == 0
//        {
//            return nil
//        }
        
        // Create a new view controller and pass suitable data.
        let pageContentViewController = InstructionView()
//        pageContentViewController.imageFile = pageImages[index]
        pageContentViewController.titleText = pageTitles[index]+" "+String(index)
        pageContentViewController.pageIndex = index
        currentIndex = index
        print(index)
        
        return pageContentViewController
    }
    
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int
    {
        
        return self.pageTitles.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int
    {
        return 0
    }
    
}
