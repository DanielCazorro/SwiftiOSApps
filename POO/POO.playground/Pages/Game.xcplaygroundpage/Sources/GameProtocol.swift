import Foundation

public protocol GameProtocol {
    var name: String { get }
    
    func play(player1: Player, player2: Player) -> String
}
