

import UIKit
import Foundation

private let g_secs = 120.0

class FLApplication: UIApplication
{
    var idle_timer : dispatch_cancelable_closure?
     var window: UIWindow?
    override init()
    {
        super.init()
        reset_idle_timer()
    }
    
    override func sendEvent( event: UIEvent )
    {
        super.sendEvent( event )
        
        if let all_touches = event.allTouches() {
            if ( all_touches.count > 0 ) {               
                
                let touchesSet=all_touches as NSSet
                let touch=touchesSet.anyObject() as? UITouch
                let phase = touch!.phase
                if phase == UITouchPhase.Began {
                    reset_idle_timer()
                }
            }
        }
    }
    
    private func reset_idle_timer()
    {
        cancel_delay( idle_timer )
        idle_timer = delay( g_secs ) { self.idle_timer_exceeded() }
    }
    
    func idle_timer_exceeded()
    {
        print( "Ring ----------------------- Do some Idle Work!" )
        let mainStoryboardIpad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewControlleripad : UIViewController = mainStoryboardIpad.instantiateViewControllerWithIdentifier("Login_ID") as! LoginViewController
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window?.rootViewController = initialViewControlleripad
        self.window?.makeKeyAndVisible()

        reset_idle_timer()
    }
}



typealias dispatch_cancelable_closure = (cancel : Bool) -> Void

func delay(time:NSTimeInterval, closure:()->Void) ->  dispatch_cancelable_closure? {
    
    func dispatch_later(clsr:()->Void) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(time * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), clsr)
    }
    
    var closure:dispatch_block_t? = closure
    var cancelableClosure:dispatch_cancelable_closure?
    
    let delayedClosure:dispatch_cancelable_closure = { cancel in
        if closure != nil {
            if (cancel == false) {
                dispatch_async(dispatch_get_main_queue(), closure!);
            }
        }
        closure = nil
        cancelableClosure = nil
    }
    
    cancelableClosure = delayedClosure
    
    dispatch_later {
        if let delayedClosure = cancelableClosure {
            delayedClosure(cancel: false)
        }
    }
    
    return cancelableClosure;
}

func cancel_delay(closure:dispatch_cancelable_closure?) {
    
    if closure != nil {
        closure!(cancel: true)
    }
}