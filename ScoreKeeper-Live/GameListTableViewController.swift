//
//  GameListTableViewController.swift
//  ScoreKeeper-Live
//
//  Created by Taylor Mott on 20-Jul-17.
//  Copyright © 2017 Mott Applications. All rights reserved.
//

import UIKit

class GameListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GameController.shared.games.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gameCell", for: indexPath)
        
        let game = GameController.shared.games[indexPath.row]

        cell.textLabel?.text = game.name
        cell.detailTextLabel?.text = game.dateAsString

        return cell
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toGameDetail" {
            if let cell = sender as? UITableViewCell,
                let indexPath = tableView.indexPath(for: cell) {
                
                let game = GameController.shared.games[indexPath.row]
                let gameDetailTableViewController = segue.destination as? GameDetailTableViewController
                
                gameDetailTableViewController?.game = game
            }
        }
    }
    
    // MARK: - Bar Button Methods
    
    @IBAction func addGameBarButtonTapped() {
        //create alert
        let alertController = UIAlertController(title: "Add New Game?", message: "Give your game a name!", preferredStyle: .alert)
        
        //add any text fields (optional)
        alertController.addTextField { (newTextField: UITextField) in
            newTextField.placeholder = "Game Name"
        }
        
        //add actions
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_: UIAlertAction) in
            if let textField = alertController.textFields?.first {
                let gameName = textField.text ?? ""
                
                GameController.shared.createGame(name: gameName)
                
                DispatchQueue.main.async(execute: {
                    self.tableView.reloadData()
                })
            }
        }))
        
        //present alert
        present(alertController, animated: true, completion: nil)
    }
    
}
