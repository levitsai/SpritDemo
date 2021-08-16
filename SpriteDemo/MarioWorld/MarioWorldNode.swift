//
//  DpadShapeNode.swift
//  SpriteDemo
//
//  Created by Funpodium on 2021/2/20.
//

import UIKit
import SpriteKit

class DpadShapeNode: SKSpriteNode {
    
    var direction: DirectOptions = .UnKnown {
        didSet{
            switch self.direction {
            case .Left, .RushLeft:
                self.texture = self.atlas.textureNamed("dpad.left.fill")
            case .Right, .RushRight:
                self.texture = self.atlas.textureNamed("dpad.right.fill")
            case .UnKnown:
                self.texture = self.atlas.textureNamed("dpad")
            default:
                self.texture = self.atlas.textureNamed("dpad")
            }
        }
    }
    
    let atlas: SKTextureAtlas = {
        SKTextureAtlas(dictionary: [
            "dpad" : UIImage(systemName: "dpad")!,
            "dpad.left.fill" : UIImage(systemName: "dpad.left.fill")!,
            "dpad.right.fill" : UIImage(systemName: "dpad.right.fill")!,
        ])
    }()
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        
        self.isUserInteractionEnabled = true
        self.texture = self.atlas.textureNamed("dpad")
        
//        print( #fileID, #line, self.size.width)
        
    }
    
    private func check( touch: UITouch, count: Int?){
//        print("count:",count)
        let point = touch .location(in: self)
        print( #fileID, #line, self.size.width, point.x)
        if point.x > 0 {
            if count == 1{
                self.direction = .Right
            } else{
                self.direction = .RushRight
            }
        } else {
            if count == 1 {
                self.direction = .Left
            } else {
                self.direction = .RushLeft
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        print( #fileID, #line, self.size.width)
        guard let point = touches.first else {
            return
        }
        self.check(touch: point, count: touches.first?.tapCount)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        guard let point = touches.first else {
            return
        }
        self.check(touch: point, count: touches.first?.tapCount)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        self.direction = .UnKnown
    }
    
}

class JumpButtonNode: SKSpriteNode {
    let atlas: SKTextureAtlas = {
        SKTextureAtlas(dictionary: [
            "rectangle.roundedbottom" : UIImage(systemName: "rectangle.roundedbottom")!,
            "rectangle.roundedbottom.fill" : UIImage(systemName: "rectangle.roundedbottom.fill")!
        ])
    }()
    
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
        super.init(coder: aDecoder)
        
        self.isUserInteractionEnabled = true
//        self.jumped = false
        self.texture = self.atlas.textureNamed("rectangle.roundedbottom")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.jumped = true
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.jumped = false
    }
    
}

protocol Interactable {
    func hitAction()
    func stamp()
}

extension Interactable{
    func hitAction(){}
    func stamp(){}
}



class BrickNode: SKSpriteNode {
//    override var isUserInteractionEnabled: Bool {
//        set {
//            // ignore
//        }
//        get {
//            return true
//        }
//    }
//
//    override var focusBehavior: SKNodeFocusBehavior{
//        set {
//            // ignore
//        }
//        get {
//            return .focusable
//        }
//    }
//
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
////        print(#function)
//    }
    
}

extension BrickNode: Interactable{
    func hitAction() {
        
    }
}


class QuestionBoxNode: SKSpriteNode {
}

extension QuestionBoxNode: Interactable{
    func hitAction() {
        let coin = SKSpriteNode()
        coin.position = CGPoint(x: self.position.x, y: self.position.y)
//        coin.setScale(self.sc)
        
        coin.xScale = xScale
        coin.yScale = yScale
        
        coin.size = self.frame.size
        coin.zPosition = self.zPosition - 1
        
        self.parent?.addChild(coin)
        
        coin.run(
            SKAction.sequence([
                SKAction(named: "Coin")!,
                SKAction.run {
                    coin.removeFromParent()
                }
            ])
        )
        
    }
}
