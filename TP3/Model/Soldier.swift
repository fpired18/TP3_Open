//
//  Soldier.swift
//  TP3
//
//  Created by Frédéric on 05/02/2019.
//  Copyright © 2019 fpired. All rights reserved.
//

import Foundation
// This parent class defines the generic object of the soldier
class Soldiers {
    var nameSoldier: String
    var type: String
    var numberPointsOfLive: Int
    var numberPointsOfAttack: Int
    init(nameSoldier: String, type: String, numberPointsOfLive: Int, numberPointsOfAttack: Int) {
        self.nameSoldier = nameSoldier
        self.type = type
        self.numberPointsOfLive = numberPointsOfLive
        self.numberPointsOfAttack = numberPointsOfAttack
    }
}
