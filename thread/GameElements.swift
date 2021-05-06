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
    static let boloCategory:UInt32 = 0x1 << 4

}

extension GameScene {
    
    func createSeed() -> SKSpriteNode {
        // Assign image and position
        let seed = SKSpriteNode(imageNamed: "threadship")
        seed.size = CGSize(width: 20, height: 20)
        print(self.frame.midX)
        seed.position = CGPoint(x: self.frame.midX, y: self.frame.midY)

        
        // Asign physics
        seed.physicsBody = SKPhysicsBody(texture: seed.texture!, size: seed.size)
        seed.physicsBody?.linearDamping = 0.55 // simulates air friction (value between 0 and 1)
        seed.physicsBody?.restitution = 0.8 // how much energy object loses when it hits another (value between 0 and 1)
        
        // Add collision masks
        
        seed.physicsBody?.categoryBitMask = CollisionBitMask.seedCategory
        seed.physicsBody?.collisionBitMask = CollisionBitMask.rockCategory | CollisionBitMask.canyonCategory
        seed.physicsBody?.contactTestBitMask = CollisionBitMask.rockCategory | CollisionBitMask.canyonCategory | CollisionBitMask.fireflyCategory
        seed.physicsBody?.affectedByGravity = false
        seed.physicsBody?.isDynamic = true    
        return seed
    
        
    }
    
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
        ceiling.position = CGPoint(x: self.frame.width/2, y: self.frame.height)
        addChild(ceiling)
        ceiling.name = "ceiling"
        if let groundParticles = SKEmitterNode(fileNamed: "CanyonFire") {
            groundParticles.position = ceiling.position
            addChild(groundParticles)
        }
    }
    
    
    

    func displayTitle() -> SKSpriteNode {
        
        let title = SKSpriteNode(imageNamed: "threadtitle")
        title.position = CGPoint(x: self.frame.midX, y:self.frame.midY + 50)
        title.setScale(0.8)
        title.name = "title"
        
        return title
        
    }
    
    func removeTitle() {
        let fade = SKAction.fadeOut(withDuration: 3)
        title.run(fade)
    }
    
    func createBolo() {
        print("Bolo addad")
        let bolo = SKSpriteNode(imageNamed: "bolo")
        bolo.physicsBody = SKPhysicsBody(texture: bolo.texture!, size: bolo.size)
        bolo.size = CGSize(width: 15, height: 15)
        bolo.physicsBody?.linearDamping = 0.55 // simulates air friction (value between 0 and 1)
        bolo.physicsBody?.restitution = 0.0 // how much energy object loses when it hits another (value between 0 and 1)
        
        // Add collision masks
                bolo.physicsBody?.categoryBitMask = CollisionBitMask.boloCategory
        bolo.physicsBody?.collisionBitMask = CollisionBitMask.rockCategory | CollisionBitMask.canyonCategory
        bolo.physicsBody?.contactTestBitMask = CollisionBitMask.rockCategory | CollisionBitMask.canyonCategory | CollisionBitMask.fireflyCategory
        bolo.physicsBody?.affectedByGravity = false
        bolo.physicsBody?.isDynamic = false
       // bolo.setScale(0.5)
        
        seed.addChild(bolo)
       // seed.addChild(bolo)
        bolo.anchorPoint = CGPoint(x: 0.5, y: 0.5)
       bolo.position = CGPoint(x: 20, y: 0 )
    }

    
   func addFireFly() {
    if Int.random(in: 1..<60) == 1 {
        print("Firefly!")
        let firefly = SKSpriteNode(imageNamed: "firefly")
        firefly.physicsBody = SKPhysicsBody(circleOfRadius: 10)
        firefly.physicsBody?.categoryBitMask = CollisionBitMask.fireflyCategory
        firefly.physicsBody?.collisionBitMask = CollisionBitMask.seedCategory
        firefly.physicsBody?.contactTestBitMask = CollisionBitMask.seedCategory
        firefly.physicsBody?.isDynamic = false
        firefly.physicsBody?.affectedByGravity = false
        let fireflyheight = CGFloat.random(in: -50.00...50.00)
        firefly.position = CGPoint(x: self.frame.midX +  (self.frame.width/2), y: self.frame.midY + fireflyheight )
          firefly.name = "firefly"
        self.addChild(firefly)
        firefly.anchorPoint = CGPoint.init(x: 0.5, y: 0.5)
        firefly.setScale(0.1)
        let time = Float.random(in: (0.5...1))
        let spin = [Double.pi, -Double.pi].randomElement()!
        let rotate = SKAction.rotate(byAngle: CGFloat(spin), duration: TimeInterval(time))
        firefly.run(SKAction.repeatForever(rotate))
    }
    }
    
    
    
    func addRock() {
       let  element = Int.random(in: 1..<50)
        if element <= 6 && nodeCount < difficulty && isDead == false {
          let rock = SKSpriteNode(imageNamed: "rock_\(element)")
              rock.physicsBody = SKPhysicsBody(texture: rock.texture!, size: rock.texture!.size())
              rock.physicsBody?.categoryBitMask = CollisionBitMask.rockCategory
              rock.physicsBody?.collisionBitMask = CollisionBitMask.seedCategory | CollisionBitMask.rockCategory
              rock.physicsBody?.contactTestBitMask = CollisionBitMask.seedCategory | CollisionBitMask.rockCategory
              rock.physicsBody?.isDynamic = false
              rock.physicsBody?.affectedByGravity = false
            rock.anchorPoint = CGPoint.init(x: 0.5, y: 0.5)
            let height = CGFloat.random(in: -150.00...150.00)
            rock.position = CGPoint(x: CGFloat(1.5) * self.frame.width, y: self.frame.midY + height )
                  rock.name = "rock"
            let randomScale = CGFloat.random(in: (0.2 + distance/100)...(0.5))
                rock.setScale(randomScale)
                self.addChild(rock)
            let time = Float.random(in: (0.5...1))
            let spin = [Double.pi, -Double.pi].randomElement()!
            let rotate = SKAction.rotate(byAngle: CGFloat(spin), duration: TimeInterval(time))
            rock.run(SKAction.repeatForever(rotate))

               nodeCount += 1
    }
    }
    
    
    func gameOver() {
        print("Game Over")
    }
    
    func setGravity() {
        physicsWorld.gravity = CGVector(dx:0, dy: 0);
        let gravityVector = vector_float3(0,-1,0);
        let gravityNode = SKFieldNode.linearGravityField(withVector: gravityVector)
        gravityNode.strength = 0.6
        addChild(gravityNode)

    }
    
    func restartGame(){
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
    
    func disperseFireFlies() {
        if let fireflyDisperse = SKEmitterNode(fileNamed: "firefly2") {
          fireflyDisperse.position = seed.position
          addChild(fireflyDisperse)
        }
    }

    
}

