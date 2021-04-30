//
//  GameViewController.swift
//  thread
//
//  Created by Petar Simonovic on 22/04/2021.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
        let scene = GameScene(size: view.bounds.size)
        let skView = view as! SKView
        skView.preferredFramesPerSecond = 50
        skView.showsFPS = true
       skView.showsPhysics = true // Shows collision mask
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .resizeFill
        skView.presentScene(scene)

  }
    
}
        
