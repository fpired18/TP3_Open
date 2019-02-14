//
//  PartOfGame.swift
//  TP3
//
//  Created by Frédéric on 07/02/2019.
//  Copyright © 2019 fpired. All rights reserved.
//

import Foundation
// the class PartOfGame defines the object part
class PartOfGame {
    
    var team1 = Teams()
    var team2 = Teams()
    var soldier1 = Teams()
    var soldier2 = Teams()
    var maxPointOfLiveTeam1 = 0
    var maxPointOfLiveTeam2 = 0
    var numberTime = 0
    var choiseInIntSwap1 = 0
    var choiseInInt1 = 0
    var choiseInInt2 = 0
    var numberGamer = 1
    var validation = true
    var numberPointOfLiveGame = ["fight" : 100, "magus": 80, "colossus": 120, "dwarf": 60, "rider": 150]
    var oneTime = 0
    
    func viewTeam(team: Teams, gamerNumber: Int) {
// This function display the teams
        let team = team
        var maxPointOfLiveTeamSwap = 0
        var oneTime = 1
        if gamerNumber == 1 {
           maxPointOfLiveTeamSwap = maxPointOfLiveTeam1
        } else {
            maxPointOfLiveTeamSwap = maxPointOfLiveTeam2
        }
        
        if oneTime == 1 {
            print("\nHere are the team members: \(gamerNumber) ")
            print("------------------------------")
            for i in 0..<team.team.count {
                print("Step :", i+1, "to have", team.team[i].nameSoldier, "is a", team.team[i].type , "who has",team.team[i].numberPointsOfLive ,"life and", team.team[i].numberPointsOfAttack , "attack")
                oneTime += 1
            }
                print("-----------------------------------------------")
                print("The number of life points of team \(gamerNumber) is to: \(maxPointOfLiveTeamSwap)")
                print("-----------------------------------------------")
        }
    }
    
    func displayBattleResul() {
        print("\n====================================================")
        print("Here is the number of life points of the team 1: \(maxPointOfLiveTeam1)\n"
            + "    and the number of life points of the team 2: \(maxPointOfLiveTeam2)\n"
            + "====================================================")
    }
    
    func displayMenu(team: Teams, gamerNumber: Int, oneTime: Int) -> Teams {

        validation = true
        let team = team
        let soldier = team
        
        if let choice = readLine() {
            choiseInIntSwap1 = Int(choice)! - 1
            switch choice {
            case "1":
                soldier.team[0] = team.team[0]
            case "2":
                soldier.team[1] = team.team[1]
            case "3":
                soldier.team[2] = team.team[2]
            default:
                print("I don't understand")
                validation = false
            }
        }
        if oneTime == 1 {
            choiseInInt1 = choiseInIntSwap1
        } else {
            choiseInInt2 = choiseInIntSwap1
        }
        
        return soldier
    }
    
    func openingTrunk(soldier: Teams, choice: String) -> Teams {
// Step 3 : We change the strength of the weapon in this function
        var chest = ["Club","Crossbow","Drugs","Injection","Doping"]
        let randomIndex = Int(arc4random_uniform(UInt32(chest.count)))
        let newWeapon = chest[randomIndex]
        var controle = 1
        print("\n===================================================================================")
        print("                        WATCH THE CHEST OPEN !!!!!!!")
        print("===================================================================================")
        
        print("\nHere is what came out of the chest: \(newWeapon).")
        switch soldier.team[choiseInInt1].type {
        case "magus":
            if choice == "2" {
                if newWeapon == "Drugs" || newWeapon == "Injection" {
                    soldier.team[choiseInInt1].numberPointsOfAttack *= 2
                }
            }
            else {
                controle += 1
            }
        case "rider":
            if newWeapon == "Doping" {
                soldier.team[choiseInInt1].numberPointsOfAttack *= 2
            }
        case "fight":
            if newWeapon == "Club" || newWeapon == "Crossbow" {
                soldier.team[choiseInInt1].numberPointsOfAttack *= 2
            }
        case "Colossus":
            if newWeapon == "Club" || newWeapon == "Crossbow" {
                soldier.team[choiseInInt1].numberPointsOfAttack *= 2
            }
        case "dwarf":
            if newWeapon == "Club" || newWeapon == "Crossbow" {
                soldier.team[choiseInInt1].numberPointsOfAttack *= 2
            }
        default:
            print("They are nothing ")
        }
        if controle == 1 {
            print("\nThis is the new soldier's strike force of \(soldier.team[choiseInInt1].type) is to: \(soldier.team[choiseInInt1].numberPointsOfAttack)"
                + "\n-----------------------------------------------------") // modifier
        }
        return soldier
    }
    
