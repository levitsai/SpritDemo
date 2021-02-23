//
//  ElevatorJumpScene.swift
//  SpriteDemo
//
//  Created by Funpodium on 2021/2/18.
//

import UIKit
import SpriteKit

struct DirectOptions: OptionSet {
    let rawValue: UInt8
    
    static let UnKnown = DirectOptions(rawValue: 1 << 0)
    static let Left = DirectOptions(rawValue: 1 << 1)
    static let Right = DirectOptions(rawValue: 1 << 2)
}


class ElevatorJumpScene: SKScene {
    
    var direction: DirectOptions = .UnKnown
    
    var touchPoint: CGPoint?
    
    var mario: MarioNode {
        return self.childNode(withName: "Mario") as! MarioNode
    }
    
    var dPad: DpadShapeNode {
        return self.childNode(withName: "Floor")?.childNode(withName: "DPad") as! DpadShapeNode
    }
    
    var jumpNode: JumpButtonNode{
        return self.childNode(withName: "Floor")?.childNode(withName: "Jump") as! JumpButtonNode
    }
    
    override var isUserInteractionEnabled: Bool {
        set {
            // ignore
        }
        get {
            return true
        }
    }
    
    override func sceneDidLoad() {
        print(#fileID, #function, #line , self.mario)
        print(#fileID, #function, #line , self.view)
        
        self.physicsWorld.contactDelegate = self
        
        self.scaleMode = .aspectFit
        
        let camera = SKCameraNode()
        self.addChild(camera)
        self.camera = camera
        self.camera?.setScale(1)
        
        print(#fileID, #function, #line , self.mario.physicsBody?.mass)
        print(#fileID, #function, #line , self.mario.physicsBody?.area)
        print(#fileID, #function, #line ,  (self.mario.physicsBody?.mass ?? 0 ) / (self.mario.physicsBody?.area ?? 0) )
        print(#fileID, #function, #line , self.mario.physicsBody?.density)

        print("self.dPAd:",self.dPad)
        
        
        self.view?.isMultipleTouchEnabled = true
        
        
        
        print(#function, #line , self.view?.isExclusiveTouch)
        self.view?.isExclusiveTouch = false
//        self.camera?.position = self.mario.position
        
    }
    
    override func didMove(to view: SKView) {
    
        self.view?.ignoresSiblingOrder = true
        self.view?.showsFPS = true
        self.view?.showsNodeCount = true
        
        print( #fileID, #function, #line , self.camera?.frame)
        
        print(#function, #line ,self.view)
        
        print( #fileID, #function, #line , self.view?.isMultipleTouchEnabled)
        print( #fileID, #function, #line , self.view?.isExclusiveTouch)
        
        
        
        self.view?.isMultipleTouchEnabled = true
        self.view?.isExclusiveTouch = false
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            self.mario.run( SKAction.scale(by: 0.5, duration: 5) )
//            self.mario.run(SKAction.group([
//                SKAction.applyForce(CGVector(dx: 0, dy: 1500), duration: 2)
//            ]))

//            self.camera?.xScale = 0.2
//            self.camera?.yScale = 1.5
            
//            self.camera?.setScale(2)
//            print("Frame:", self.camera?.frame)
            
//            self.mario.run(
//            SKAction.moveTo(x: 500, duration: 10)
//            )
//
//
//            self.camera?.run(SKAction.moveTo(y: 2000, duration: 20) )
            
        }
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        
//        super.touchesBegan(touches, with: event)
//        
////        self.mario.run(SKAction.group([
//////            SKAction.applyForce(CGVector(dx: 0, dy: 1100), duration: 0.5)
////            SKAction.applyImpulse(CGVector(dx: 0, dy: 500), duration: 0.2)
////        ]))
//        
//        
//        self.touchPoint = touches.first?.location(in: self.view)
//    
//    }
//    
//    
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.touchPoint = nil
//    }
//    
//    
    override func update(_ currentTime: TimeInterval) {
//            switch self.direction {
//            case .Left:
//                self.mario.position.x -= 3
//            case .Right:
//            self.mario.position.x += 3
//            default:
//                break
//            }
        
        
//        self.camera?.position = self.mario.position
        
        self.mario.move(direct: self.dPad.direction)
        
        if self.jumpNode.jumped {
                    self.mario.run(SKAction.group([
            //            SKAction.applyForce(CGVector(dx: 0, dy: 1100), duration: 0.5)
                        SKAction.applyImpulse(CGVector(dx: 0, dy: 500), duration: 0.2)
                    ]))
            self.jumpNode.jumped = false
        }
    }
}


extension ElevatorJumpScene: SKPhysicsContactDelegate{
    func didBegin(_ contact: SKPhysicsContact) {
        print("---------------")
        print(contact)
        print(contact.bodyA)
        print(contact.bodyB)
        print(contact.contactPoint)
        print(contact.contactNormal)
        
    }
    
    func didEnd(_ contact: SKPhysicsContact){
    }
}
