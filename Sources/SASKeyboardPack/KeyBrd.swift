//
//  KeyBrd.swift
//  EV Quiz
//
//  Created by Anup Sukumaran on 03/10/18.
//  Copyright © 2018 WIS. All rights reserved.
//

import UIKit
import SASLogger

public class KeyBrd {
    
    public var increasedInset_Height: CGFloat = 120
    public static var keyBrdSize: CGSize?
    public init() {}
    
    public func scrollAdjustment(_ scrollView: UIScrollView, top: CGFloat) {
        let systemVersion = UIDevice.current.systemVersion
        Logger.p("systemVersion = \(systemVersion)")
        Logger.p("DoublesystemVersion = \(Double(systemVersion) ?? 0.0)")
        
        if systemVersion.compare("11.0", options: .numeric) == .orderedAscending {
            //For below ios 11 like ios 10 and such...
            scrollView.contentInset = UIEdgeInsets(top: top, left: 0.0, bottom: 0.0, right: 0.0)
        }
        
    }
    
    public func regKBNotific(_ scrollView: UIScrollView, _ inset_Height: CGFloat){
        
        increasedInset_Height = inset_Height
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { (notification) in
                self.keyBrdWasShown_V2(notification as NSNotification, scrollView)

        }
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { (notification) in
                self.keyBrdWillBeHidden_V2(notification as NSNotification, scrollView)
        }
        
    }
    
    
    public func keyBrdWasShown_V2(_ notification: NSNotification,_ scrollView: UIScrollView) {
        
        let info: NSDictionary = notification.userInfo! as NSDictionary
        guard let keyBrd = (info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size else {return}
        KeyBrd.keyBrdSize = keyBrd
        scrollView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyBrd.height + increasedInset_Height, right: 0.0)
        
    }
    
    public func keyBrdWillBeHidden_V2(_ notification: NSNotification, _ scrollView: UIScrollView ) {
        
        let info: NSDictionary = notification.userInfo! as NSDictionary
        guard let keyBrd = (info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size else {return}
        KeyBrd.keyBrdSize = keyBrd
        scrollView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: -keyBrd.height, right: 0.0)
        scrollView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        
    }
    
    public func deregisterKBNotific(){
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
 
    
}

extension KeyBrd {
    //MARK:
    public func adjustTextViewWithKeyBrd(_ textView: UITextView, _ scrollView: UIScrollView, _ viewToAdjust: UIView) {
        var contentOffset: CGPoint = scrollView.contentOffset
        let systemVersion = UIDevice.current.systemVersion
        if systemVersion.compare("11.0", options: .numeric) == .orderedAscending {
           contentOffset.y = textView.frame.height + 20 + (KeyBrd.keyBrdSize?.height ?? 0.0)
        } else {
            contentOffset.y = textView.frame.height + 20
        }
        
        
        scrollView.setContentOffset(contentOffset, animated: true)
        
       
        
    }
}
