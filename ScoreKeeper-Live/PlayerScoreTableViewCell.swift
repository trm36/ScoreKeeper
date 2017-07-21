//
//  PlayerScoreTableViewCell.swift
//  ScoreKeeper-Live
//
//  Created by Taylor Mott on 20-Jul-17.
//  Copyright © 2017 Mott Applications. All rights reserved.
//

import UIKit

protocol PlayerScoreTableViewCellDelegate: class {
    func stepperValueChanged(on cell: PlayerScoreTableViewCell)
}

class PlayerScoreTableViewCell: UITableViewCell {
    
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var scoreStepper: UIStepper!
    
    weak var delegate: PlayerScoreTableViewCellDelegate?
    
    @IBAction func scoreStepperValueChanged(_ sender: UIStepper) {
        scoreLabel.text = "\(Int(sender.value))"
        delegate?.stepperValueChanged(on: self)
    }
    
    func updateViews(with player: Player?) {
        if let player = player {
            self.playerNameLabel.text = player.name
            self.scoreLabel.text = "\(player.score)"
            self.scoreStepper.value = Double(player.score)
        } else {
            clearViews()
        }
    }
    
    func clearViews() {
        self.playerNameLabel.text = ""
        self.scoreLabel.text = "0"
        self.scoreStepper.value = 0
    }

}
