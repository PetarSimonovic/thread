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
    static let energyCategory:UInt32 = 0x1 << 3
}

extension GameScene {
    
    func createSeed() -> SKSpriteNode {
        // Assign image and position
        let seed = SKSpriteNode(imageNamed: "threadship")
        seed.size = CGSize(width: 20, height: 20)
        print(self.frame.midX)
        seed.position = CGPoint(x: self.frame.midX, y:self.frame.midY)

        
        // Asign physics
        seed.physicsBody = SKPhysicsBody(texture: seed.texture!, size: seed.size)
        seed.physicsBody?.linearDamping = 0.55 // simulates air friction (value between 0 and 1)
        seed.physicsBody?.restitution = 0.8 // how much energy object loses when it hits another (value between 0 and 1)
        
        // Add collision masks
        
        seed.physicsBody?.categoryBitMask = CollisionBitMask.seedCategory
        seed.physicsBody?.collisionBitMask = CollisionBitMask.rockCategory
        seed.physicsBody?.contactTestBitMask = CollisionBitMask.rockCategory
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
        ceiling.physicsBody?.categoryBitMask = CollisionBitMask.rockCategory
        ceiling.physicsBody?.collisionBitMask = CollisionBitMask.seedCategory
        ceiling.physicsBody?.contactTestBitMask = CollisionBitMask.seedCategory
        ceiling.physicsBody?.isDynamic = false
        ceiling.physicsBody?.affectedByGravity = false
        ceiling.position = CGPoint(x: self.frame.width/2, y: self.frame.height)
        addChild(ceiling)
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
      //  let scaleSeed = SKAction.scaleX(to: 0.5, y: 0.5, duration: 1)
        let moveSeed =  SKAction.move(to: CGPoint(x: self.frame.midX, y: self.frame.midY), duration: 1)
        //seed.physicsBody?.applyTorque(CGFloat(-0.1))
        //seed.run(scaleSeed)
       // seed.physicsBody?.applyTorque(CGFloat(-0.006))
        seed.run(moveSeed)
        title.run(fade)
    }
    
    
    
    func addRock() {
       let  element = Int.random(in: 1..<50)
        if element <= 6 && nodeCount < 9 && isDead == false {
          let rock = SKSpriteNode(imageNamed: "rock_\(element)")
              rock.physicsBody = SKPhysicsBody(texture: rock.texture!, size: rock.texture!.size())
              rock.physicsBody?.categoryBitMask = CollisionBitMask.rockCategory
              rock.physicsBody?.collisionBitMask = CollisionBitMask.seedCategory | CollisionBitMask.rockCategory
              rock.physicsBody?.contactTestBitMask = CollisionBitMask.seedCategory | CollisionBitMask.rockCategory
              rock.physicsBody?.isDynamic = false
              rock.physicsBody?.affectedByGravity = false
            rock.anchorPoint = CGPoint.init(x: 0.5, y: 0.5)
            let height = CGFloat.random(in: -50.00...50.00)
            rock.position = CGPoint(x: CGFloat(1.5) * self.frame.width, y: self.frame.midY + height )
                  rock.name = "rock"
            let randomScale = CGFloat.random(in: (0.2 + distance)...(0.5 + distance))
                rock.setScale(randomScale)
                self.addChild(rock)
            let time = Float.random(in: (0.5...1))
            let spin = [Double.pi, -Double.pi].randomElement()!
            let rotate = SKAction.rotate(byAngle: CGFloat(spin), duration: TimeInterval(time))
            rock.run(SKAction.repeatForever(rotate))

               nodeCount += 1
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
//        if let fireParticles = SKEmitterNode(fileNamed: "FireParticles") {
//            fireParticles.position = energy.position
//            addChild(fireParticles)
//        }

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

    
}

