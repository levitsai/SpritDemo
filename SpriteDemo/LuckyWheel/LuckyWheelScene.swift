//
//  LuckyWheelScene.swift
//  SpriteDemo
//
//  Created by Tsai I Lun on 2021/3/1.
//

import UIKit
import SpriteKit

struct MemberInfo: Hashable{
    var name: String
    var color: UIColor
}

class LuckWheelNode: SKShapeNode{

    override init() {
        super.init()
        self.customView()
    }
    
    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
        
        super.init(coder: aDecoder)
        self.customView()
    }
    
    func customView(){
        
        self.strokeColor = UIColor.clear
        self.isUserInteractionEnabled = true
        
        self.physicsBody = SKPhysicsBody()
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.allowsRotation = true
        self.physicsBody?.pinned = true
        self.physicsBody?.isDynamic = true
        
        var partions = ["A":1,
                        "B":3,
                        "C":6,
                        "D":2]
        var array = [MemberInfo]()
        
        partions.forEach { pairs in
            let color = UIColor(displayP3Red: CGFloat.random(in: 0.01...1), green: CGFloat.random(in: 0.01...1), blue: CGFloat.random(in: 0.01...1), alpha: 1)
            (0..<pairs.value).forEach { indeㄌ in
                array.append(MemberInfo(name: pairs.key, color: color))
            }
        }
        
//        var startArc: CGFloat = 0.0
        let arc = CGFloat( Double.pi*2 ) / CGFloat( array.count )
        
        let soccer = SKSpriteNode(imageNamed: "soccer")
        soccer.setScale(0.1)
        soccer.position = CGPoint(x: 200, y: 0)
        
        
        
        
//        soccer.physicsBody = SKPhysicsBody(texture: soccer.texture!, size: soccer.size)
        
        soccer.physicsBody = SKPhysicsBody(circleOfRadius: 15, center: CGPoint(x: 0, y: 0))
        
        soccer.physicsBody?.isDynamic = false
        soccer.physicsBody?.affectedByGravity = false
        soccer.physicsBody?.pinned = true
        soccer.physicsBody?.allowsRotation = false
        soccer.physicsBody?.usesPreciseCollisionDetection = true
        soccer.physicsBody?.friction = 0
        soccer.physicsBody?.categoryBitMask = 1
        soccer.physicsBody?.collisionBitMask = 0
        
        
        self.addChild(soccer)
        
        var pathes = [MemberInfo: CGMutablePath]()
        
        array.shuffled().enumerated().forEach { index, info in
            print(index, info, sin(arc*CGFloat(index) ))
            
            if pathes[info] == nil{
                pathes[info] = CGMutablePath()
            }
            
            var path = pathes[info]!
            path.move(to: CGPoint.zero)
            path.addArc(center: CGPoint.zero, radius: 200, startAngle: CGFloat( index )*arc, endAngle: CGFloat( index + 1 )*arc, clockwise: false)
            path.move(to: CGPoint.zero)
//            var node = SKShapeNode(path: path)
//            node.fillColor = info.color
//            node.zPosition = -1
//            self.addChild( node )
//
            let s = soccer.copy() as! SKNode
            s.position = CGPoint(x: 200*cos(arc*CGFloat(index+1)), y: 200*sin(arc*CGFloat(index+1)))
            
            
            print("soccer body:", s.physicsBody)
            
            
            self.addChild(s)
            
        }
        
        pathes.forEach { pairs in
            let node = SKShapeNode(path: pairs.value)
            node.fillColor = pairs.key.color
            node.zPosition = -1
            self.addChild( node )
        }
    }
    
    
    
    
    
}


class LuckyWheelScene: SKScene {
    
//    var wheel: LuckWheelNode! {
//        return self.childNode(withName: "LuckyWheelNode") as! LuckWheelNode
//    }
    
    var wheel: LuckWheelNode!
    
    var pin: SKSpriteNode {
        self.childNode(withName: "Pin") as! SKSpriteNode
    }

    
    var startBtn: SKLabelNode {
        self.childNode(withName: "Start") as! SKLabelNode
    }
    
    var stopBtn: SKLabelNode {
        self.childNode(withName: "Stop") as! SKLabelNode
    }

    
    override func sceneDidLoad() {
                
        self.wheel = LuckWheelNode(rect: CGRect(x: 0, y: 0, width: 200, height: 200))

        self.wheel.position = CGPoint.zero

        self.addChild( self.wheel )
        
        print(self.pin)

        self.pin.physicsBody?.usesPreciseCollisionDetection = true
        
        self.pin.constraints = [ SKConstraint.positionX(SKRange(constantValue: 0)),
                                 SKConstraint.positionY(SKRange(constantValue: 320)),
                                 SKConstraint.orient(to: CGPoint.zero, offset: SKRange(lowerLimit: CGFloat(Double.pi/2.5), upperLimit: CGFloat(Double.pi/2))),
        ]
    }
    
    
    
    override func didMove(to view: SKView) {
        
        self.view?.contentMode = .scaleAspectFill
        self.view?.isUserInteractionEnabled = true
        
        self.isUserInteractionEnabled = true
        
        self.startBtn.isUserInteractionEnabled = false
        self.stopBtn.isUserInteractionEnabled = false
        
//        print(self.wheel.frame)
//        print(self.wheel.calculateAccumulatedFrame())
//
//        self.wheel.position = CGPoint.zero
//        print(self.wheel.position)

        print( #fileID, #function, #line , self.physicsBody)
        
//        self.physicsWorld.
        
        
        print(self.pin.constraints)
        
        
        
        

        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(touches.first?.location(in: self), self.position, self.frame)
        
        guard let point = touches.first?.location(in: self) else {
            return
        }
        
        let node = self.atPoint(point)
        print(node.name)
        switch node.name {
        case "Start":
            
            
            let startAction = SKAction.rotate(byAngle: CGFloat(Double.pi)*2, duration: 1)
            startAction.timingMode = .easeIn
            
            var rotate = SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi)*2, duration: 1))
            
            
            
            let sequence = SKAction.sequence([
                startAction,
                rotate
            ])
            
            
            self.wheel.run(sequence)
            
        case "Stop":
            
            self.wheel.removeAllActions()
            
            let stopAction = SKAction.rotate(byAngle: CGFloat(Double.pi)*8, duration: 4)
            stopAction.timingMode = .easeOut
            
            
            
            
            let endSequence = SKAction.sequence([
                stopAction,
                SKAction.run {
                    print("end")
                }
                
//
//                SKAction.run {
//                    self.pin.run(SKAction.rotate(toAngle: CGFloat(Double.pi/2), duration: 10))
//                }

                
                
            ])
            
            
            
            
            self.wheel.run(endSequence)
            
            
            break
        default:
            break
        }
        
        
        
        
        
        
        
        
        
        
        
        
    }
    
}
