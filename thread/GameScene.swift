//
//  GameScene.swift
//  thread
//
//  Created by Petar Simonovic on 22/04/2021.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var isGameStarted: Bool = true
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
    
        
    
  //  let fabric = SKSpriteNode(color: .gray, size: CGSize(width: 200, height: 200))
    
    override func didMove(to view: SKView) {
        createScene()
    }
//
//    override func touchesBegan(_ touches: Set, with event: UIEvent?){
//
//    }
    
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
//        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
//        self.physicsBody?.categoryBitMask = CollisionBitMask.groundCategory
//        self.physicsBody?.collisionBitMask = CollisionBitMask.needleCategory
//        self.physicsBody?.contactTestBitMask = CollisionBitMask.needleCategory
//        self.physicsBody?.isDynamic = false
//        self.physicsBody?.affectedByGravity = false
//
//        self.physicsWorld.contactDelegate = self
        self.backgroundColor = SKColor (red: 80.0/255.0, green: 192.0/255.0, blue: 203.0/255.0, alpha: 1.0)

//        background.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
//
//        addChild(background)


//

//
   }

}


