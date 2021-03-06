//
//  ViewController.swift
//  Antfarm
//
//  Created by Ben Anding on 3/1/22.
//

import Cocoa
import SpriteKit

class ViewController: NSViewController {

    @IBOutlet var skView: SKView!
    lazy var window: NSWindow = self.view.window!
    override func viewDidLoad() {
        super.viewDidLoad()

        if let view = self.skView {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
}

