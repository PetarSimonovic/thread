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
        setGravity()
        energyField()

        createScene()
        
        self.seed = createSeed()
        self.addChild(seed)
      //  let rotateSeed = SKAction.rotate(byAngle: CGFloat(-Double.pi), duration: 0.3)
      //  seed.speed = 1
       // seed.run(SKAction.repeatForever(rotateSeed))
      //  decelerate()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        if isGameStarted == false {
            isGameStarted = true
            seed.physicsBody?.affectedByGravity = true
           // seed.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            seed.physicsBody?.applyImpulse(CGVector(dx:0 ,dy: 0))
        } else {
            if isDead == false {
                seed.physicsBody?.velocity = CGVector(dx: 1, dy: 0.5)
           // seed.speed = 5
                seed.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 0.5))
              seed.physicsBody?.applyTorque(CGFloat(0.0001))
                seed.physicsBody?.applyForce(CGVector(dx: 0.2, dy: 0.2))
             //   accelerate()
            // seed.run(SKAction.repeatForever(seedTorque))
//                let value = seed.physicsBody!.velocity.dy * 200
//                let rotate = SKAction.rotate(byAngle: value, duration: 0.1)
//
//                    seed.run(rotate)
            let rotate = SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 0.3)
            seed.run(rotate)
            }
        }
        

    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        removeAction(forKey: "seedFlight")
    }
//
    override func update (_ currentTime: TimeInterval) {
        
        if isGameStarted == true {
        createCanyon()
         if isDead == false {
                enumerateChildNodes(withName: "rock", using: ({
                    (node, error) in
                    let bg = node as! SKSpriteNode
                    bg.position = CGPoint(x: bg.position.x - 2, y: bg.position.y)
                    if bg.position.x <= -bg.size.width {
                        print(bg.position.x)
                        bg.removeFromParent()
                        self.nodeCount -= 1
                      //  bg.position = CGPoint(x:bg.position.x + bg.size.width * 2, y: bg.position.y)
                    }
                }))
            let value = seed.physicsBody!.velocity.dy * 0.003
            seed.physicsBody?.applyTorque(CGFloat(0.0001))

                let rotate = SKAction.rotate(byAngle: value, duration: 0.3)

                seed.run(rotate)
            }
        }
//
    }
    

    
    
    
    func createScene() {
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsBody?.categoryBitMask = CollisionBitMask.rockCategory
        self.physicsBody?.collisionBitMask = CollisionBitMask.seedCategory
        self.physicsBody?.contactTestBitMask = CollisionBitMask.seedCategory
        self.physicsBody?.isDynamic = false
        self.physicsBody?.affectedByGravity = false
//
        self.physicsWorld.contactDelegate = self
        self.backgroundColor = SKColor (red: 80.0/255.0, green: 192.0/255.0, blue: 203.0/255.0, alpha: 1.0)
   }

}


