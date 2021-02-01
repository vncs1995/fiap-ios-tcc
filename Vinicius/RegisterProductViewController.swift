//
//  RegisterProductViewController.swift
//  Vinicius
//
//  Created by VINICIUS VIANA DOS SANTOS on 31/01/21.
//

import UIKit
import CoreData

class RegisterProductViewController: UIViewController {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    @IBOutlet weak var productName: UITextField!
    @IBOutlet weak var productValue: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func registerProduct(_ sender: Any) {
        let newItem = Product(context: context)
        newItem.name = productName.text
        newItem.price = Float(productValue.text!)!
        
        do{
            try context.save()
        } catch {
            
        }
    }
    
    @IBAction func navigateToRegisterState(_ sender: Any) {
        // TO-DO: Navigate to RegisterState
        
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
