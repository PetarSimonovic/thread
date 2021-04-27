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
    var backgroundNode = 0
    var seed = SKSpriteNode()
    var repeatActionSeed = SKAction()
    
        
    
  //  let fabric = SKSpriteNode(color: .gray, size: CGSize(width: 200, height: 200))
    
    override func didMove(to view: SKView) {
        createScene()
        
        self.seed = createSeed()
        self.addChild(seed)
        let rotateSeed = SKAction.rotate(byAngle: CGFloat(-Double.pi), duration: 0.3)
        seed.run(SKAction.repeatForever(rotateSeed))
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        if isGameStarted == false {
            isGameStarted = true
            seed.physicsBody?.affectedByGravity = true
            seed.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            seed.physicsBody?.applyImpulse(CGVector(dx:0 ,dy: 20))
        } else {
            if isDead == false {
                seed.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                seed.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 20))
            }
        }
        

    }
    
    override func update (_ currentTime: TimeInterval) {
        
        if isGameStarted == true {
        createBackground()
         if isDead == false {
                enumerateChildNodes(withName: "background", using: ({
                    (node, error) in
                    let bg = node as! SKSpriteNode
                    bg.position = CGPoint(x: bg.position.x - 2, y: bg.position.y)
                    if bg.position.x <= -bg.size.width {
                        print(bg.position.x)
                        bg.removeFromParent()
                        self.backgroundNode -= 1
                      //  bg.position = CGPoint(x:bg.position.x + bg.size.width * 2, y: bg.position.y)
                    }
                }))
            }
        }
//
    }
    
    func createBackground() {
      let  element = Int.random(in: 1..<100)
        if element <= 9 && backgroundNode <= 8 {
            print(element)
        let background = SKSpriteNode(imageNamed: "background_\(element)")
                background.anchorPoint = CGPoint.init(x: 0, y: 0)
            let height = CGFloat(arc4random() % UInt32(CGFloat(self.frame.height)))
                background.position = CGPoint(x: CGFloat(1) * self.frame.width, y: height)
                background.name = "background"
              let randomScale = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
              background.setScale(randomScale)
            //background.zRotation = CGFloat(M_PI_4)
              self.addChild(background)
                backgroundNode += 1
          
            }
            
            
            
        }
    
    
    
    func createScene() {
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsBody?.categoryBitMask = CollisionBitMask.wallCategory
        self.physicsBody?.collisionBitMask = CollisionBitMask.seedCategory
        self.physicsBody?.contactTestBitMask = CollisionBitMask.seedCategory
        self.physicsBody?.isDynamic = false
        self.physicsBody?.affectedByGravity = false
//
        self.physicsWorld.contactDelegate = self
        self.backgroundColor = SKColor (red: 80.0/255.0, green: 192.0/255.0, blue: 203.0/255.0, alpha: 1.0)
   }

}


