//
//  ProductsTableViewController.swift
//  Vinicius
//
//  Created by VINICIUS VIANA DOS SANTOS on 31/01/21.
//

import UIKit
import CoreData

class ProductsTableViewController: UITableViewController {

    let cellReuseIdentifier = "Products"
    var products: [Product] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getAllProducts()
        tableView.reloadData()
    }
    
    func getAllProducts() {
        do{
            products = try context.fetch(Product.fetchRequest())
            if products.count == 0 {
                self.tableView.setEmptyMessage("Sua lista está vazia!")
            } else {
                self.tableView.restore()
            }
        } catch {
            print("Erro no tableView")
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) 

        cell.textLabel?.text = products[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = products[indexPath.row]
        let viewController = storyboard?.instantiateViewController(withIdentifier: "RegisterProduct") as! RegisterProductViewController
    
        viewController.productFromList = product
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension UITableView {

    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }

    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
