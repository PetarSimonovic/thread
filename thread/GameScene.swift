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
//            print(acceleration)
//            print(seed.position)
            if flight == true {
         //     seed.physicsBody?.velocity = CGVector(dx: -0.0, dy: 1)
            //    seed.physicsBody?.applyTorque(CGFloat(0.008))
                seedFlight()
                self.throwBolo()
                }
            
            
  


                enumerateChildNodes(withName: "rock", using: ({
                    (node, error) in
                    let rock = node as! SKSpriteNode
                    rock.position = CGPoint(x: rock.position.x - 1.5, y: rock.position.y)
                    if rock.position.x <= -rock.size.width {
                        //print(bg.position.x)
                        rock.removeFromParent()
                        self.nodeCount -= 1
                      //  bg.position = CGPoint(x:bg.position.x + bg.size.width * 2, y: bg.position.y)
                        print("Distance")
                  //      print(self.distance)
                    //    print("rock position \(rock.position)")
                    }
                }))
            
            enumerateChildNodes(withName: "firefly", using: ({
                (node, error) in
                let firefly = node as! SKSpriteNode
                firefly.position = CGPoint(x: firefly.position.x - 0.5, y: firefly.position.y)
              //  print("Firefly position: \(firefly.position)")
        
                if firefly.position.x <= -self.frame.width * 2 {
                    firefly.removeFromParent()
                    print("Firefly removed")
                }
            }))
            
            if seed.position.x <= -seed.size.width || seed.position.y < 0 {
                isDead = true
                seed.removeFromParent()
            }
            
            if isDead == true && nodeCount == 0 {
               gameOver()
               restartGame()
            }
                
            
//
    }
        
    }
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        let firstBody = contact.bodyA
        let secondBody = contact.bodyB
        
        print(firstBody)
        print(secondBody)
 
                
        if firstBody.categoryBitMask == CollisionBitMask.seedCategory && secondBody.categoryBitMask == CollisionBitMask.canyonCategory || firstBody.categoryBitMask == CollisionBitMask.seedCategory && secondBody.categoryBitMask == CollisionBitMask.canyonCategory  {
            isDead = true
            if let explosion = SKEmitterNode(fileNamed: "Explosion") {
              explosion.position = seed.position
              addChild(explosion)
            }
            seed.removeFromParent()
            }
        
            

        if firstBody.categoryBitMask == CollisionBitMask.seedCategory && secondBody.categoryBitMask == CollisionBitMask.fireflyCategory  {
              disperseFireFlies()
            if secondBody.node?.position != nil {
              secondBody.node?.removeFromParent()
                createBolo()

            }
            
        }
        if firstBody.categoryBitMask == CollisionBitMask.fireflyCategory && secondBody.categoryBitMask == CollisionBitMask.seedCategory  {
              disperseFireFlies()
//            if secondBody.node?.position != nil {
//              secondBody.node?.removeFromParent()
//            }
            
        }
        }
            

    
    
    


}


