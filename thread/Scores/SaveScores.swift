//
//  File.swift
//  thread
//
//  Created by Petar Simonovic on 20/05/2021.
//

import Foundation



func loadScores() -> Double {
    
    return UserDefaults.standard.double(forKey: "highScore")
        
}


func saveScore(_ highScore: Double) {
    
        UserDefaults.standard.set(highScore, forKey: "highScore")
        print("Saved!")

    

 }

func checkScore(_ score: Double, _ highScore: Double) -> Double {
    
    if score > highScore {
       let hghScore = score
       saveScore(hghScore)
    }
    
    return highScore
}


