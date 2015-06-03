//
//  QiPullMenu.swift
//  QiPullMenu
//
//  Created by qi on 15/6/3.
//  Copyright (c) 2015年 im.qihf. All rights reserved.
//

import UIKit
class QiPullMenu:NSObject,UIScrollViewDelegate,UIGestureRecognizerDelegate {
    let bar=UIToolbar()
    let roundCoverView=UIView()
    weak var scrollView:UIScrollView!{
        didSet{
            self.oldDelegate=scrollView.delegate
            self.scrollView.delegate=self
        }
    }
    weak var oldDelegate:UIScrollViewDelegate?
    
    override init() {
        super.init()
    }
    
    convenience init(scrollView:UIScrollView) {
        self.init()
        self.scrollView=scrollView
        self.oldDelegate=scrollView.delegate
        self.scrollView.delegate=self
        
        bar.frame=CGRectMake(0,-44,scrollView.frame.size.width,44)
        bar.barTintColor=UIColor.greenColor()
        let item1=UIBarButtonItem(title: "hah1", style: UIBarButtonItemStyle.Done, target: nil, action: nil)
        let item2=UIBarButtonItem(title: "hah2", style: UIBarButtonItemStyle.Done, target: nil, action: nil)
        let item3=UIBarButtonItem(title: "hah3", style: UIBarButtonItemStyle.Done, target: nil, action: nil)
        let item4=UIBarButtonItem(title: "hah4", style: UIBarButtonItemStyle.Done, target: nil, action: nil)

        bar.items=[item1,item2,item3,item4]
        
        var coverViewRect=CGRect
        roundCoverView
        
        scrollView.superview!.addSubview(bar)
        let gestureRecognizer=UIPanGestureRecognizer(target: self, action: "onSwip:")
        gestureRecognizer.delegate=self
        scrollView.addGestureRecognizer(gestureRecognizer)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
//        println("y:\(scrollView.contentOffset.y)")
        var rect=bar.frame
        if scrollView.contentOffset.y>=0{
            rect.origin.y = -44
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                self.bar.frame=rect
            })
        }
        else{
            var y=0 - 44 - scrollView.contentOffset.y
            if y>0 {
                y=0
            }
            rect.origin.y=y
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                self.bar.frame=rect
            })
        }
    }
    
    func scrollViewDidScrollToTop(scrollView: UIScrollView) {
    }
    
    // MARK: event
    func onSwip( recgonizer:UIPanGestureRecognizer) {
        
        switch recgonizer.state{
        case UIGestureRecognizerState.Began:
            beginX=recgonizer.locationInView(scrollView.superview)
        case UIGestureRecognizerState.Changed:
            println("changed")
            
        case UIGestureRecognizerState.Ended:
            println("Ended")
            
        default:
            return
            
        }
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool{
        return true
    }
}