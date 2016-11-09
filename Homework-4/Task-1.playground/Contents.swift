//: Playground - noun: a place where people can play


import Cocoa

let firstPlayerIndex = 0;
let secondPlayerIndex = 1;
let playersInTeamCount = 2;


var players = ["Ukraine", "Russia", "USA", "China", "Italy", "France", "Spain", "Germany", "England", "Ireland", "Norway", "Holland", "Poland", "Netherlands", "Iceland", "Portugal"]


players.count


var teams = [[String]](count:players.count/playersInTeamCount, repeatedValue:[String]())

for player in players {
    var isPlayerInTeam = true
    while (isPlayerInTeam) {
        var randomTeamIndex = Int(arc4random_uniform(UInt32(players.count/playersInTeamCount)))
        if teams[randomTeamIndex].count < playersInTeamCount {
            teams[randomTeamIndex].append(player)
            isPlayerInTeam = false
            teams.dropLast()
        }
    }
}


print(teams)