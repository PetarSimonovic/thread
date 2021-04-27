//
//  GameElements.swift
//  thread
//
//  Created by Petar Simonovic on 23/04/2021.
//

import SpriteKit

struct CollisionBitMask {
    static let seedCategory:UInt32 = 0x1 << 0
    static let wallCategory:UInt32 = 0x1 << 1
    static let loopCategory:UInt32 = 0x1 << 2
    static let groundCategory:UInt32 = 0x1 << 3
}

extension GameScene {
    
    func createSeed() -> SKSpriteNode {
        // Assign image and position
        let seed = SKSpriteNode(imageNamed: "seed")
        seed.size = CGSize(width: 30, height: 30)
        seed.position = CGPoint(x: self.frame.midX, y:self.frame.midY)
        
        // Asign physics
        seed.physicsBody = SKPhysicsBody(circleOfRadius: seed.size.width/2)
        seed.physicsBody?.linearDamping = 1.1
        seed.physicsBody?.restitution = 0
        
        // Add collision masks
        
        seed.physicsBody?.categoryBitMask = CollisionBitMask.seedCategory
        seed.physicsBody?.collisionBitMask = CollisionBitMask.wallCategory
        seed.physicsBody?.contactTestBitMask = CollisionBitMask.wallCategory | CollisionBitMask.loopCategory
        
        seed.physicsBody?.affectedByGravity = true
        seed.physicsBody?.isDynamic = true
    
        return seed
    
        
    }
    
}

