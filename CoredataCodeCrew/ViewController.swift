//
//  ViewController.swift
//  CoredataCodeCrew
//
//  Created by Vijay on 22/08/20.
//  Copyright © 2020 senix.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var peopleTableView: UITableView!
    
    var items:[Member]?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetchFromCoreData()
    }

    @IBAction func addPersonDetails(_ sender: Any) {
        let alert = UIAlertController(title: "Enter Person Details", message: "Enter Detaisl", preferredStyle: .alert)
        
        alert.addTextField()
        let textField = alert.textFields![0]
        
        let submitAction = UIAlertAction(title: "Submit", style:.default) { (submitAction) in
            print("Submit Action")
        }
        alert.addAction(submitAction)
        self.present(alert, animated:true, completion:nil)

    }

    func fetchFromCoreData(){
        let newPerson = Member(context: context)
        newPerson.name = "Penchalreddy"
        newPerson.age = 25
        newPerson.gender = "Male"
        
        DispatchQueue.main.async {
            self.items?.append(newPerson)
            self.peopleTableView.reloadData()
        }
        
        do{
            try context.save()
        }
        catch {
            print("Error")
        }
    }
    
}


extension ViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Penchal"
        cell.detailTextLabel?.text = "Age: 25"
        print("Count is 10")
        return cell
    }
}

