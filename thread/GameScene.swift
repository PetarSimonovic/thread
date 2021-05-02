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
    var repeatActionSeed = SKAction()
    var acceleration = CGFloat(1)
    var nodeCount = 0
    
        
    
  //  let fabric = SKSpriteNode(color: .gray, size: CGSize(width: 200, height: 200))
    
    override func didMove(to view: SKView) {
        //energyField()

        createScene()
        
        self.seed = createSeed()
        self.addChild(seed)
        
        let makeRock = SKAction.sequence([SKAction.run(createCanyon), SKAction.wait(forDuration: 0.1)])
        
        self.run(SKAction.repeatForever(makeRock))
    

      //  seed.speed = 1
       // seed.run(SKAction.repeatForever(rotateSeed))
      //  decelerate()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        if isGameStarted == false {
            setGravity()
            isGameStarted = true
            seed.physicsBody?.affectedByGravity = true
           // seed.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            seed.physicsBody?.applyImpulse(CGVector(dx:0 ,dy: 0))
        } else {
            if isDead == false {
                seed.physicsBody?.velocity = CGVector(dx: 0.5, dy: 0.5)
           // seed.speed = 5
              seed.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 0.5))
              seed.physicsBody?.applyTorque(CGFloat(-0.006))
                seed.physicsBody?.applyForce(CGVector(dx: 0.5, dy: 1.5))
             //   accelerate()
            // seed.run(SKAction.repeatForever(seedTorque))
//                let value = seed.physicsBody!.velocity.dy * 200
//                let rotate = SKAction.rotate(byAngle: value, duration: 0.1)
//
//                    seed.run(rotate)
          //  let rotate = SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 0.3)
           // seed.run(rotate)
            }
        }
        

    }
    
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//    }
////
    override func update (_ currentTime: TimeInterval) {
        
        if isGameStarted == true {

                enumerateChildNodes(withName: "rock", using: ({
                    (node, error) in
                    let rock = node as! SKSpriteNode
                    rock.position = CGPoint(x: rock.position.x - 2, y: rock.position.y)
                    if rock.position.x <= -rock.size.width {
                        //print(bg.position.x)
                        rock.removeFromParent()
                        self.nodeCount -= 1
                      //  bg.position = CGPoint(x:bg.position.x + bg.size.width * 2, y: bg.position.y)
                    }
                }))
            if seed.position.x < 0 || seed.position.y < 0 {
                isDead = true
            }
            
            if isDead == true && self.nodeCount == 0 {
                    gameOver()
                }
                
            
//
    }
        
    }
    

    
    
    
    func createScene() {
//        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
//        self.physicsBody?.categoryBitMask = CollisionBitMask.rockCategory
//        self.physicsBody?.collisionBitMask = CollisionBitMask.seedCategory
//        self.physicsBody?.contactTestBitMask = CollisionBitMask.seedCategory
//        self.physicsBody?.isDynamic = false
//        self.physicsBody?.affectedByGravity = false
//
        self.physicsWorld.contactDelegate = self
        self.backgroundColor = SKColor (red: 80.0/255.0, green: 192.0/255.0, blue: 203.0/255.0, alpha: 1.0)
   }

}


