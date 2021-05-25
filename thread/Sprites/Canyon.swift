//
//  Canyon.swift
//  thread
//
//  Created by Petar Simonovic on 06/05/2021.
//

import Foundation
import SpriteKit

class Canyon {
    
//    func createCanyon() {
//        createGround()
//        createCeiling()
//    }
    
    func createFlames(_ width: Int, _ height: Int, _ name: String) -> SKSpriteNode {
        let flames = SKSpriteNode()
        flames.size = CGSize(width: width, height: height)
        flames.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: width, height: height))
        flames.physicsBody?.categoryBitMask = CollisionBitMask.canyonCategory
        flames.physicsBody?.collisionBitMask = CollisionBitMask.seedCategory
        flames.physicsBody?.contactTestBitMask = CollisionBitMask.seedCategory
        flames.physicsBody?.isDynamic = false
        flames.physicsBody?.affectedByGravity = false
        flames.name = name
        if let flameParticles = SKEmitterNode(fileNamed: "CanyonFire") {
            flameParticles.position = flames.position
            flames.addChild(flameParticles)
        }
        return flames
    }
    
}
