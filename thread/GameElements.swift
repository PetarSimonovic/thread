//
//  GameElements.swift
//  thread
//
//  Created by Petar Simonovic on 23/04/2021.
//

import SpriteKit

struct CollisionBitMask {
    static let seedCategory:UInt32 = 0x1 << 0
    static let seedPodCategory:UInt32 = 0x1 << 1
    static let loopCategory:UInt32 = 0x1 << 2
    static let energyCategory:UInt32 = 0x1 << 3
    static let wallCategory:UInt32 = 0x1 << 4

}

extension GameScene {
    
    func createSeed() -> SKSpriteNode {
        // Assign image and position
        let seed = SKSpriteNode(imageNamed: "seed")
        seed.size = CGSize(width: 20, height: 20)
        seed.position = CGPoint(x: self.frame.midX, y:self.frame.midY)
        
        // Asign physics
        seed.physicsBody = SKPhysicsBody(texture: seed.texture!, size: seed.size)
        seed.physicsBody?.linearDamping = 0.55 // simulates air friction (value between 0 and 1)
        seed.physicsBody?.restitution = 0.8 // how much energy object loses when it hits another (value between 0 and 1)
        
        // Add collision masks
        
        seed.physicsBody?.categoryBitMask = CollisionBitMask.seedCategory
        seed.physicsBody?.collisionBitMask = CollisionBitMask.seedPodCategory | CollisionBitMask.wallCategory
        seed.physicsBody?.contactTestBitMask = CollisionBitMask.seedPodCategory | CollisionBitMask.wallCategory
        seed.physicsBody?.affectedByGravity = false
        seed.physicsBody?.isDynamic = true
    
        return seed
    
        
    }

    
    
    
    func seedPod() {
       let  element = Int.random(in: 1..<100)
        print(element)
        if element <= 1  {
          let seedPod = SKSpriteNode(imageNamed: "seedpod")
              seedPod.physicsBody = SKPhysicsBody(texture: seedPod.texture!, size: seedPod.texture!.size())
              seedPod.physicsBody?.categoryBitMask = CollisionBitMask.seedPodCategory
              seedPod.physicsBody?.collisionBitMask = CollisionBitMask.seedCategory | CollisionBitMask.seedPodCategory
              seedPod.physicsBody?.contactTestBitMask = CollisionBitMask.seedCategory | CollisionBitMask.seedPodCategory
              seedPod.physicsBody?.linearDamping = 0.3
              seedPod.physicsBody?.isDynamic = true
              seedPod.physicsBody?.affectedByGravity = true
            seedPod.anchorPoint = CGPoint.init(x: 0.5, y: 0.5)
              let xPos = CGFloat(arc4random() % UInt32(CGFloat(self.frame.width)))
            seedPod.position = CGPoint(x: xPos, y: CGFloat(1.5) * self.frame.height * 1.5  )
            print(seedPod.position)
                  seedPod.name = "seedPod"
//            let randomScale = CGFloat(Float.random(in: 0.5..<0.7))
//                print("scale: \(randomScale)")
            seedPod.setScale(0.5)
                self.addChild(seedPod)
//            let time = Float.random(in: 8...20)
//            let spin = [Double.pi, -Double.pi].randomElement()!
//            let rotate = SKAction.rotate(byAngle: CGFloat(spin), duration: TimeInterval(time))
//            seedPod.run(SKAction.repeatForever(rotate))
//               nodeCount += 1
    }
    }
    
    func breakSeedPod(_ seedPosition: CGPoint) {
      print("x \(seedPosition)")
        if let seedPodParticles = SKEmitterNode(fileNamed: "seedPodExplode") {
            seedPodParticles.position = seedPosition
            addChild(seedPodParticles)
    }
    }
    
    func energyField() {
        let energy = SKSpriteNode()
        energy.size = CGSize(width: 10, height: self.frame.height)
        seed.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 1, height: self.frame.height))
        energy.physicsBody?.categoryBitMask = CollisionBitMask.energyCategory
        energy.physicsBody?.collisionBitMask = CollisionBitMask.seedCategory
        energy.physicsBody?.contactTestBitMask = CollisionBitMask.seedCategory
        energy.physicsBody?.isDynamic = false
        energy.physicsBody?.affectedByGravity = false
        energy.position = CGPoint(x: 0, y: self.frame.height / 2)
        if let fireParticles = SKEmitterNode(fileNamed: "FireParticles") {
            fireParticles.position = energy.position
            addChild(fireParticles)
        }

           // nodeCount += 1
    }
    
//    func decelerate() {
////        if acceleration >= 1 {
////            acceleration -= 0.1
////        }
//    }
    
//    func accelerate() {
////        if acceleration <= 10 {
////            acceleration += 0.1
////        }
//    }
//    
    
    func setGravity() {
        physicsWorld.gravity = CGVector(dx:0, dy: 0);
        let gravityVector = vector_float3(0,-1,0);
        let gravityNode = SKFieldNode.linearGravityField(withVector: gravityVector)
        gravityNode.strength = 0.8
        addChild(gravityNode)
    }
    
}

