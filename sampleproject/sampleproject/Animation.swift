
import UIKit

class Animation: UIViewController {
    
    var gravity : UIGravityBehavior!
    var scale : CGFloat = 2
    var angle : Double = 180
    var vw : UIView?
    override func viewDidLoad() {
        super.viewDidLoad()
        let frame1 = CGRect(x:20,y:20,width:45,height:45)
        vw = UIView(frame: frame1)
        vw?.backgroundColor = UIColor.black
        self.view.addSubview(vw!)
        

    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first! as UITouch
        let location = touch.location(in: self.view)
        UIView.animate(withDuration: 2.0, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            let scaleT = CGAffineTransform(scaleX: self.scale,y: self.scale)
            let rt = CGAffineTransform(
                rotationAngle: CGFloat(self.angle * M_PI / 180))
            self.vw?.transform = scaleT.concatenating(rt)
            self.angle = (self.angle == 90 ? 180 : 90)
            self.scale = (self.scale == 2 ? 3 : 2)
            self.vw?.center = location
            self.gravity.gravityDirection = CGVector(dx: 1.0,dy: 0)
            self.gravity = UIGravityBehavior(items : [self.vw!])
        }, completion: nil)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    

}
