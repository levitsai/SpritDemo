//
//  MarioNode.swift
//  SpriteDemo
//
//  Created by Funpodium on 2021/2/20.
//

import UIKit
import SpriteKit

class MarioNode: SKSpriteNode {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.normalTexture = SKTexture(imageNamed: "mario0")
    }
    
    
    func move( direct: DirectOptions) {
        switch direct {
        case .Left:
            self.position.x -= 3
            self.xScale = -abs(self.xScale)
            if self.action(forKey: "Walk") == nil {
                self.run(SKAction(named: "MarioWalk", duration: 0.5)!,withKey: "Walk")
            }
            
        case .Right:
            self.position.x += 3
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
    
}
