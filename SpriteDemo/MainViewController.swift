//
//  MainViewController.swift
//  SpriteDemo
//
//  Created by Funpodium on 2021/2/19.
//

import UIKit
import SpriteKit

class MainViewController: UIViewController {

    @IBOutlet weak var elevatorJump: SKView!
    
    var elevatorJumpScene: ElevatorJumpScene {
        self.elevatorJump.scene as! ElevatorJumpScene
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func padTapAction(_ sender: UITapGestureRecognizer) {
        print(sender.location(in: sender.view))
        
        guard let _view = sender.view else {
            return
        }
        
        if sender.location(in: _view).x > _view.bounds.width/2{
            self.elevatorJumpScene.direction = .Right
        } else{
            self.elevatorJumpScene.direction = .Left
        }
    }
    
    @IBAction func padAction(_ sender: UIPanGestureRecognizer) {
//        print(sender.state.rawValue)
//        print(sender.translation(in: sender.view))
        print(sender.location(in: sender.view))
        
        guard let _view = sender.view else {
            return
        }
        
        switch sender.state {
        case .began, .changed:
            if sender.location(in: _view).x > _view.bounds.width/2{
                self.elevatorJumpScene.direction = .Right
            } else{
                self.elevatorJumpScene.direction = .Left
            }
        case .ended:
            self.elevatorJumpScene.direction = .UnKnown
        default:
            break
        }
        
        
        

        
        
        
    }
}
