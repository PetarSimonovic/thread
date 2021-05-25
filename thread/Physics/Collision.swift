//
//  GameElements.swift
//  thread
//
//  Created by Petar Simonovic on 23/04/2021.
//

import SpriteKit

struct CollisionBitMask {
    static let seedCategory:UInt32 = 0x1 << 0
    static let rockCategory:UInt32 = 0x1 << 1
    static let canyonCategory:UInt32 = 0x1 << 2
    static let fireflyCategory:UInt32 = 0x1 << 3
    static let orbCategory:UInt32 = 0x1 << 4
    static let orbitCategory:UInt32 = 0x1 << 5


}

extension GameScene {
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        let firstBody = contact.bodyA
        let secondBody = contact.bodyB
        
      
        checkSeedCanyon(firstBody, secondBody, contact)
        checkSeedRock(firstBody, secondBody)
        checkSeedFirefly(firstBody, secondBody, contact)
        checkOrbRock(firstBody, secondBody, contact)
       // checkOrbCanyon(firstBody, secondBody, contact)

 
                
//            }
            
        }
    
    func checkSeedCanyon(_ firstBody: SKPhysicsBody, _ secondBody: SKPhysicsBody, _ contact: SKPhysicsContact) {
        
        if firstBody.categoryBitMask == CollisionBitMask.seedCategory && secondBody.categoryBitMask == CollisionBitMask.canyonCategory || firstBody.categoryBitMask == CollisionBitMask.canyonCategory && secondBody.categoryBitMask == CollisionBitMask.seedCategory  {
            isDead = true
            if let explosion = SKEmitterNode(fileNamed: "Explosion") {
              explosion.position = seed.position
              addChild(explosion)
            }
            seed.removeFromParent()
            }
            }
    
    func checkSeedRock(_ firstBody: SKPhysicsBody, _ secondBody: SKPhysicsBody) {
        
        if firstBody.categoryBitMask == CollisionBitMask.seedCategory && secondBody.categoryBitMask == CollisionBitMask.rockCategory || firstBody.categoryBitMask == CollisionBitMask.rockCategory && secondBody.categoryBitMask == CollisionBitMask.seedCategory  {
              isDead = true
            }
            
    }
    
    func checkSeedFirefly(_ firstBody: SKPhysicsBody, _ secondBody: SKPhysicsBody, _ contact: SKPhysicsContact) {
        
        if firstBody.categoryBitMask == CollisionBitMask.seedCategory && secondBody.categoryBitMask == CollisionBitMask.fireflyCategory  {
            collectOrb()
            //  addOrb()
            if secondBody.node?.position != nil {
              secondBody.node?.removeFromParent()
            
                //createOrb()
            }
            
        }
            if firstBody.categoryBitMask == CollisionBitMask.fireflyCategory && secondBody.categoryBitMask == CollisionBitMask.seedCategory  {
                  collectOrb()
                //  addOrb()
                if firstBody.node?.position != nil {
                  firstBody.node?.removeFromParent()
                    //createOrb()

                }

            }
        }
    
    func checkOrbRock(_ firstBody: SKPhysicsBody, _ secondBody: SKPhysicsBody, _ contact: SKPhysicsContact) {
        
        
        if firstBody.categoryBitMask == CollisionBitMask.orbCategory || firstBody.categoryBitMask == CollisionBitMask.orbitCategory && secondBody.categoryBitMask == CollisionBitMask.rockCategory {
            if secondBody.node?.position != nil {
              explodeRock(contact)
            secondBody.node?.removeFromParent()

                //createOrb()
            }
            checkStaticOrb(firstBody, secondBody, contact)
            
        }
            if firstBody.categoryBitMask == CollisionBitMask.rockCategory && secondBody.categoryBitMask == CollisionBitMask.orbCategory || secondBody.categoryBitMask == CollisionBitMask.orbitCategory {
                //  addOrb()
                if firstBody.node?.position != nil {
                  explodeRock(contact)
                  firstBody.node?.removeFromParent()
                    //createOrb()

                }
                checkStaticOrb(firstBody, secondBody, contact)

            }
        }
    
    func checkStaticOrb(_ firstBody: SKPhysicsBody, _ secondBody: SKPhysicsBody, _ contact: SKPhysicsContact) {
        
        print("Checking Static Orb")
        print(firstBody)
        print(secondBody)
        
        if firstBody.categoryBitMask == CollisionBitMask.orbCategory || secondBody.categoryBitMask == CollisionBitMask.orbCategory {
            print("DYNAMIC ORB")
            return
        } else if firstBody.categoryBitMask == CollisionBitMask.orbitCategory {
          print("STATIC ORB")
          let position = contact.contactPoint
          launchOrb(position, false)
          firstBody.node?.removeFromParent()
            print("ORB REMOVED on ROCK COLLISION")

        } else if secondBody.categoryBitMask == CollisionBitMask.orbitCategory {
          print("STATIC ORB")
          let position = contact.contactPoint
          launchOrb(position, false)
        secondBody.node?.removeFromParent()
            print("ORB REMOVED on ROCK COLLISION")
        }
        
        
    }
    
    func checkOrbCanyon(_ firstBody: SKPhysicsBody, _ secondBody: SKPhysicsBody, _ contact: SKPhysicsContact) {
        
            
        if firstBody.categoryBitMask == CollisionBitMask.orbCategory || firstBody.categoryBitMask == CollisionBitMask.orbitCategory && secondBody.categoryBitMask == CollisionBitMask.canyonCategory   {
            print("THIS THINKS IT's A CANYON COLLISION")
                if let explosion = SKEmitterNode(fileNamed: "firefly2") {
                    explosion.position = contact.contactPoint
                    addChild(explosion)
                }
            firstBody.node?.removeFromParent()
                }
        
        if firstBody.categoryBitMask == CollisionBitMask.canyonCategory && secondBody.categoryBitMask == CollisionBitMask.orbitCategory || secondBody.categoryBitMask == CollisionBitMask.orbCategory   {
            print("THIS THINKS IT's A CANYON COLLISION")

                if let explosion = SKEmitterNode(fileNamed: "firefly2") {
                    explosion.position = contact.contactPoint
                    addChild(explosion)
                }
            secondBody.node?.removeFromParent()
                }
                
                
    }

}
