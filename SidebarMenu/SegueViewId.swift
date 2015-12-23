//
//  SegueViewId.swift
//  SidebarMenu
//
//  Created by kbs on 12/22/15.
//  Copyright © 2015 AppCoda. All rights reserved.
//

import UIKit

class SegueViewId: NSString {
    
    
   class func segieIdString () -> NSString
    {
        
        if(Segue.SegueId.characters.count > 0)
        {
            return Segue.SegueId
        }
        return "sw_front"
    }

}
