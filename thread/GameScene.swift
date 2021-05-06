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
    var rockNode = 0
    var seed = SKSpriteNode()
    var title = SKSpriteNode()
    var repeatActionSeed = SKAction()
    var acceleration = CGFloat(1)
    var nodeCount = 0
    var isRight : Bool = false
    var isLeft : Bool = false
    var distance = CGFloat(0.0)
    var flight = false
    var difficulty = 4

    

    
        
    
  //  let fabric = SKSpriteNode(color: .gray, size: CGSize(width: 200, height: 200))
    
    override func didMove(to view: SKView) {
        //energyField()

        createScene()
        
      

      //  seed.speed = 1
       // seed.run(SKAction.repeatForever(rotateSeed))
      //  decelerate()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        if isGameStarted == false {
            startGame()
        }
        if isDead == false {
            seedThrust()
            flight = true
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        flight = false
    }
////
    override func update (_ currentTime: TimeInterval) {
        
        if isGameStarted == true {
            self.distance += 0.001
            throwOrb()

//            print(acceleration)
//            print(seed.position)
            if flight == true {
         //     seed.physicsBody?.velocity = CGVector(dx: -0.0, dy: 1)
            //    seed.physicsBody?.applyTorque(CGFloat(0.008))
                seedFlight()
                }
            
            moveRocks()
            moveFireFlies()
            checkDeath()
            
//
    }
        
    }
    
    
    
    


}


