//
//  GameScene.swift
//  thread
//
//  Created by Petar Simonovic on 22/04/2021.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var isGameStarted: Bool = false
    var isDead: Bool = false
    
   // SOUND: let coinSound = SKAction.playSoundFileNamed("CoinSound.mp3", waitFor Completion: false)
    
    var score: Int = 0
    var scoreLbl = SKLabelNode()
    var highscoreLbl = SKLabelNode()
    var taptoplayLbl = SKLabelNode()
    var restartBtn = SKSpriteNode()
    var pauseBtn = SKSpriteNode()
    var logoImg = SKSpriteNode()
    var wallPair = SKNode()
    var moveAndRemove = SKAction()
    
        
    
  //  let fabric = SKSpriteNode(color: .gray, size: CGSize(width: 200, height: 200))
    
    override func didMove(to view: SKView) {
    }
    
    override func touchesBegan(_ touches: Set, with event: UIEvent?){
        
    }
    
    override func update (_ currentTime: TimeInterval) {
        
    }
  
}
