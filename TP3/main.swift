//  main.swift
//  Game
//
//  Created by Frédéric on 18/01/2019.
//  Copyright © 2019 fpired. All rights reserved.
//

import Foundation

func gameMenu() {
    var temporaryName = [String]()
    var team1 = Teams()
    var team2 = Teams()
    var team = Teams()
    var gamerPseudo1 = ""
    var gamerPseudo2 = ""
    var gamerPseudo = gamerPseudo1
    var gamer1: Gamers
    var gamer2: Gamers
    var newPartOfGame = PartOfGame()
    var oneTime = 1
    var check = true
    var warriorName = ""
    var numberTurn = 0
    var pseudoName = ""
    var numberLoop = 0
    let banner = """
          
                 |  |  _          _              _         ,|
                 |--| (_ | |  _  (   _  |  _| ° (_ /)  _ °  |
                 |  |_(__|_|_(_)__)_(_)_|_(_|_|_(_/(__| )___|_
                          
                         
        """
    let banner1 = """

                 |  |  _          _              _         ,__
                 |--| (_ | |  _  (   _  |  _| ° (_ /)  _ ° | /
                 |  |_(__|_|_(_)__)_(_)_|_(_|_|_(_/(__| )___/__


        """
    
    let banner2 = """
          __
         |  )
         |--  /) _  | / _       |||
         |__)/(_(_(_|/_(_)      |||
                           °°°  °°°
                    
        """
    let banner3 = """
        ,_____,
              
             ) )  _   , ,   | /| / _   _      |||
            (_(__(_|_(_(_  _|/_|/_(_)_| )     |||
             /)                          °°°  °°°
            (/
                   
        """
    func checkName(name: String) -> Bool {
// name control function
        let nameInit = name
        var timeName = 0
        for i in 0...temporaryName.count-1 {
            if temporaryName[i] == nameInit {
                timeName += 1
                if timeName == 2 {
                    print("\n            =========================================="
                        + "\n                      THE NAME IS ALREADY USED."
                        + "\n                       REPEAT YOUR CHOICE..."
                        + "\n            ==========================================")
                newPartOfGame.numberTime -= 1
                check = true
                }
            }
       }
        return check
    }
  
//Recording function that selects the team in relation to the palyer's number
    func recordName (numberGamer: Int, typeWarrior: Soldiers, numberTime: Int, check: Bool) {
        let soldier = typeWarrior
        let gamerNumber = numberGamer
    
            soldier.nameSoldier = warriorName
            soldier.type = typeWarrior.type
            soldier.numberPointsOfAttack = typeWarrior.numberPointsOfAttack
            soldier.numberPointsOfLive = typeWarrior.numberPointsOfLive
            numberLoop += 1
        if numberGamer == 1 && !check {
            newPartOfGame.maxPointOfLiveTeam1 += typeWarrior.numberPointsOfLive
            team1.team.append(soldier)
            team1.number = gamerNumber
        }
        if numberGamer == 1 && !check && numberLoop == 3 {
            newPartOfGame.viewTeam(team: team1, gamerNumber: gamerNumber)
        }
        
        if numberGamer == 2 && !check {
            newPartOfGame.maxPointOfLiveTeam2 += typeWarrior.numberPointsOfLive
            team2.team.append(soldier)
            team2.number = gamerNumber
        }

        if numberGamer == 2 && numberLoop == 3 {
            newPartOfGame.viewTeam(team: team2, gamerNumber: numberGamer)
        }
    }
    
    func game() {
        newPartOfGame.numberGamer = 1
        if numberTurn % 2 == 0 {
            gamerPseudo = gamerPseudo1
        } else {
            gamerPseudo = gamerPseudo2
        }


        print("\n              ============================================")
        print("\n                           TEAMS REMINDER")
        print("\n              ============================================")
        newPartOfGame.viewTeam(team: team1, gamerNumber: newPartOfGame.numberGamer)
        newPartOfGame.viewTeam(team: team2, gamerNumber: newPartOfGame.numberGamer + 1)

        repeat {
// numberTurn counts cycle. This will inform the winner at the end of the game
            numberTurn += 1
            var controle = true
            print("\n=============================="
            + "\n\(gamerPseudo) WANT TO FIGHT OR CARE ? "
            + "\n=============================="
                + "\nStape : 1 to fight "
                + "\nStape : 2 to care ")
            if let choice = readLine() {
                switch choice {
                case "1":
                    newPartOfGame.choiceSoldier(choice: choice, numberGamer: newPartOfGame.numberGamer, team1: team1, team2: team2)
                case "2":
                    newPartOfGame.choiceSoldier(choice: choice, numberGamer: newPartOfGame.numberGamer, team1: team1, team2: team2)
                default:
                    print("I don't understand.")
                    controle = false
                }
            }

            if newPartOfGame.numberGamer == 1 && controle {
                newPartOfGame.numberGamer = 2
                gamerPseudo = gamerPseudo2
            } else {
                newPartOfGame.numberGamer = 1
                gamerPseudo = gamerPseudo1
            }

        } while newPartOfGame.maxPointOfLiveTeam1 != 0 && newPartOfGame.maxPointOfLiveTeam2 != 0

            if newPartOfGame.maxPointOfLiveTeam1 <= 0 {
                print(banner2)
                print("Bravo \(gamerPseudo1) your team has won !!!")
                print("It took \(numberTurn) laps to win the fight...")
                print(banner3)
            }
            if newPartOfGame.maxPointOfLiveTeam2 <= 0 {
                print(banner2)
                print("Bravo \(gamerPseudo2) your team has won !!!")
                print("Il aura fallut \(numberTurn) laps to win the fight...")
                print(banner3)
            }
    }

    //========================================
    //              START MENU
    //========================================

    for _ in 0...1 {
            if newPartOfGame.numberGamer == 1
            {
                print("\n"
                    + "        " + banner)
            }
            else {
                print("\n"
                    + "        " + banner1)
            }

            var gamerName = ""
        
            var controlePseudo = false
            print("\nWhat is your name \(newPartOfGame.numberGamer) ? \n")
            if let answerName = readLine() {
            gamerName = answerName
            }

            repeat {
                controlePseudo = false
                print("Hello \(gamerName), what nickname did you choose to participate in this game ? ")

                if let answerPseudo = readLine() {
                    if newPartOfGame.numberGamer == 1 {
                        pseudoName = answerPseudo
                        gamerPseudo1 = pseudoName
                        gamer1 = Gamers(name: gamerName, pseudo: pseudoName, numberGamers: 1)
                        print("Ok gamer \(newPartOfGame.numberGamer), you are called \(gamer1.name) and you will play under the nickname: \(gamer1.pseudo)")
                    } else {
                        if pseudoName == answerPseudo {
                            print("This nickname is already used. Start again...")
                            controlePseudo = true
                        } else {
                            pseudoName = answerPseudo
                            gamerPseudo2 = pseudoName
                            gamer2 = Gamers(name: gamerName, pseudo: pseudoName, numberGamers: 2)
                            print("Ok gamer \(newPartOfGame.numberGamer), you are called \(gamer2.name) and you will play under the nickname: \(gamer2.pseudo)")
                        }
                    }
                }
            } while controlePseudo

            print("\nSELECT 3 SOLDIERS FROM THE ONES LISTED BELOW...")
            if newPartOfGame.numberGamer == 2 {
                newPartOfGame.numberTime = 0
            }
            numberLoop = 0
            repeat {
                print("\nWhat character number \(newPartOfGame.numberTime + 1) do you want in your team :"
                    + "\n--------------------------------------------------"
                    + "\nStep : 1 to have a   fight  with 100 health and 10 strength"
                    + "\nStep : 2 to have a   magus  with  80 health and 10 strength"
                    + "\nStep : 3 to have a colossus with 120 health and  7 strength"
                    + "\nStep : 4 to have a   dwarf  with  60 health and 15 strength"
                    + "\nStep : 5 to have a   rider  with 150 health and 30 strength")

                if let choice = readLine() {
                    var choiceSoldierTeam = 0
                    if Int(choice) != nil {
                        choiceSoldierTeam = Int(choice)!
                    }
                    if choiceSoldierTeam <= 5 && choiceSoldierTeam > 0 {
                        print("\nHow do you want to call it ?")

                            if let name = readLine() {
                                check = false
                                warriorName = name
                                temporaryName.append(warriorName)
                                check = checkName(name: warriorName)
                                if check {
                                    temporaryName.remove(at: temporaryName.count-1)
                                }
                            }
                        switch choice {
                        case "1":
                            if !check {
                               
                                let fight = Fights(nameSoldier: warriorName, type: "fight", numberPointsOfLive: 100, numberPointsOfAttack: 10)
                                recordName(numberGamer: newPartOfGame.numberGamer, typeWarrior: fight, numberTime: newPartOfGame.numberTime, check: check)
                                }
                        case "2":
                            if !check {
                                let magus = Magus(nameSoldier: warriorName, type: "magus", numberPointsOfLive: 80, numberPointsOfAttack: 10)
                                recordName(numberGamer: newPartOfGame.numberGamer, typeWarrior: magus, numberTime: newPartOfGame.numberTime, check: check)
                            }
                        case "3":
                            if !check {
                                let colossus = Colossus(nameSoldier: warriorName, type: "colossus", numberPointsOfLive: 120, numberPointsOfAttack: 7)
                                recordName(numberGamer: newPartOfGame.numberGamer, typeWarrior: colossus, numberTime: newPartOfGame.numberTime, check: check)
                                }
                        case "4":
                            if !check {
                                let dwarf = Dwarfs(nameSoldier: warriorName, type: "dwarf", numberPointsOfLive: 60, numberPointsOfAttack: 15)
                                recordName(numberGamer: newPartOfGame.numberGamer, typeWarrior: dwarf, numberTime: newPartOfGame.numberTime, check: check)
                                }
                        case "5":
                            if !check {
                                let rider = Riders(nameSoldier: warriorName, type: "rider", numberPointsOfLive: 150, numberPointsOfAttack: 30)
                                recordName(numberGamer: newPartOfGame.numberGamer, typeWarrior: rider, numberTime: newPartOfGame.numberTime, check: check)
                            }
                        default:
                            print("I don't understand.")
                            newPartOfGame.numberTime -= 1
                        }
                    }
                    else {
                        print("The value must be between 1 and 5 ")
                        newPartOfGame.numberTime -= 1
                    }
                    newPartOfGame.numberTime += 1
                }
            } while newPartOfGame.numberTime < 3
        
        newPartOfGame.numberGamer += 1
    }
     game()
}

