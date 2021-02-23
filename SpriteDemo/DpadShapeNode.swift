//
//  DpadShapeNode.swift
//  SpriteDemo
//
//  Created by Funpodium on 2021/2/20.
//

import UIKit
import SpriteKit

class BrickNode: SKSpriteNode {
    override var isUserInteractionEnabled: Bool {
        set {
            // ignore
        }
        get {
            return true
        }
    }
    
    override var focusBehavior: SKNodeFocusBehavior{
        set {
            // ignore
        }
        get {
            return .focusable
        }
    }
    
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        self.isUserInteractionEnabled = true
        
        print("self.focusBehavior:",self.focusBehavior.rawValue)
        
        self.focusBehavior = .focusable
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(#function)
    }
    
}


class DpadShapeNode: SKSpriteNode {
    
    var direction: DirectOptions = .UnKnown {
        didSet{
            switch self.direction {
            case .Left:
                self.texture = self.atlas.textureNamed("dpad.left.fill")
            case .Right:
                self.texture = self.atlas.textureNamed("dpad.right.fill")
            case .UnKnown:
                self.texture = self.atlas.textureNamed("dpad")
            default:
                self.texture = self.atlas.textureNamed("dpad")
            }
        }
    }
    
    let atlas: SKTextureAtlas
    
    required init?(coder aDecoder: NSCoder){
        self.atlas = SKTextureAtlas(dictionary: [
            "dpad" : UIImage(systemName: "dpad")!,
            "dpad.left.fill" : UIImage(systemName: "dpad.left.fill")!,
            "dpad.right.fill" : UIImage(systemName: "dpad.right.fill")!,
        ])
        
        super.init(coder: aDecoder)
        
        self.isUserInteractionEnabled = true
        self.texture = self.atlas.textureNamed("dpad")
        
    }
    
    private func check( touch: UITouch){
        let point = touch .location(in: self)
        
        if point.x > self.size.width/2 {
            self.direction = .Right
        } else {
            self.direction = .Left
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(#function)
        
        guard let point = touches.first else {
            return
        }
        self.check(touch: point)
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        print(#function)
        
        guard let point = touches.first else {
            return
        }
        self.check(touch: point)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        self.direction = .UnKnown
    }
    
}


class JumpButtonNode: SKSpriteNode {
    let atlas: SKTextureAtlas
    
    var jumped = false {
        didSet{
            if self.jumped {
                self.texture = self.atlas.textureNamed("rectangle.roundedbottom.fill")
            } else {
                self.texture = self.atlas.textureNamed("rectangle.roundedbottom")
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder){
        self.atlas = SKTextureAtlas(dictionary: [
            "rectangle.roundedbottom" : UIImage(systemName: "rectangle.roundedbottom"),
            "rectangle.roundedbottom.fill" : UIImage(systemName: "rectangle.roundedbottom.fill")
        ])
        
        super.init(coder: aDecoder)
        
        self.isUserInteractionEnabled = true
        self.texture = self.atlas.textureNamed("rectangle.roundedbottom")
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        print(#function)
        self.jumped = true
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        self.jumped = false
    }
    
}
