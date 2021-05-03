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

    

    
        
    
  //  let fabric = SKSpriteNode(color: .gray, size: CGSize(width: 200, height: 200))
    
    override func didMove(to view: SKView) {
        //energyField()

        createScene()
        
      

      //  seed.speed = 1
       // seed.run(SKAction.repeatForever(rotateSeed))
      //  decelerate()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        flight = true
        if isGameStarted == false {
            removeTitle()
            setGravity()
            let makeRock = SKAction.sequence([SKAction.run(createCanyon), SKAction.wait(forDuration: 0.1)])
          self.run(SKAction.repeatForever(makeRock))
            let seedTorque = SKAction.applyTorque(CGFloat(0.04), duration: 0.1)
            seed.run(SKAction.repeatForever(seedTorque))
            isGameStarted = true
            seed.physicsBody?.affectedByGravity = true
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
//            print(acceleration)
//            print(seed.position)
            if flight == true {
              seed.physicsBody?.velocity = CGVector(dx: -0.0, dy: 0.1)
               seed.physicsBody?.applyImpulse(CGVector(dx: -0, dy: 0.2))
                seed.physicsBody?.applyTorque(CGFloat(0.003))
                seed.physicsBody?.applyForce(CGVector(dx: 0, dy: 3))
                }
  


                enumerateChildNodes(withName: "rock", using: ({
                    (node, error) in
                    let rock = node as! SKSpriteNode
                    rock.position = CGPoint(x: rock.position.x - 2, y: rock.position.y)
                    if rock.position.x <= -rock.size.width {
                        //print(bg.position.x)
                        rock.removeFromParent()
                        self.nodeCount -= 1
                      //  bg.position = CGPoint(x:bg.position.x + bg.size.width * 2, y: bg.position.y)
                        self.distance += 0.001
                        print(self.distance)
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
        self.addChild(title)
   }

}


