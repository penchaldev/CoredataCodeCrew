//
//  ViewController.swift
//  CoredataCodeCrew
//
//  Created by Penchal on 22/08/20.
//  Copyright © 2020 senix.com. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var peopleTableView: UITableView!
    var items: [Member]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchFromCoreData()
    }

    func fetchFromCoreData() {
        do {
            let request = Member.fetchRequest() as NSFetchRequest<Member>
            
            //Fiter
            let predicateFormat = NSPredicate(format: "name CONTAINS 'penchal'")
            let secondPredicate = NSPredicate(format: "name CONTAINS %@", "V")
            request.predicate = secondPredicate

            //Sorting
            let sort = NSSortDescriptor(key: "name", ascending: true)
            request.sortDescriptors = [sort]

            self.items = try context.fetch(request)
            DispatchQueue.main.async {
                self.peopleTableView.reloadData()
            }
        }
        catch {

        }
    }

    @IBAction func addPersonDetails(_ sender: Any) {
        let alert = UIAlertController(title: "Enter Person Details", message: "Enter Detaisl", preferredStyle: .alert)

        alert.addTextField()
        let textField = alert.textFields![0]

        let submitAction = UIAlertAction(title: "Submit", style: .default) { (submitAction) in
            print("Submit Action")

            let newPerson = Member(context: context)
            newPerson.name = textField.text
            newPerson.age = 25
            newPerson.gender = "Male"

            do {
                try context.save()
            }
            catch {
                print("Error")
            }
            self.fetchFromCoreData()
        }
        alert.addAction(submitAction)
        self.present(alert, animated: true, completion: nil)



    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Count: \(String(describing: items!.count))")
        return self.items?.count ?? 0

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let person = self.items![indexPath.row]
        cell.textLabel?.text = person.name
        cell.detailTextLabel?.text = "Age:\(person.age) "

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let action = UIAlertController(title: "Editing", message: "Edit the person details", preferredStyle: .alert)

        action.addTextField()
        let textField = action.textFields![0]
        var personToEdit = items![indexPath.row]

        textField.text = personToEdit.name

        let saveAction = UIAlertAction(title: "Save", style: .default) { (savePerson) in
            personToEdit.name = textField.text

            //Save
            do {
                try context.save()
            }
            catch {
                print("Saving Error")
            }
            //Fetch data
            self.fetchFromCoreData()


        }

        action.addAction(saveAction)
        self.present(action, animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHnadler) in
            //Which person to delete
            let personToDelete = self.items![indexPath.row]

            //Remove the person
            context.delete(personToDelete)

            //Save the data
            do {
                try context.save()
            }
            catch {
                print("Saving error")
            }

            //Fetch data
            self.fetchFromCoreData()
        }

        return UISwipeActionsConfiguration(actions: [action])
    }
}

