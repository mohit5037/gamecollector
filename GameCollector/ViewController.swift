//
//  ViewController.swift
//  GameCollector
//
//  Created by Mohit on 27/03/20.
//  Copyright © 2020 Practise. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var games : [Game] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            games = try context.fetch(Game.fetchRequest())
            tableView.reloadData()
        }catch{
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let game = games[indexPath.row]
        cell.textLabel?.text = game.title
        cell.imageView?.image = UIImage(data: game.image as! Data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let game = games[indexPath.row]
        performSegue(withIdentifier: "gameSegue", sender: game)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! GameViewController
        nextVC.game = sender as? Game
    }


}

