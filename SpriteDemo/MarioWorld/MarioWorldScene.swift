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
    static let RushLeft = DirectOptions(rawValue: 1 << 3)
    static let RushRight = DirectOptions(rawValue: 1 << 4)
}


class MarioWorldScene: SKScene {
    
    var direction: DirectOptions = .UnKnown
    
    var touchPoint: CGPoint?
    
    var mario: MarioNode {
        return self.childNode(withName: "Mario") as! MarioNode
    }
    
    override var camera: SKCameraNode?{
        set{
            
        }get{
            return self.childNode(withName: "camera") as! SKCameraNode
        }
    }
    
    var floor: SKSpriteNode {
        return self.childNode(withName: "Floor") as! SKSpriteNode
    }
    
    var dPad: DpadShapeNode {
        return self.camera?.childNode(withName: "DPad") as! DpadShapeNode
    }
    
    var jumpNode: JumpButtonNode{
        return self.camera?.childNode(withName: "Jump") as! JumpButtonNode
    }
    
    
    var floors = [SKSpriteNode]()
    
    
    
    override var isUserInteractionEnabled: Bool {
        set {
            // ignore
        }
        get {
            return true
        }
    }
    
    override func sceneDidLoad() {
        
        self.physicsWorld.contactDelegate = self
        
        self.scaleMode = .aspectFit
        
//        let camera = SKCameraNode()
//        self.addChild(camera)
//        self.camera = camera
//        self.camera?.setScale(1)
        
        


        
        print(#fileID, #function, #line , self.mario)
        print(#fileID, #function, #line , self.view)
        
        
        print(#fileID, #function, #line , self.mario.physicsBody?.mass)
        print(#fileID, #function, #line , self.mario.physicsBody?.area)
        print(#fileID, #function, #line ,  (self.mario.physicsBody?.mass ?? 0 ) / (self.mario.physicsBody?.area ?? 0) )
        print(#fileID, #function, #line , self.mario.physicsBody?.density)

        print(#fileID, #function, #line ,self.dPad)
        print(#fileID, #function, #line , self.view?.isExclusiveTouch)

        


        
//        self.floors.append(self.floor.copy() as! SKSpriteNode)
//        self.floors.append(self.floor)
//        self.floors.append(self.floor.copy() as! SKSpriteNode)
//
//        self.scene?.addChild(self.floors[0])
//        self.scene?.addChild(self.floors[2])
//
//        self.floors[0].position = self.floors[1].position
//        self.floors[2].position = self.floors[1].position
//
//        self.floors[0].position.x -= self.floors[1].size.width
//        self.floors[2].position.x += self.floors[1].size.width
        
        
    }
    
    override func didMove(to view: SKView) {
    
        self.view?.ignoresSiblingOrder = true
        self.view?.showsFPS = true
        self.view?.showsNodeCount = true
        
        
//        print( #fileID, #function, #line , self.camera?.isUserInteractionEnabled)
        self.camera?.isUserInteractionEnabled = true
        
        print( #fileID, #function, #line , self.camera?.frame)
        
        print( #function, #line ,self.view)
        
        print( #fileID, #function, #line , self.view?.isMultipleTouchEnabled)
        print( #fileID, #function, #line , self.view?.isExclusiveTouch)
        
        
        
        self.view?.isMultipleTouchEnabled = true
        self.view?.isExclusiveTouch = false
//        self.view?.delay
        
        
        self.camera?.isUserInteractionEnabled = true
        self.camera?.position = self.mario.position
        
    }
    
//    func checkFloor(){
//
//        if self.mario.position.x > self.floors[1].position.x, abs(self.mario.position.x - self.floors[1].position.x) > abs(self.mario.position.x - self.floors[2].position.x) {
//
//            let node = self.floors.removeFirst()
//            node.position.x = self.floors.last!.position.x + self.floors.last!.size.width
//            self.floors.append(node)
//
//        } else if self.mario.position.x < self.floors[1].position.x, abs(self.mario.position.x - self.floors[1].position.x) > abs(self.mario.position.x - self.floors[0].position.x){
//
//            let node = self.floors.removeLast()
//            node.position.x = self.floors.first!.position.x - self.floors.first!.size.width
//            self.floors.insert(node, at: 0)
//        }
//
//        self.floors.forEach{ $0.position.y = -250}
//
//
//
//
//
//    }
    
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
        
        
        
        
        
        self.mario.move(direct: self.dPad.direction)
        
        if self.jumpNode.jumped {
                    self.mario.run(SKAction.group([
            //            SKAction.applyForce(CGVector(dx: 0, dy: 1100), duration: 0.5)
                        SKAction.applyImpulse(CGVector(dx: 0, dy: 1000), duration: 0.2)
                    ]))
            self.jumpNode.jumped = false
        }
        
        
//        self.checkFloor()
    }
    
    
    override func didFinishUpdate(){
        self.camera?.position = CGPoint(x: self.mario.position.x, y: self.mario.position.y + 200)
    }
    
}


extension MarioWorldScene: SKPhysicsContactDelegate{
    func didBegin(_ contact: SKPhysicsContact) {
//        print("---------------")
//        print(#fileID, #line,contact)
        
        switch (contact.bodyA.node, contact.bodyB.node) {
        case let( mario, node) as (MarioNode, Interactable):
            switch contact.contactNormal.dy {
            case 0...CGFloat( INT8_MAX ):
                node.hitAction()
                break
            case CGFloat(INT8_MIN)..<0:
                node.stamp()
                break
            default:
                break
            }
            
            break
            
        case let( node, mario) as ( Interactable, MarioNode) :
            switch contact.contactNormal.dy {
            case 1:
                node.stamp()
                break
            case -1:
                node.hitAction()
                break
            default:
                break
            }

            break
        default:
            break
        }
        
//        print(#fileID, #line, contact.contactPoint)
//        print(#fileID, #line, contact.contactNormal)

//        print(#fileID, #line, contact.bodyA.friction)
//        print(#fileID, #line, contact.bodyB.friction)
        
        
        
        
        
        
        
        
        
    }
    
    func didEnd(_ contact: SKPhysicsContact){
    }
}
