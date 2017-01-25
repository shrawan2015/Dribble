//
//  ViewController.swift
//  ContactSync
//
//  Created by ShrawanKumar Sharma on 24/01/17.
//  Copyright © 2017 com.ContactSync. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CAAnimationDelegate  {

    @IBOutlet weak var connectContacts: UIView!
    @IBOutlet weak var switchButton: UISwitch!
    fileprivate var shape: CAShapeLayer! = CAShapeLayer()
    @IBOutlet weak var shapeOutlet: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        contactLayer()
        addShapeLayer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func changeSwtichAction(_ sender: Any) {
        animateView()
    }
   
    
    func animateView(){
        
        let scaleAnimation:CABasicAnimation
        if(switchButton.isOn){
         scaleAnimation = animateKeyPath("transform.scale",
                                                              fromValue: 1,
                                                              toValue: 0.01,
                                                              timing:kCAMediaTimingFunctionEaseIn)
        }else{
            scaleAnimation = animateKeyPath("transform.scale",
                                            fromValue: 0.01,
                                            toValue: 1,
                                            timing:kCAMediaTimingFunctionEaseIn)
        }
        
        shape.add(scaleAnimation, forKey:"scaleUp")
        connectContacts?.layer.insertSublayer(shape, at: 0)
        connectContacts?.layer.masksToBounds = true

    }
    
    
    
    
    fileprivate func animateKeyPath(_ keyPath: String, fromValue from: CGFloat?, toValue to: CGFloat, timing timingFunction: String) -> CABasicAnimation {
        
        let animation:CABasicAnimation = CABasicAnimation(keyPath: keyPath)
        animation.fromValue             = from
        animation.toValue               = to
        animation.repeatCount           = 1
        animation.timingFunction        = CAMediaTimingFunction(name: timingFunction)
        animation.isRemovedOnCompletion = false
        animation.fillMode              = kCAFillModeForwards
        animation.duration              = 1.0
        animation.delegate              = self
        return animation
    }
    
    
    func addShapeLayer() {
        let x = switchButton.center.x
        let y = switchButton.center.y
        let radius = self.view.frame.size.width//(sqrt(x*x + y*y))
        shape.frame = CGRect(x:  switchButton.center.x - radius - 2 - connectContacts.frame.origin.x + 5 , y: switchButton.center.y - radius - 2 + 8, width: ( radius * 2 )  , height:  radius * 2   )
        shape.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        shape.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: radius * 2, height:radius * 2 )).cgPath
        shape.fillColor     = UIColor.red.cgColor
        shape.masksToBounds = true
        shape.transform =  switchButton.isOn ? CATransform3DMakeScale(1.0, 1.0, 1.0) : CATransform3DMakeScale(0.0001, 0.0001, 0.0001)
        self.connectContacts.layer.insertSublayer(shape, at: 0)
        
    }
    
    func contactLayer() {
        connectContacts.layer.borderColor = UIColor.blue.cgColor
        connectContacts.layer.borderWidth = 1
        connectContacts?.layer.masksToBounds = true
    }


}

