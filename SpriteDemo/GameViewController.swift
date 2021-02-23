//
//  GameViewController.swift
//  SpriteDemo
//
//  Created by Funpodium on 2021/2/17.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if let view = self.view as! SKView? {
//            // Load the SKScene from 'GameScene.sks'
//            if let scene = SKScene(fileNamed: "GameScene") {
//                // Set the scale mode to scale to fit the window
//                scene.scaleMode = .aspectFill
//
//                // Present the scene
//                view.presentScene(scene)
//            }
//
//            view.ignoresSiblingOrder = true
//
//            view.showsFPS = true
//            view.showsNodeCount = true
//        }
        
        
        if let view = self.view as? SKView {
            if let scene = SKScene(fileNamed: "ElevatorJump"){
                scene.scaleMode = .aspectFill
//                scene.size = self.view.bounds.size
                
//                scene.size = UIScreen.main.bounds.size
//                scene.size = CGSize(width: 375, height: 818)
                print("scene.camera:",scene.camera, self.view.bounds.size, UIScreen.main.bounds.size)
                
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
        }
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("UIScreen.main.bounds.size:", UIScreen.main.bounds.size)
    }
    
    
    

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