gameMenu()


//enum SoldierType {
//    case fight
//    case magus
//    case colossus
//    case dwarf
//    case rider
//}
//
//class initSoldier {
//    var type: SoldierType
//
//    convenience init() {
//        self.init(type: .fight)
//    }
//
//    init(type: SoldierType) {
//        self.type = type
//        switch type {
//        case .fight:
//            var fight = Fights()
//        case .magus:
//            var magus = Magus()
//        case .colossus:
//            var colossus = Colossus()
//        case .dwarf:
//            var dwarf = Dwarfs()
//        case .rider:
//            var rider = Riders()
//        }
//    }
//
//}

/*//  main.swift
//  Game
//
//  Created by Frédéric on 18/01/2019.
//  Copyright © 2019 fpired. All rights reserved.
//

import Foundation
import ColorSync

class Soldier {
    var nameSoldier = ""
    var type = ""
    var numberPointsOfLive = 100
    var numberPointsOfAttack = 10
}

var fight = Soldier()

func gameMenu() {
    var numberGamer = 1
    var numberTime = 0
    var team1 = [0 :Soldier(), 1: Soldier(), 2: Soldier(), 3: Soldier()]
    var team2 = [0 :Soldier(), 1: Soldier(), 2: Soldier(), 3: Soldier()]
    var oneTime = 1
    var check = true
    var validation = true
    var warriorName = ""
    var numberPointOfLiveGame = ["Combattant" : 100, "Mage": 80, "Colosse": 120, "Nain": 60, "Cavalier": 200]
    var maxPointOfLiveTeam1 = 0
    var maxPointOfLiveTeam2 = 0
    var maxPointOfLiveTeam = 0
    var numberTurn = 0
    let banner = """
          __
                 |  )                   _
                 |--  _  _  ° _  , ,/) (  _ | _| _ |-   _ ° |
                 |__)(_)| )/_(_)(_(/(_ _)(_)|(_|(_||_  | )__|
                          /)
                         (/
        """
    let banner1 = """
          __
                 |  )                   _                   ,__
                 |--  _  _  ° _  , ,/) (  _ | _| _ |-   _ °   /
                 |__)(_)| )/_(_)(_(/(_ _)(_)|(_|(_||_  | )__ /__,
                          /)
                         (/
        """
    
    let banner2 = """
          __
         |  )
         |--  /) _  | / _       |||
         |__)/(_(_(_|/_(_)      |||
                           °°°  °°°
                    
        """
    let banner3 = """
        ,_____,
           |                         _,
           | , ,  _ (    _  _  _  _ (_      |||
           |(_(__(_|_)_ (_)(_|(_|| |(_      |||
                         /)    /)      °°°  °°°
                        (/    (/
                   
        """
    func checkName(name: String) -> Bool {
        // fonction de control du nom
        let nameInit = name
        for i in 0...4 {
            if team1[i]?.nameSoldier == nameInit || team2[i]?.nameSoldier == nameInit {
                print("\n            =========================================="
                    + "\n                      LE NOM EST DEJA UTILISE."
                    + "\n                       RECOMMENCE TON CHOIX..."
                    + "\n            ==========================================")
                numberTime -= 1
                check = true
            }
        }
        return check
    }
    
    func displayBattleResul() {
        print("\n========================================================")
        print("Voici le nombre de points de vie de l'équipe 1 : \(maxPointOfLiveTeam1)\n"
            + "   et le nombre de points de vie de l'équipe 2 : \(maxPointOfLiveTeam2)\n"
            + "=======================================================")
    }
    
    func viewTeam(team: [Int : Soldier], numberGamer: Int) {
        // fonction d'affichage des équipes
        var team = team
        var oneTime = 1
        if numberTime == 4 {
            for _ in 0...4 {
                if oneTime == 1 {
                    print("\nVoici les membres de l'équipe \(numberGamer): ")
                    print("--------------------------------")
                    for i in 0..<team.count {
                        print("Tape :", i+1, "pour avoir", team[i]?.nameSoldier ?? "Il n'y a rien", "est un", team[i]?.type ?? "SoldatHelp", "qui a",team[i]?.numberPointsOfLive ?? 100,"points de vie et", team[i]?.numberPointsOfAttack ?? 10, "d'attaque")
                        oneTime += 1
                    }
                    if numberGamer == 1{
                        maxPointOfLiveTeam = maxPointOfLiveTeam1
                    }
                    if numberGamer ==  2 {
                        maxPointOfLiveTeam = maxPointOfLiveTeam2
                    }
                    print("\nVoici le nombre de points de vie de l'équipe \(numberGamer) : \(maxPointOfLiveTeam)")
                }
            }
        }
    }
    
    func recordName (numberGamer: Int, name: String, typeWarrior: String ,numberTime: Int, numberPointsOfLive: Int, numberPointsOfAttack: Int, check: Bool) {
        var team = [0 :Soldier(), 1: Soldier(), 2: Soldier(), 3: Soldier()]
        //fonction d'enregistrement qui inverse juste le team lorsque c'est le tour du joueur 2
        if numberGamer == 1 && !check {
            team = team1
            maxPointOfLiveTeam1 += numberPointsOfLive
        }
        if numberGamer == 2 && !check {
            team = team2
            maxPointOfLiveTeam2 += numberPointsOfLive
        }
        if team[numberTime]?.nameSoldier == "" {
            team[numberTime]?.nameSoldier = name
            team[numberTime]?.type = typeWarrior
            team[numberTime]?.numberPointsOfLive = numberPointsOfLive
            team[numberTime]?.numberPointsOfAttack = numberPointsOfAttack
        }
        
        if numberTime == 2 {
            viewTeam(team: team, numberGamer: numberGamer)
        }
    }
    
    func game() {
        var soldier1 = Soldier()
        var soldier2 = Soldier()
        var gamer = 1
        var turnNumber = 0
        
        print("\n              ============================================")
        print("\n                           RAPPEL DES EQUIPES")
        print("\n              ============================================")
        viewTeam(team: team1, numberGamer: 1)
        viewTeam(team: team2, numberGamer: 2)
        
        func displayMenu(team: [Int : Soldier]) -> Soldier {
            
            validation = true
            var team = team
            var soldier = Soldier()
            if let choice = readLine() {
                switch choice {
                case "1":
                    soldier = team[0]!
                case "2":
                    soldier = team[1]!
                case "3":
                    soldier = team[2]!
                case "4":
                    soldier = team[3]!
                default:
                    print("Je ne comprends")
                    validation = false
                }
            }
            return soldier
        }
        
        func openingTrunk(soldier: Soldier, choice: String) -> Soldier {
            // // Etape 3 : Changeons d'armes, cette fonction prend en charge le BONUS
            var chest = ["Massue","Arbalette","Medicaments","Injection","Dopage"]
            let randomIndex = Int(arc4random_uniform(UInt32(chest.count)))
            let newWeapon = chest[randomIndex]
            var controle = 1
            print("\n===================================================================================")
            print("                        ATTENTION LE COFFRE S'OUVRE !!!!!!!")
            print("===================================================================================")
            
            print("\nVoici ce qui est sortie du coffre \(newWeapon)")
            switch soldier.type {
            case "Mage":
                if choice == "2" {
                    if newWeapon == "Medicaments" || newWeapon == "Injection" {
                        soldier.numberPointsOfAttack *= 2
                    }
                }
                else {
                    controle += 1
                }
            case "Cavalier":
                if newWeapon == "Dopage" {
                    soldier.numberPointsOfAttack *= 2
                }
            case "Combattant":
                if newWeapon == "Massue" || newWeapon == "Arbalette" {
                    soldier.numberPointsOfAttack *= 2
                }
            case "Colosse":
                if newWeapon == "Massue" || newWeapon == "Arbalette" {
                    soldier.numberPointsOfAttack *= 2
                }
            case "Nain":
                if newWeapon == "Massue" || newWeapon == "Arbalette" {
                    soldier.numberPointsOfAttack *= 2
                }
            default:
                print("Il n'y a rien ")
            }
            if controle == 1 {
                print("\nVoici la nouvelle force de frappe du soldat \(soldier.numberPointsOfAttack)"
                    + "\n----------------------------------------------") // modifier
            }
            return soldier
        }
        
        func choiceSoldier(choice: String, numberGamer: Int, team1: [Int : Soldier], team2: [Int : Soldier]){
            // fonction de sélection du soldat, elle inverse la team selon le numéro du joueur dans le if
            var teamSwap1 = team1
            var teamSwap2 = team2
            var maxNumberOfLive = 0
            var initialForce = 0
            
            if numberGamer == 1 {
                teamSwap1 = team1
                teamSwap2 = team2
                maxPointOfLiveTeam = maxPointOfLiveTeam1
            } else {
                teamSwap1 = team2
                teamSwap2 = team1
                maxPointOfLiveTeam = maxPointOfLiveTeam2
            }
            
            if choice == "1" {
                var validationMage = true
                var numberMage = 0
                // Cette boucle a pour mission de controler le nombre de Mage dans l'équipe
                for i in 0...4 {
                    if teamSwap1[i]?.type == "Mage" {
                        numberMage += 1
                        soldier2 = teamSwap1[i]!
                    }
                }
                if numberMage == 4 {
                    print("Tu n'as que des Mages dans ton équipe, tu ne peux pas attaquer. ")
                    validationMage = false
                } else {
                    
                    repeat {
                        print("\nCHOISI UN PERSONNAGE DE TON EQUIPE... ")
                        if numberGamer == 1 {
                            viewTeam(team: team1, numberGamer: 1)
                        }
                        if numberGamer == 2 {
                            viewTeam(team: team2, numberGamer: 2)
                        }
                        
                        soldier1 = displayMenu(team: teamSwap1)
                        //Capter la valeur initial du soldat sélectionné
                        initialForce = soldier1.numberPointsOfAttack
                        
                        if soldier1.numberPointsOfLive <= 0 {
                            print("Impossible de le sélectionner, il est HS")
                            validation = false
                        }
                        if soldier1.type == "Mage" {
                            print("IMPOSSIBLE DE SELECTIONNER LE MAGE, IL NE PEUT QUE SOIGNIER\n")
                            validationMage = false
                        }
                    } while !validation
                    
                    // on affecte le résultat de openingTrunk à la propriété "force_d'attaque" du Soldier1 préalablement envoyé
                    if validationMage {
                        soldier1 = openingTrunk(soldier: soldier1, choice: choice)
                    }
                    
                    repeat {
                        if validationMage {
                            print("\nCHOISI UN PERSONNAGE DE L'AUTRE EQUIPE... ")
                            if numberGamer == 1 {
                                viewTeam(team: team2, numberGamer: 2)
                            } else {
                                viewTeam(team: team1, numberGamer: 1)
                            }
                            soldier2 = displayMenu(team: teamSwap2)
                            if soldier2.numberPointsOfLive <= 0 {
                                print("Impossible de le sélectionner, il est HS")
                                validation = false
                            }
                        }
                    } while !validation
                    
                    if validationMage {
                        print("====================================")
                        print("Tu viens de sélectionner \(soldier1.nameSoldier) avec comme points d'attaque \(soldier1.numberPointsOfAttack)")
                        print("Tu viens de sélectionner \(soldier2.nameSoldier) avec comme points de vie \(soldier2.numberPointsOfLive)")
                        print("====================================\n")
                    }
                    if validationMage {
                        if soldier1.numberPointsOfAttack > soldier2.numberPointsOfLive {
                            if numberGamer == 1 && validation && validationMage {
                                maxPointOfLiveTeam2 -= soldier2.numberPointsOfLive
                            }
                            if numberGamer == 2 && validation && validationMage {
                                maxPointOfLiveTeam1 -= soldier2.numberPointsOfLive
                            }
                            soldier2.numberPointsOfLive = 0
                        }
                        else {
                            soldier2.numberPointsOfLive -= soldier1.numberPointsOfAttack
                            
                            if numberGamer == 1 && validation && validationMage{
                                maxPointOfLiveTeam2 -= soldier1.numberPointsOfAttack
                            }
                            if numberGamer == 2 && validation && validationMage{
                                maxPointOfLiveTeam1 -= soldier1.numberPointsOfAttack
                            }
                        }
                        displayBattleResul()
                    }
                    // Retour de la force de frappe initiale
                    soldier1.numberPointsOfAttack = initialForce
                }
            }
            
            if choice == "2" {
                var validChoiceMage = false
                validation = true
                // Cette boucle a pour mission de controler la présence de Mage dans l'équipe et si celui-ci est encore en vie
                for i in 0...4 {
                    if teamSwap1[i]?.type == "Mage" {
                        soldier2 = teamSwap1[i]!
                        validChoiceMage = true
                        if soldier2.numberPointsOfLive == 0 {
                            validChoiceMage = false
                        }
                    }
                }
                if !validChoiceMage {
                    print("Tu n'as pas de Mage dans ton équipe en état d'agir. ")
                    validation = false
                } else {
                    //Capter la valeur initial du soldat sélectionné
                    initialForce = soldier2.numberPointsOfAttack
                    soldier2 = openingTrunk(soldier: soldier2, choice: choice)
                    
                    print("Choisi le personnage à soignier ")
                    if numberGamer == 1 {
                        viewTeam(team: team1, numberGamer: 1)
                    }
                    if numberGamer == 2 {
                        viewTeam(team: team2, numberGamer: 2)
                    }
                    
                    soldier1 = displayMenu(team: teamSwap1)
                    
                    for (typeSoldier, numberPointOfLive) in numberPointOfLiveGame {
                        if typeSoldier == soldier1.type {
                            // récupération du nombre maxi de point de vie selon le type de soldat
                            maxNumberOfLive = numberPointOfLive
                        }
                    }
                    if soldier1.numberPointsOfLive == maxNumberOfLive {
                        print("Voici le nombre de point de \(soldier1.numberPointsOfLive)")
                        print("Inutile de le soignier il est en pleine forme ")
                        validation = false
                    }
                    if soldier1.numberPointsOfLive <= 0 {
                        print("Tu arrives trop tard le soldat est H.S. \n")
                        validation = false
                    } else {
                        soldier1.numberPointsOfLive += soldier2.numberPointsOfAttack
                    }
                    if numberGamer == 1 && validation {
                        maxPointOfLiveTeam1 += soldier2.numberPointsOfAttack
                    }
                    if numberGamer == 2 && validation {
                        maxPointOfLiveTeam2 += soldier2.numberPointsOfAttack
                    }
                    
                    if validation {
                        print("Voici le résultat du soin du \(soldier2.type) il a ajouté \(soldier2.numberPointsOfAttack) points de vie ")
                        displayBattleResul()
                    }
                    
                    // Retour de la force de frappe initiale
                    soldier2.numberPointsOfAttack = initialForce
                }
            }
        }
        
        repeat {
            // numberTurn comptabilise le nombre de tour pour informer le gagnant en fin de partie
            numberTurn += 1
            // turnNumber maintient trois cycles
            var controle = true
            print("\n======================================"
                + "\nGAMER\(gamer) VEUX-TU COMBATTRE OU SOIGNIER ? "
                + "\n======================================"
                + "\nTape : 1 pour combattre"
                + "\nTape : 2 pour soignier")
            if let choice = readLine() {
                switch choice {
                case "1":
                    choiceSoldier(choice: choice, numberGamer: gamer, team1: team1, team2: team2)
                    
                case "2":
                    choiceSoldier(choice: choice, numberGamer: gamer, team1: team1, team2: team2)
                default:
                    print("Je ne comprends pas.")
                    controle = false
                }
            }
            
            if gamer == 1 && controle {
                gamer = 2
            } else {
                gamer = 1
            }
            
        } while maxPointOfLiveTeam1 != 0 && maxPointOfLiveTeam2 != 0
        
        if maxPointOfLiveTeam1 <= 0 {
            print(banner2)
            print("Bravo l'équipe deux as gagné !!!")
            print("Il aura fallut \(numberTurn) tours pour remporter le combat...")
            print(banner3)
        }
        if maxPointOfLiveTeam2 <= 0 {
            print(banner2)
            print("Bravo l'équipe une as gagné !!!")
            print("Il aura fallut \(numberTurn) tours pour remporter le combat...")
            print(banner3)
        }
    }
    
    //========================================
    //              MENU DE DEMARRAGE
    //========================================
    
    for _ in 0...1 {
        if numberGamer == 1
        {
            print("\n"
                + "        " + banner)
        }
        else {
            print("\n"
                + "        " + banner1)
        }
        
        print("\nSELECTIONNE 4 SOLDATS PARMI CEUX LISTÉS CI-DESSOUS...")
        if numberGamer == 2 {
            numberTime = 0
        }
        repeat {
            
            print("\nQuel personnage numéro \(numberTime+1) veux-tu dans ton équipe :"
                + "\n--------------------------------------------------"
                + "\nTape : 1 pour avoir un Combattant avec 100 points de vie et 10 de force "
                + "\nTape : 2 pour avoir un   Mage     avec  80 points de vie et 10 de force "
                + "\nTape : 3 pour avoir un  Colosse   avec 120 points de vie et  7 de force "
                + "\nTape : 4 pour avoir un   Nain     avec  60 points de vie et 15 de force "
                + "\nTape : 5 pour avoir un Cavalier   avec 200 points de vie et 25 de force")
            
            if let choice = readLine() {
                var choiceSoldierTeam = 0
                if Int(choice) != nil {
                    choiceSoldierTeam = Int(choice)!
                }
                if choiceSoldierTeam <= 5 && choiceSoldierTeam > 0 {
                    print("\nComment veux-tu l'appeler ?")
                    repeat {
                        
                        if let name = readLine() {
                            check = false
                            warriorName = name
                            check = checkName(name: warriorName)
                        }
                    } while check == true && check == false
                    
                    switch choice {
                    case "1":
                        if check == false {
                            recordName(numberGamer: numberGamer, name: warriorName, typeWarrior: "Combattant", numberTime: numberTime, numberPointsOfLive: 100, numberPointsOfAttack: 10, check: check)
                        }
                    case "2":
                        if check == false {
                            recordName(numberGamer: numberGamer, name: warriorName, typeWarrior: "Mage", numberTime: numberTime, numberPointsOfLive: 80, numberPointsOfAttack: 10, check: check)
                        }
                        
                    case "3":
                        if check == false {
                            recordName(numberGamer: numberGamer, name: warriorName, typeWarrior: "Colosse", numberTime: numberTime, numberPointsOfLive: 120, numberPointsOfAttack: 7, check: check)
                        }
                    case "4":
                        if check == false {
                            recordName(numberGamer: numberGamer, name: warriorName, typeWarrior: "Nain", numberTime: numberTime, numberPointsOfLive: 60, numberPointsOfAttack: 15, check: check)
                        }
                    case "5":
                        if check == false {
                            recordName(numberGamer: numberGamer, name: warriorName, typeWarrior: "Cavalier", numberTime: numberTime, numberPointsOfLive: 200, numberPointsOfAttack: 25, check: check)
                        }
                    default:
                        print("Je ne comprends pas.")
                        numberTime -= 1
                    }
                    
                }
                else {
                    print("La valeur doit être comprise entre 1 et 5 ")
                    numberTime -= 1
                }
                numberTime += 1
            }
        } while numberTime < 4
        numberGamer += 1
    }
    game()
}
 
 gameMenu()

 
 */
