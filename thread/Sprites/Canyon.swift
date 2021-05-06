//
//  Canyon.swift
//  thread
//
//  Created by Petar Simonovic on 06/05/2021.
//

import Foundation
import SpriteKit

extension GameScene {
    
    func createCanyon() {
        createGround()
        createCeiling()
    }
    
    func createGround() {
        let ground = SKSpriteNode()
        ground.size = CGSize(width: self.frame.width, height: 30)
        ground.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.frame.width, height: 30))
        ground.physicsBody?.categoryBitMask = CollisionBitMask.canyonCategory
        ground.physicsBody?.collisionBitMask = CollisionBitMask.seedCategory
        ground.physicsBody?.contactTestBitMask = CollisionBitMask.seedCategory
        ground.physicsBody?.isDynamic = false
        ground.physicsBody?.affectedByGravity = false
        ground.position = CGPoint(x: self.frame.width/2, y: -20)
        ground.name = "Ground"
        addChild(ground)
        if let groundParticles = SKEmitterNode(fileNamed: "CanyonFire") {
            groundParticles.position = ground.position
            addChild(groundParticles)
        }
    }
    
    func createCeiling() {
        let ceiling = SKSpriteNode()
        ceiling.size = CGSize(width: self.frame.width, height: 50)

        ceiling.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.frame.width, height: 30))
        ceiling.physicsBody?.categoryBitMask = CollisionBitMask.canyonCategory
        ceiling.physicsBody?.collisionBitMask = CollisionBitMask.seedCategory
        ceiling.physicsBody?.contactTestBitMask = CollisionBitMask.seedCategory
        ceiling.physicsBody?.isDynamic = false
        ceiling.physicsBody?.affectedByGravity = false
        ceiling.position = CGPoint(x: self.frame.width/2, y: self.frame.height - 20)
        addChild(ceiling)
        ceiling.name = "ceiling"
        if let groundParticles = SKEmitterNode(fileNamed: "CanyonFire") {
            groundParticles.position = ceiling.position
            addChild(groundParticles)
            groundParticles.particleRotation = 180.00
        }
    }
    
}
