//
//  GameScene.swift
//  thread
//
//  Created by Petar Simonovic on 22/04/2021.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var title = SKSpriteNode()

    
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
    var moveAndRemove = SKAction()
    var rockNode = 0
    var seed = SKSpriteNode()
    var repeatActionSeed = SKAction()
    var acceleration = CGFloat(1)
    var nodeCount = 0
    var isRight : Bool = false
    var isLeft : Bool = false
    var distance = CGFloat(0.0)
    var flight = false
    var difficulty = 4
    var thrownOrb: Bool = false
    var touch = UITouch()

    override func didMove(to view: SKView) {
        createScene()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        if isGameStarted == false {
            startGame()
        }
        if isDead == false {
            for touch in touches {
                if touch.tapCount == 2 {
                    print("DoubleTap")
                    throwOrb()
                }
                else if touch.tapCount == 1 {
                    print("Single Tap")
                    seedThrust()
                    flight = true
                }
            }
            
            
          
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        flight = false
    }
    
    override func update (_ currentTime: TimeInterval) {
        
        if isGameStarted == true {
            self.distance += 0.001
          //  throwOrb()
            
            if flight == true {
                seedFlight()
            }
            
            moveOrb()
            moveRocks()
            moveFireFlies()
            checkDeath()
        }
        
    }

}


