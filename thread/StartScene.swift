//
//  CreateScene.swift
//  thread
//
//  Created by Petar Simonovic on 06/05/2021.
//

import Foundation
import SpriteKit

extension GameScene {
    
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
        self.addChild(seed)

        self.title = displayTitle()
        self.addChild(title)
   }
    
    func startGame () {
        
        removeTitle()
        setGravity()
        createCanyon()
        createOrb()
        startRocks()
        seed.physicsBody?.affectedByGravity = true
        
        isGameStarted = true

    }
    
    func startRocks() {
     
    let makeRock = SKAction.sequence([SKAction.run(addRock), SKAction.wait(forDuration: 0.1)])
      self.run(SKAction.repeatForever(makeRock))
        
    }
    
    func startFireFlies() {
        
    let makeFireFly = SKAction.sequence([SKAction.run(addFireFly), SKAction.wait(forDuration: 0.1)])
    self.run(SKAction.repeatForever(makeFireFly))
        
    }
    
    
    func restartGame() {
        
        print("Restarting!")
        self.removeAllChildren()
        self.removeAllActions()
        isDead = false
        isGameStarted = false
        score = 0
        nodeCount = 0
        acceleration = CGFloat(1)
        distance = CGFloat(0.0)
        createScene()
        
    }
    
    
}