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
            removeTitle()
            setGravity()
            createCanyon()
            let makeRock = SKAction.sequence([SKAction.run(addRock), SKAction.wait(forDuration: 0.1)])
          self.run(SKAction.repeatForever(makeRock))
            let makeFireFly = SKAction.sequence([SKAction.run(addFireFly), SKAction.wait(forDuration: 0.1)])
          self.run(SKAction.repeatForever(makeFireFly))
            isGameStarted = true
            seed.physicsBody?.affectedByGravity = true
            
        } else if isDead == false {
            print("Jolt!")
            seed.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 0.25))
            seed.physicsBody?.applyTorque(CGFloat(0.003))
            flight = true

            

        }
           // seed.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
         //   seed.physicsBody?.applyImpulse(CGVector(dx:0, dy: 0))
//        } else {
//            if isDead == false {
//                        //OLD CODE
//                seed.physicsBody?.velocity = CGVector(dx: -0, dy: 0)

//                for touch in (touches) {
//                    print(touch)
//                    }
//                    let location = touch.location(in: self)
//                    if (location.x < self.size.width / 2) {
//                            isLeft = true
//                        seed.physicsBody?.velocity = CGVector(dx: -0.1, dy: 0.1)
//
//                        seed.physicsBody?.applyImpulse(CGVector(dx: -0, dy: 0.2))
//                        seed.physicsBody?.applyTorque(CGFloat(0.003))
//                        seed.physicsBody?.applyForce(CGVector(dx: -1, dy: 1.5))
//                        }
//
//                    if (location.x > self.size.width/2){
//                            isRight = true
//                        seed.physicsBody?.velocity = CGVector(dx: 0.3, dy: 0.3)
//                        seed.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 0.2))
//                        seed.physicsBody?.applyTorque(CGFloat(-0.003))
//                        seed.physicsBody?.applyForce(CGVector(dx: 1, dy: 1.5))
//                        }
//                    }

//            }
//        }
        

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
                seed.physicsBody?.applyForce(CGVector(dx: 0, dy: 0.5))
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
            }
            
        }
        if firstBody.categoryBitMask == CollisionBitMask.fireflyCategory && secondBody.categoryBitMask == CollisionBitMask.seedCategory  {
              disperseFireFlies()
//            if secondBody.node?.position != nil {
//              secondBody.node?.removeFromParent()
            createBolo()
//            }
            
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
        self.seed = createSeed()
        self.title = displayTitle()
        self.addChild(seed)
        createBolo()

        self.addChild(title)
   }

}


