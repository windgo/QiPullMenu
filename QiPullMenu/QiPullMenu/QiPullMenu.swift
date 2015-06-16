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
        
        bar.frame=CGRectMake(0,-44,UIScreen.mainScreen().bounds.size.width,44)
        bar.barTintColor=UIColor.greenColor()
        let item1=UIBarButtonItem(title: "hah1", style: UIBarButtonItemStyle.Done, target: nil, action: nil)
        let flex1=UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        let item2=UIBarButtonItem(title: "hah2", style: UIBarButtonItemStyle.Done, target: nil, action: nil)
        let flex2=UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        let item3=UIBarButtonItem(title: "hah3", style: UIBarButtonItemStyle.Done, target: nil, action: nil)
        let flex3=UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        let item4=UIBarButtonItem(title: "hah4", style: UIBarButtonItemStyle.Done, target: nil, action: nil)

        bar.items=[item1,flex1,item2,flex2,item3,flex3,item4]
        scrollView.superview!.addSubview(bar)
        let gestureRecognizer=UIPanGestureRecognizer(target: self, action: "onSwip:")
        gestureRecognizer.delegate=self
        scrollView.addGestureRecognizer(gestureRecognizer)
        
        roundCoverView.frame=CGRectMake(UIScreen.mainScreen().bounds.size.width/2-22, -44, 44, 44)
        roundCoverView.backgroundColor=UIColor.orangeColor()
        roundCoverView.layer.cornerRadius=22
        roundCoverView.layer.masksToBounds=true
        
        self.scrollView.superview!.addSubview(roundCoverView)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        var rect=bar.frame

        if scrollView.contentOffset.y>=0{
            
            rect.origin.y = -44
            
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                self.bar.frame=rect
                var r=self.roundCoverView.frame
                r.origin.y=rect.origin.y
                self.roundCoverView.frame=r
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
                var r=self.roundCoverView.frame
                r.origin.y=rect.origin.y
                self.roundCoverView.frame=r
            })
        }
    }
    
    func scrollViewDidScrollToTop(scrollView: UIScrollView) {
    }
    
    
    var beginPoint:CGPoint?
    // MARK: event
    func onSwip( recgonizer:UIPanGestureRecognizer) {
        
        switch recgonizer.state{
        case UIGestureRecognizerState.Began:
            beginPoint=recgonizer.locationInView(scrollView.superview)
            var r=self.roundCoverView.frame
            r.origin.x=(UIScreen.mainScreen().bounds.width/2-22)
            self.roundCoverView.frame=r
            break
        case UIGestureRecognizerState.Changed:
            print("changed")
            let currentPoint=recgonizer.locationInView(scrollView.superview)
            var r=self.roundCoverView.frame
            r.origin.x=(UIScreen.mainScreen().bounds.width/2-22)+currentPoint.x-(beginPoint?.x)!
            self.roundCoverView.frame=r
        case UIGestureRecognizerState.Ended:
            print("Ended")
            beginPoint=nil
        default:
            return
            
        }
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool{
        return true
    }
}