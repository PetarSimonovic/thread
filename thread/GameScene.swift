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
    var highScore = loadScores()
    var highscoreLbl = SKLabelNode(fontNamed: "Futura-Medium")   
    var scoreLabel = SKLabelNode(fontNamed: "Futura-Medium")    
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
    var distance = Double(0.0)
    var flight = false
    var difficulty = 1
    var thrownOrb: Bool = false
    var touch = UITouch()
    var xForce = 0
    var orb: Int = 0

    override func didMove(to view: SKView) {
        createScene()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        if isGameStarted == false {
            startGame()
        }
        if isDead == false {
            for touch in touches {
                let location = touch.location(in: self)
                
                if(location.x < self.size.width/2){
                    isLeft = true
                    isRight = false
                    print("Left")
                }
                
                if(location.x > self.size.width/2){
                    isRight = true
                    isLeft = false
                    print("Right")
                }

                if touch.tapCount == 2 {
                    print("DoubleTap")
                    print(orb)
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
        checkDeath()
        if isDead == false {
            scoreLabel.text = "Score: \(Double(round(1000*distance)/1000)) | High: \(highScore)"
        }

        
        if isGameStarted == true {
            distance += 0.001
            difficulty = Int(floor(distance)) * 2
          //  print(difficulty)
          //  throwOrb()
            if flight == true {
                seedFlight()
            }
            
            moveOrb()
            removeOrbs()
            moveRocks()
            moveFireFlies()
        }
        
    }

}


