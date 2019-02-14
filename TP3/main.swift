//  main.swift
//  Game
//
//  Created by Frédéric on 18/01/2019.
//  Copyright © 2019 fpired. All rights reserved.
//

import Foundation

private func gameMenu() {
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
        if newPartOfGame.numberGamer == 1 {
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

