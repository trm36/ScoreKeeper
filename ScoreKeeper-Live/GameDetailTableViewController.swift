//
//  GameDetailTableViewController.swift
//  ScoreKeeper-Live
//
//  Created by Taylor Mott on 20-Jul-17.
//  Copyright © 2017 Mott Applications. All rights reserved.
//

import UIKit

class GameDetailTableViewController: UITableViewController, PlayerScoreTableViewCellDelegate {
    
    var game: Game?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = game?.name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return game?.players?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath) as! PlayerScoreTableViewCell
        
        let player = game?.players?.array[indexPath.section] as? Player

        cell.updateViews(with: player)
        cell.delegate = self
        
        return cell
    }
    
    // MARK: - Cell Delegate Methods
    
    func stepperValueChanged(on cell: PlayerScoreTableViewCell) {
        if let indexPath = tableView.indexPath(for: cell),
            let player = game?.players?.array[indexPath.section] as? Player {
            let newScore = Int64(cell.scoreStepper.value)
            player.score = newScore
            GameController.shared.save()
        }
    }
    
    @IBAction func addPlayerButtonTapped() {
        //create alert
        let alertController = UIAlertController(title: "Add New Player?", message: "Give your player a name!", preferredStyle: .alert)

        //add any text fields (optional)
        alertController.addTextField { (newTextField: UITextField) in
            newTextField.placeholder = "Player Name"
        }
        
        //add actions
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_: UIAlertAction) in
            if let textField = alertController.textFields?.first {
                let playerName = textField.text ?? ""
                
                GameController.shared.createPlayer(name: playerName, score: 0, game: self.game)
                
                DispatchQueue.main.async(execute: {
                    self.tableView.reloadData()
                })
            }
        }))
        
        //present alert
        present(alertController, animated: true, completion: nil)
    }
}
