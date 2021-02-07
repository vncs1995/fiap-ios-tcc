//
//  RegisterStatesViewController.swift
//  Vinicius
//
//  Created by VINICIUS VIANA DOS SANTOS on 31/01/21.
//

import UIKit
import CoreData

class RegisterStatesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var states: [State] = []

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.register(StatesTableViewCell.nib(), forCellReuseIdentifier: StatesTableViewCell.identifier)
        tableView.delegate = self
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
            let state = self.states[indexPath.row]
            
            do {
                let objectsWithState = NSFetchRequest<NSFetchRequestResult>(entityName: "Product")
                objectsWithState.predicate = NSPredicate(format: "state == %@", state)
                
                let productsToDelete = try self.context.fetch(objectsWithState)
                
                for object in productsToDelete
                {
                    let managedObject:NSManagedObject = object as! NSManagedObject
                    self.context.delete(managedObject)
                }
                
                self.states.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)

                self.context.delete(state)
                try self.context.save()
            } catch {
                print("Erro ao deletar o estado")
            }
            
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
        let cell = tableView.dequeueReusableCell(withIdentifier: StatesTableViewCell.identifier, for: indexPath) as! StatesTableViewCell

        // Configure the cell...
        cell.configure(_title: states[indexPath.row].name!, _subTitle: String(states[indexPath.row].tax))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedState = states[indexPath.row]
        let alertController = UIAlertController(title: "Estado selecionado", message: "", preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.text = selectedState.name
        }
        
        alertController.addTextField { (textField) in
            textField.text = String(selectedState.tax)
        }
        
        let saveAction = UIAlertAction(title: "Atualizar", style: .default, handler: { alert -> Void in
                if let nameField = alertController.textFields?[0], let taxField = alertController.textFields?[1] {
                    if nameField.text!.count > 0 && taxField.text!.count > 0 {
                        selectedState.name = nameField.text
                        selectedState.tax = Float(taxField.text!)!
                    }
                }
            
            do{
                try self.context.save()
                self.getAllStates()
            } catch {}
        }
        )
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: {(action : UIAlertAction!) -> Void in })
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
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
