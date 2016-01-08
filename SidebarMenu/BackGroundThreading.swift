//
//  BackGroundThreading.swift
//  SidebarMenu
//
//  Created by kbs on 1/4/16.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit

class BackGroundThreading: NSObject {

    
    //method for multi threading  -----------
    
   class func backgroundThread(delay: Double = 0.0, background: (() -> Void)? = nil, completion: (() -> Void)? = nil) {
        dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_USER_INITIATED.rawValue), 0)) {
            if(background != nil){ background!(); }
            let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC)))
            dispatch_after(popTime, dispatch_get_main_queue()) {
                if(completion != nil){ completion!(); }
            }
        }
    }
    
    
}
