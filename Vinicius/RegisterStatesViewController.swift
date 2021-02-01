//
//  RegisterStatesViewController.swift
//  Vinicius
//
//  Created by VINICIUS VIANA DOS SANTOS on 31/01/21.
//

import UIKit
import CoreData

class RegisterStatesViewController: UIViewController, UITableViewDataSource {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var states: [State] = []

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "States")
        tableView.dataSource = self
        getAllStates()
    }
    
    func getAllStates() {
        do{
            states = try context.fetch(State.fetchRequest())
            tableView.reloadData()
        } catch {
            print("Erro no tableView")
        }
    }
    

    @IBAction func showAlertAddState(_ sender: Any) {
        let alertController = UIAlertController(title: "Adicionar Estado", message: "", preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Nome do estado"
        }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Imposto"
        }
        
        let saveAction = UIAlertAction(title: "Adicionar", style: .default, handler: { alert -> Void in
            let newItem = State(context: self.context)
                if let textField = alertController.textFields?[0] {
                    if textField.text!.count > 0 {
                        newItem.name = textField.text
                    }
                }
                if let textField = alertController.textFields?[1] {
                    if textField.text!.count > 0 {
                        newItem.tax = Float(textField.text!)!
                    }
                }
            
            do{
                try self.context.save()
                self.getAllStates()
            } catch {
                
            }
            
            })
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: {(action : UIAlertAction!) -> Void in })
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Deletar", handler: {(action, view, completionHandler) in
            completionHandler(true)
        })
        
        delete.image = UIImage(systemName: "trash")
        delete.backgroundColor = .red
        
        let swipe = UISwipeActionsConfiguration(actions: [delete])
        return swipe
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return states.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "States", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = states[indexPath.row].name
        cell.detailTextLabel?.text = String(states[indexPath.row].tax)
        return cell
    }
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
