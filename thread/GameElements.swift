//
//  GameElements.swift
//  thread
//
//  Created by Petar Simonovic on 23/04/2021.
//

import SpriteKit

struct CollisionBitMask {
    static let gardenerCategory:UInt32 = 0x1 << 0
    static let seedPodCategory:UInt32 = 0x1 << 1
    static let seedCategory:UInt32 = 0x1 << 2
    static let groundCategory:UInt32 = 0x1 << 3
    static let wallCategory:UInt32 = 0x1 << 4

}

extension GameScene {
    
    func createGardener() -> SKSpriteNode {
        // Assign image and position
        let gardener = SKSpriteNode(imageNamed: "gardener")
        gardener.size = CGSize(width: 20, height: 20)
        gardener.position = CGPoint(x: self.frame.midX, y:self.frame.midY)
        
        // Asign physics
        gardener.physicsBody = SKPhysicsBody(texture: gardener.texture!, size: gardener.size)
        gardener.physicsBody?.linearDamping = 0.55 // simulates air friction (value between 0 and 1)
        gardener.physicsBody?.restitution = 0.8 // how much energy object loses when it hits another (value between 0 and 1)
        
        // Add collision masks
        
        gardener.physicsBody?.categoryBitMask = CollisionBitMask.gardenerCategory
        gardener.physicsBody?.collisionBitMask = CollisionBitMask.seedPodCategory | CollisionBitMask.wallCategory | CollisionBitMask.groundCategory
        gardener.physicsBody?.contactTestBitMask = CollisionBitMask.seedPodCategory |  CollisionBitMask.groundCategory | CollisionBitMask.wallCategory
        gardener.physicsBody?.affectedByGravity = false
        gardener.physicsBody?.isDynamic = true
    
        return gardener
    
        
    }

    
    
    
    func createSeedPod() {
       let  element = Int.random(in: 1..<100)
        print(element)
        if element <= 1  {
          let seedPod = SKSpriteNode(imageNamed: "seedpod")
              seedPod.physicsBody = SKPhysicsBody(texture: seedPod.texture!, size: seedPod.texture!.size())
              seedPod.physicsBody?.categoryBitMask = CollisionBitMask.seedPodCategory
              seedPod.physicsBody?.collisionBitMask = CollisionBitMask.gardenerCategory | CollisionBitMask.seedPodCategory | CollisionBitMask.groundCategory
              seedPod.physicsBody?.contactTestBitMask = CollisionBitMask.gardenerCategory | CollisionBitMask.seedPodCategory | CollisionBitMask.groundCategory
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
            seedPod.setScale(0.3)
                self.addChild(seedPod)
            let time = Float.random(in: 1...3)
            let spin = [Double.pi, -Double.pi].randomElement()!
            let rotate = SKAction.rotate(byAngle: CGFloat(spin), duration: TimeInterval(time))
            seedPod.run(SKAction.repeatForever(rotate))
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
    
    func createSeed (_ seedPosition: CGPoint) {
        let seed = SKSpriteNode(imageNamed: "seed")
        seed.physicsBody = SKPhysicsBody(texture: seed.texture!, size: seed.texture!.size())
        seed.physicsBody?.categoryBitMask = CollisionBitMask.seedPodCategory
            seed.physicsBody?.collisionBitMask = CollisionBitMask.gardenerCategory | CollisionBitMask.groundCategory
        seed.physicsBody?.contactTestBitMask = CollisionBitMask.gardenerCategory | CollisionBitMask.groundCategory
        seed.physicsBody?.affectedByGravity = true
        seed.anchorPoint = CGPoint.init(x: 0.5, y: 0.5)
        seed.position = seedPosition
        seed.name = "seed"
        seed.setScale(0.3)
        addChild(seed)
        seed.physicsBody?.applyImpulse(CGVector(dx: -5, dy: 5))
        seed.physicsBody?.applyTorque(CGFloat(1))

    }
    
    func createGround() {
        let ground = SKSpriteNode()
        ground.size = CGSize(width: self.frame.width, height: 30)
        ground.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.frame.width, height: 30))
        ground.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.frame.width, height: 30))
        ground.physicsBody?.categoryBitMask = CollisionBitMask.groundCategory
        ground.physicsBody?.collisionBitMask = CollisionBitMask.gardenerCategory | CollisionBitMask.seedPodCategory
        ground.physicsBody?.contactTestBitMask = CollisionBitMask.gardenerCategory | CollisionBitMask.seedPodCategory
        ground.physicsBody?.isDynamic = false
        ground.physicsBody?.affectedByGravity = false
        ground.position = CGPoint(x: self.frame.width/2, y: 10)
        addChild(ground)
        if let groundParticles = SKEmitterNode(fileNamed: "groundParticles") {
            groundParticles.position = ground.position
            addChild(groundParticles)
        }
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

