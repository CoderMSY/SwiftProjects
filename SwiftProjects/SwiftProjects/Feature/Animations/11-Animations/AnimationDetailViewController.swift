//
//  AnimationDetailViewController.swift
//  SwiftProjects
//
//  Created by SimonMiao on 2022/1/14.
//

import UIKit

class AnimationDetailViewController: MSYBaseViewController {

    var barTitle = ""
    
    fileprivate let duration = 2.0
    fileprivate let delay = 0.2
    fileprivate let scale = 1.2
    
    fileprivate var animateView: UIView!
    
    lazy var startBtn: UIButton = {
        var startBtn = UIButton(type: .custom)
        startBtn.setTitle("animation", for: .normal)
        startBtn.setTitleColor(.blue, for: .normal)
        startBtn.addTarget(self, action: #selector(startBtnClicked(sender:)), for: .touchUpInside)
        startBtn.layer.borderColor = UIColor.blue.cgColor
        startBtn.layer.borderWidth = 0.5
        startBtn.layer.cornerRadius = 5.0
        
        return startBtn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavigationBar()
        setUpRect()
    }
    

    fileprivate func setUpNavigationBar() {
        navigationController?.navigationBar.topItem?.title = barTitle
    }

    fileprivate func setUpRect() {
        startBtn.frame = CGRect(x: (view.bounds.width - 110.0) / 2, y: view.bounds.height - 120, width: 110.0, height: 40.0)
        view.addSubview(startBtn);
        
        if barTitle == "BezierCurve Position" {
            animateView = drawCircleView()
        } else if barTitle == "View Fade In" {
            animateView = UIImageView(image: UIImage(named: "whatsapp"))
            animateView.frame = generalFrame
            animateView.center = generalCenter
        } else {
            animateView = drawRectView(.red, frame: generalFrame, center: generalCenter)
        }
        
        view.addSubview(animateView)
    }
    
    @objc func startBtnClicked(sender: UIButton) {
        switch barTitle {
        case "2-Color":
            changeColor(UIColor.green)
        case "Simple 2D Rotation":
            rotateView(Double.pi)
        case "Multicolor":
            multiColor(UIColor.green, UIColor.blue)
        case "Multi Point Position":
            multiPosition(CGPoint(x: animateView.frame.origin.x, y: 100),
                          CGPoint(x: animateView.frame.origin.x, y: 350))
        case "BezierCurve Position":
            var controlPoint1 = self.animateView.center
            controlPoint1.y -= 125.0
            var controlPoint2 = controlPoint1
            controlPoint2.x += 40.0
            controlPoint2.y -= 125.0
            var endPoint = self.animateView.center;
            endPoint.x += 75.0
            curvePath(endPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
        case "Color and Frame Change":
            let currentFrame = self.animateView.frame
            let firstFrame = currentFrame.insetBy(dx: -30, dy: -50)
            let secondFrame = firstFrame.insetBy(dx: 10, dy: 15)
            let thirdFrame = secondFrame.insetBy(dx: -15, dy: -20)
            colorFrameChange(firstFrame, secondFrame, thirdFrame, UIColor.orange, UIColor.yellow, UIColor.green)
        case "View Fade In":
            viewFadeIn()
        case "Pop":
            Pop()
        default:
            let alert = makeAlert("Alert", message: "The animation not implemented yet", actionTitle: "OK")
            self.present(alert, animated: true, completion: nil)
            break
        }
    }
}

extension AnimationDetailViewController {
    fileprivate func changeColor(_ color: UIColor) {
        UIView.animate(withDuration: self.duration, animations: {
            self.animateView.backgroundColor = color
        }, completion: nil)
    }
    fileprivate func rotateView(_ angel: Double) {
        UIView.animate(withDuration: duration, delay: delay, options: [.repeat], animations: {
            self.animateView.transform = CGAffineTransform(rotationAngle: CGFloat(angel))
        }, completion: nil)
    }
    fileprivate func multiColor(_ firstColor: UIColor, _ secondColor: UIColor) {
        UIView.animate(withDuration: duration) {
            self.animateView.backgroundColor = firstColor
        } completion: { finished in
            self.changeColor(secondColor)
        }
    }
    
    fileprivate func multiPosition(_ firstPos: CGPoint, _ secondPos: CGPoint) {
        func simplePosition(_ pos: CGPoint) {
            UIView.animate(withDuration: self.duration, animations: {
                self.animateView.frame.origin = pos
            }, completion: nil)
        }
        
        UIView.animate(withDuration: self.duration, animations: {
            self.animateView.frame.origin = firstPos
        }, completion: { finished in
            simplePosition(secondPos)
        })
    }
    
    fileprivate func curvePath(_ endPoint: CGPoint, controlPoint1: CGPoint, controlPoint2: CGPoint) {
        let path = UIBezierPath()
        path.move(to: self.animateView.center)
        
        path.addCurve(to: endPoint,
                      controlPoint1: controlPoint1,
                      controlPoint2: controlPoint2)
        
        // create a new CAKeyframeAnimation that animates the objects position
        let anim = CAKeyframeAnimation(keyPath: "position")
        
        // set the animations path to our bezier curve
        anim.path = path.cgPath
        
        // set some more parameters for the animation
        anim.duration = self.duration
        
        // add the animation to the squares 'layer' property
        self.animateView.layer.add(anim, forKey: "animate position along path")
        self.animateView.center = endPoint
    }
    
    fileprivate func colorFrameChange(_ firstFrame: CGRect, _ secondFrame: CGRect, _ thirdFrame: CGRect,
                                      _ firstColor: UIColor, _ secondColor: UIColor, _ thirdColor: UIColor) {
        UIView.animate(withDuration: self.duration, animations: {
            self.animateView.backgroundColor = firstColor
            self.animateView.frame = firstFrame
        }, completion: { finished in
            UIView.animate(withDuration: self.duration, animations: {
                self.animateView.backgroundColor = secondColor
                self.animateView.frame = secondFrame
            }, completion: { finished in
                UIView.animate(withDuration: self.duration, animations: {
                    self.animateView.backgroundColor = thirdColor
                    self.animateView.frame = thirdFrame
                }, completion: nil)
            })
        })
    }
    
    fileprivate func viewFadeIn() {
        let secondView = UIImageView(image: UIImage(named: "facebook"))
        secondView.frame = self.animateView.frame
        secondView.alpha = 0.0
        
        view.insertSubview(secondView, aboveSubview: self.animateView)
        
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseOut, animations: {
            secondView.alpha = 1.0
            self.animateView.alpha = 0.0
        }, completion: nil)
    }
    
    fileprivate func Pop() {
        UIView.animate(withDuration: duration / 4,
                       animations: {
            self.animateView.transform = CGAffineTransform(scaleX: CGFloat(self.scale), y: CGFloat(self.scale))
        }, completion: { finished in
            UIView.animate(withDuration: self.duration / 4, animations: {
                self.animateView.transform = CGAffineTransform.identity
            })
        })
    }
}
