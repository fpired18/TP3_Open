//
//  Gamers.swift
//  TP3
//
//  Created by Frédéric on 05/02/2019.
//  Copyright © 2019 fpired. All rights reserved.
//

import Foundation
// the class Gamers defines the object gamers
class Gamers {
    var name: String
    var pseudo: String
    var numberGamers: Int
    init(name: String, pseudo: String, numberGamers: Int){
        self.name = name
        self.pseudo = pseudo
        self.numberGamers = numberGamers
    }
}
