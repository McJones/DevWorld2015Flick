//
//  ViewController.swift
//  Flick
//
//  Created by Tim Nugent on 31/08/2015.
//  Copyright (c) 2015 Tim Nugent. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var theBox: UIView!
    var animator : UIDynamicAnimator?
    var attachment : UIAttachmentBehavior?
    var push : UIPushBehavior?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func panAbout(sender: AnyObject) {
        let gesture = sender as! UIPanGestureRecognizer
        
        let location = gesture.locationInView(self.view)
        let boxLocation = gesture.locationInView(self.theBox)
        
        switch gesture.state
        {
        case UIGestureRecognizerState.Began:
            self.animator?.removeAllBehaviors()
            
            let offset = UIOffset(horizontal: boxLocation.x - CGRectGetMidX(self.theBox.bounds), vertical: boxLocation.y - CGRectGetMidY(self.theBox.bounds))
            
            self.attachment = UIAttachmentBehavior(item: self.theBox, offsetFromCenter: offset, attachedToAnchor: location)
            self.animator?.addBehavior(attachment!)
            
        case .Ended:
            self.animator?.removeBehavior(self.attachment)
            
            let velocity = gesture.velocityInView(self.view)
            
            let magnitude = CGFloat(sqrtf(Float(velocity.x * velocity.x) + Float(velocity.y * velocity.y)))
            
            push = UIPushBehavior(items: [self.theBox], mode: UIPushBehaviorMode.Instantaneous)
            push!.pushDirection = CGVector(dx: velocity.x, dy: velocity.y)
            push!.magnitude = magnitude / 50
            
            self.animator?.addBehavior(push)
            
        default:
            self.attachment?.anchorPoint = gesture.locationInView(self.view)
        }
    }
}

