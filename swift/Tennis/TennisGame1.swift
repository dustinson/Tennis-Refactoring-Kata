import Foundation


class Player {
    let name: String
    var scorePoint: Int = 0

    init(name: String) {
        self.name = name
    }

    func increasePoints() {
        scorePoint+=1
    }
}

class Players {
    let player1: Player
    let player2: Player

    init(player1: Player,
         player2: Player) {
        self.player1 = player1
        self.player2 = player2
    }
    
    func calculateScorePoint(_ playerName: String) {
        getPlayer(playerName).increasePoints()
    }

    func getPlayer(_ playerName: String)-> Player{
        return (playerName == player1.name) ? player1 : player2
    }
}

class TennisGame1: TennisGame {
    private var players: Players

    required init(player1: String,
                  player2: String) {
        players = Players(player1: Player(name: player1),
                          player2: Player(name: player2))
    }

    var score: String? {
        if isTie() {
            return showTieMessage(currentScorePoint: players.player1.scorePoint)
        } else if isWinning() {
            return showWinningMessage()
        }
        return scoreLogic()
    }

    func wonPoint(_ playerName: String) {
        players.calculateScorePoint(playerName)
    }

    private func getLeadingPlayerName() -> String {
        return players.player1.scorePoint > players.player2.scorePoint ? players.player1.name : players.player2.name
    }

    private func showWinningMessage() -> String {
        return abs(scoreDifferential()) == 1 ? "Advantage \(getLeadingPlayerName())" : "Win for \(getLeadingPlayerName())"
    }

    private func scoreDifferential() -> Int {
        return players.player1.scorePoint-players.player2.scorePoint
    }

    fileprivate func scoreLogic() -> String {
        return scoreName(players.player1.scorePoint) + "-" + scoreName(players.player2.scorePoint)
    }

    fileprivate func showTieMessage(currentScorePoint: Int) -> String {
        return currentScorePoint>2
            ? "Deuce"
            : scoreName(currentScorePoint) + "-All"
    }

    

    fileprivate func isWinning() -> Bool {
        return players.player1.scorePoint>=4 || players.player2.scorePoint>=4
    }

    

    fileprivate func isTie() -> Bool {
        return players.player1.scorePoint == players.player2.scorePoint
    }

    fileprivate func scoreName(_ tempScore: Int) -> String {
        switch tempScore {
        case 0:
            return "Love"

        case 1:
            return "Fifteen"

        case 2:
            return "Thirty"

        case 3:
            return "Forty"

        default:
            return ""
        }
    }
}
