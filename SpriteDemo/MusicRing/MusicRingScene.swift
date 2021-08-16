//
//  MusicRingScene.swift
//  SpriteDemo
//
//  Created by Tsai I Lun on 2021/2/27.
//

import UIKit
import SpriteKit

class CircleNode: SKShapeNode {
    
    static let radius: CGFloat = 50.0
    
    var hasTouched = false
    
    lazy var shrinkCircle: SKShapeNode = {
        let _shrinkCircle = SKShapeNode(circleOfRadius: CircleNode.radius)
        _shrinkCircle.setScale(2.5)
        _shrinkCircle.strokeColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        _shrinkCircle.zPosition = -1
        return _shrinkCircle
        
    }()
    
    
    lazy var goodZone: SKShapeNode = {
        var _basicNode = SKShapeNode(circleOfRadius: CircleNode.radius)
        _basicNode.setScale(0.7)
        _basicNode.fillColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        return _basicNode
    }()
    
    
    override init(){
        
        

        super.init()
//        self.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        
//        self.isUserInteractionEnabled = true
        
        self.isUserInteractionEnabled = false
        self.alpha = 0.5
        
        
        
        self.fillColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
        
        self.addChild(goodZone)

        self.addChild(shrinkCircle)
        
//        self.setScale( 0.5)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(#fileID, #line)
        
        guard  self.hasTouched == false else {
            return
        }
        
        hasTouched = true
        
        var prompt: String
        
        
        switch self.shrinkCircle.frame.size.width {
        case 0...self.goodZone.frame.size.width:
            prompt = "GOOD"
        case self.goodZone.frame.size.width...self.frame.size.width:
            prompt = "PERFECT"
        case self.frame.size.width...:
            prompt = "MISS"
        default:
            prompt = "MISS"
        }
        
        let label = SKLabelNode(text: prompt)
        
        self.addChild(label)
        
        let action = SKAction.sequence([
            SKAction.moveTo(y: 50, duration: 0.2),
            SKAction.run({
                self.removeFromParent()
            })
        ])

        label.run(action)
        
        
//        self.run(<#T##action: SKAction##SKAction#>)
        
        
        
//        self.removeFromParent()
        
        
    }
    
    func runAnimation(){
        
        
        let label = SKLabelNode(text: "MISS")

        let laction = SKAction.sequence([
            SKAction.moveTo(y: 50, duration: 0.2),
        ])

        
        
        let action = SKAction.sequence([
            
            SKAction.group([
                SKAction.scale(to: 0, duration: 2),
                SKAction.sequence([
                    SKAction.wait(forDuration: 0.4),
                    SKAction.run {
                        self.isUserInteractionEnabled = true
                        self.alpha = 1
                    },
                ])
            ]),
            SKAction.run( {
                self.addChild(label)
                label.run(laction)
            }),
            SKAction.wait(forDuration: laction.duration),
            SKAction.run({
                self.removeFromParent()
            })
        ])
        
        self.shrinkCircle.run(action)
    }
    
}












class MusicRingScene: SKScene {
    
    deinit {
        print(#file , #line)
    }
    
//    var zIndex = CGFloat(Int.max)
    
    var zIndex: CGFloat = 100000
    
    override func sceneDidLoad() {
    }
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] t in

            
            guard let `self` = self else {
                return
            }
            
            
            let c = CircleNode(circleOfRadius: CircleNode.radius)
            let x = CGFloat.random(in:  ( (-self.size.width + CircleNode.radius )/2)...((self.size.width - CircleNode.radius )/2)   )
            let y = CGFloat.random(in:  ( (-self.size.width + CircleNode.radius )/2)...((self.size.width - CircleNode.radius )/2)   )
            
            
            c.position = CGPoint(x: x, y: y)
            
            c.zPosition = self.zIndex
            self.zIndex -= 1
            
            self.addChild(c)
            c.runAnimation()
        }
        
        
        
        
        
    }
    
    
}
