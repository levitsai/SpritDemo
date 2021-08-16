//
//  MainViewController.swift
//  SpriteDemo
//
//  Created by Funpodium on 2021/2/19.
//

import UIKit
import SpriteKit

class MainViewController: UIViewController {

//    @IBOutlet weak var elevatorJump: SKView!
//    
//    var elevatorJumpScene: MarioWorldScene {
//        self.elevatorJump.scene as! MarioWorldScene
//    }
    
    var sceneName: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let _sceneName = self.sceneName, let scene = SKScene(fileNamed: _sceneName) {
            
            scene.scaleMode = .aspectFit
            
            if let _skView = self.view as? SKView {
                _skView.presentScene(scene)
                
                if let sceneView = scene.view {
                    sceneView.contentMode = .scaleAspectFill
                    sceneView.isMultipleTouchEnabled = true
                    sceneView.isExclusiveTouch = false
                    sceneView.isUserInteractionEnabled = true
                    
                    sceneView.showsFPS = true
                    sceneView.showsDrawCount = true
                    sceneView.showsNodeCount = true

                }
            }
        }
    }
    

    func loadingScene( name: String) {
        self.sceneName = name
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

        
        
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask { .landscapeRight }

}
