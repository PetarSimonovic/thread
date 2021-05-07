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
    static let orbCategory:UInt32 = 0x0 << 4

}

extension GameScene {
    
    
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
            //  addOrb()
            if secondBody.node?.position != nil {
              secondBody.node?.removeFromParent()
                //createOrb()

            }
            
        }
        if firstBody.categoryBitMask == CollisionBitMask.fireflyCategory && secondBody.categoryBitMask == CollisionBitMask.seedCategory  {
              disperseFireFlies()
//            if secondBody.node?.position != nil {
//              secondBody.node?.removeFromParent()
//            }
            
        }
        }
            

       
  
}
