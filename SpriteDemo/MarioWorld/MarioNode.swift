//
//  MarioNode.swift
//  SpriteDemo
//
//  Created by Funpodium on 2021/2/20.
//

import UIKit
import SpriteKit

class MarioNode: SKSpriteNode {
    
    var walkSpeed: CGFloat = 3
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.normalTexture = SKTexture(imageNamed: "mario0")
    }
    
    
    func move( direct: DirectOptions) {
        
        var _speed: CGFloat = walkSpeed
        
        switch direct {
        case .Left:
            self.position.x += -_speed
            self.xScale = -abs(self.xScale)
            if self.action(forKey: "Walk") == nil {
                self.run(SKAction(named: "MarioWalk", duration: 0.5)!,withKey: "Walk")
            }
            
        case .Right:
            self.position.x += _speed
            self.xScale = abs(self.xScale)
            if self.action(forKey: "Walk") == nil {
                self.run(SKAction(named: "MarioWalk", duration: 0.5)!,withKey: "Walk")
            }
            
        case .RushLeft:
            self.position.x += -_speed * 3
            self.xScale = -abs(self.xScale)
            if self.action(forKey: "Walk") == nil {
                self.run(SKAction(named: "MarioWalk", duration: 0.5)!,withKey: "Walk")
            }
            
        case .RushRight:
            self.position.x += _speed * 3
            self.xScale = abs(self.xScale)
            if self.action(forKey: "Walk") == nil {
                self.run(SKAction(named: "MarioWalk", duration: 0.5)!,withKey: "Walk")
            }

        default:
            
            self.removeAction(forKey: "Walk")
            self.texture = self.normalTexture
            break
        }
        
    }
    
    func restore(){
        self.removeAction(forKey: "Walk")
        self.texture = self.normalTexture
    }
    
    
}
