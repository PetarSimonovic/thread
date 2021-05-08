//
//  GameOver.swift
//  thread
//
//  Created by Petar Simonovic on 06/05/2021.
//

import Foundation
import SpriteKit

extension GameScene {
    
    func checkDeath() {
    if seed.position.x <= -seed.size.width || seed.position.y < 0 {
        isDead = true
        seed.removeFromParent()
    }
        
        if isDead == true {
            disperseFireFlies()
        }
    
    if isDead == true && nodeCount == 0 {
       gameOver()
       restartGame()
    }
        
    }
    
    func gameOver() {
        print("Game Over")
    }
    
}