    func choiceSoldier(choice: String, numberGamer: Int, team1: Teams, team2: Teams){
// The soldier seledtion function inverts the team accordint to the palyer's number
        var teamSwap1 = team1
        var teamSwap2 = team2
        var soldierSwap1 = soldier1
        var soldierSwap2 = soldier2
        var maxPointOfLiveTeamSwap1 = 0
        var maxNumberOfLive = 0
        var initialForce = 0
        var numberGamerSwap1 = 0
        var numberGamerSwap2 = 0
        
        if numberGamer == 1 {
            teamSwap1 = team1
            teamSwap2 = team2
            soldierSwap1 = soldier1
            soldierSwap2 = soldier2
            maxPointOfLiveTeamSwap1 = maxPointOfLiveTeam2
            numberGamerSwap1 = numberGamer
            numberGamerSwap2 = 2
        }
        if numberGamer == 2 {
            teamSwap1 = team2
            teamSwap2 = team1
            soldierSwap1 = soldier2
            soldierSwap2 = soldier1
            maxPointOfLiveTeamSwap1 = maxPointOfLiveTeam1
            numberGamerSwap1 = numberGamer
            numberGamerSwap2 = 2
        }
        if choice == "1" {
            var validationMage = true
            var numberMage = 0
            // This function is ot count the number of mages in the team
            for i in 0...2 {
                if teamSwap1.team[i].type == "magus" {
                    numberMage += 1
                }
            }
            if numberMage == 3 {
                print("You only have mages in your team, you can't attack ! ")
                validationMage = false
            } else {

                repeat {
                    print("\nCHOOSE A MEMBER OF YOUR TEAM... ")
                    viewTeam(team: teamSwap1, gamerNumber: numberGamerSwap1)
                    
                    soldierSwap1 = displayMenu(team: teamSwap1, gamerNumber: numberGamerSwap1, oneTime: 1)
                    
                    // Here we capture the initial value of the attack of the soldier
                    initialForce = soldierSwap1.team[choiseInInt1].numberPointsOfAttack

                    if soldierSwap1.team[choiseInInt1].numberPointsOfLive <= 0 {
                        print("Can't select it is dead")
                        validation = false
                    }
                    if soldierSwap1.team[choiseInInt1].type == "magus" {
                        print("CAN NOT SELECT HIM TO FIGHT, HE CAN ONLY CARE \n")
                        validationMage = false
                    }
                } while !validation

                // The result af openingTrunk is safe to the "numberPointsOfAttack" property of the previously sent soldier
                if validationMage {
                    soldierSwap1 = openingTrunk(soldier: soldierSwap1, choice: choice)
                }

                repeat {
                    if validationMage {
                        print("\nCHOOSE A MEMBER OF THE OTHER TEAM... ")
                        viewTeam(team: teamSwap2, gamerNumber: numberGamerSwap2)
                        
                        soldierSwap2 = displayMenu(team: teamSwap2, gamerNumber: numberGamerSwap2, oneTime: 2)
                        if soldierSwap2.team[choiseInInt2].numberPointsOfLive <= 0 {
                            print("Can't select it is dead")
                            validation = false
                        }
                    }
                } while !validation

                if validationMage {
                    print("===============================================================")
                    print("You just selected \(soldierSwap1.team[choiseInInt1].nameSoldier) with numberPointsOfAttack property: \(soldierSwap1.team[choiseInInt1].numberPointsOfAttack)")
                    print("You just selected \(soldierSwap2.team[choiseInInt2].nameSoldier) with numberPointsOfLife property: \(soldierSwap2.team[choiseInInt2].numberPointsOfLive)")
                    print("===============================================================\n")
                }
                if validationMage {
                    if soldierSwap1.team[choiseInInt1].numberPointsOfAttack > soldierSwap2.team[choiseInInt2].numberPointsOfLive {
                        maxPointOfLiveTeamSwap1 -= soldierSwap2.team[choiseInInt2].numberPointsOfLive
                        soldierSwap2.team[choiseInInt2].numberPointsOfLive = 0
                    }
                    else {
                        soldierSwap2.team[choiseInInt2].numberPointsOfLive -= soldierSwap1.team[choiseInInt1].numberPointsOfAttack
                        maxPointOfLiveTeamSwap1 -= soldierSwap1.team[choiseInInt1].numberPointsOfAttack
                    }
                }
                
            // Return of the initial strike force
                soldierSwap1.team[choiseInInt1].numberPointsOfAttack = initialForce
            }
            if numberGamer == 1 {
                maxPointOfLiveTeam2 = maxPointOfLiveTeamSwap1
            } else {
                maxPointOfLiveTeam1 = maxPointOfLiveTeamSwap1
            }
            displayBattleResul()
        }
    
        if choice == "2" {
            validation = true
            // This loop has the mission to control the presence of a magus in the team and if it is still alive

            for i in 0...2 {
                if teamSwap1.team[i].type == "magus" {
                    choiseInInt1 = i
                }
            }
            
            if teamSwap1.team[choiseInInt1].numberPointsOfLive == 0 { //if !validChoiceMage {
                print("You don't have a magus in your team able to act ")
                validation = false
            } else {
                
                // Here we capture the initial value of the attack of the soldier
                initialForce = teamSwap1.team[choiseInInt1].numberPointsOfAttack
                teamSwap1 = openingTrunk(soldier: teamSwap1, choice: choice)

                print("\nChoose the person to look after ")

                viewTeam(team: teamSwap1, gamerNumber: numberGamerSwap1)

                soldierSwap2 = displayMenu(team: teamSwap1, gamerNumber: numberGamerSwap1, oneTime: 2)

                for (typeSoldier, numberPointOfLive) in numberPointOfLiveGame {
                    if typeSoldier == soldierSwap2.team[choiseInInt2].type {
                    // Recovery of the maximum number of life points of the soldier type
                        maxNumberOfLive = numberPointOfLive
                    }
                }
                if soldierSwap2.team[choiseInInt2].numberPointsOfLive == maxNumberOfLive {
                    print("No need to treat him he is in great shape ! ")
                    validation = false
                } else if soldierSwap2.team[choiseInInt2].numberPointsOfLive <= 0 {
                    print("You arrive too late, your soldier is dead \n")
                    validation = false
                } else if validation {
                    soldierSwap2.team[choiseInInt2].numberPointsOfLive += teamSwap1.team[choiseInInt1].numberPointsOfAttack
                }
                if numberGamer == 1 && validation {
                    maxPointOfLiveTeam1 += teamSwap1.team[choiseInInt1].numberPointsOfAttack
                }
                if numberGamer == 2 && validation {
                    maxPointOfLiveTeam2 += teamSwap1.team[choiseInInt1].numberPointsOfAttack
                }

                if validation {
                    print("Here is the result of the treatment \(teamSwap1.team[choiseInInt1].type) he added \(teamSwap1.team[choiseInInt1].numberPointsOfAttack) life")
                   displayBattleResul()
                }

                // Retunr of the initial strike
                teamSwap1.team[choiseInInt1].numberPointsOfAttack = initialForce
            }
        }
    }
}
