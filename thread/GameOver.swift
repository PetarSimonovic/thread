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
            gameOver()
    }
        
    }
    
    func gameOver() {
        print("Game Over")
        let score = Double(round(1000*distance)/1000)
        highScore = checkScore(score, highScore)
        let endGame = SKAction.sequence([SKAction.wait(forDuration: 3.0), SKAction.run(restartGame)])
        self.run(endGame)
    }
    
}
