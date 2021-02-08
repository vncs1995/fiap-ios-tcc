//
//  TotalPurchaseViewController.swift
//  Vinicius
//
//  Created by VINICIUS VIANA DOS SANTOS on 31/01/21.
//

import UIKit

class TotalPurchaseViewController: UIViewController {
    
    @IBOutlet weak var totalinUS: UILabel!
    @IBOutlet weak var totalinRS: UILabel!
    var products: [Product] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getAllProducts()
    }
    
    func getAllProducts() {
        do{
            let currency: Float = UserDefaults.standard.float(forKey: "usd_currency")
            let iof: Float = UserDefaults.standard.float(forKey: "iof_preference")
            products = try context.fetch(Product.fetchRequest())
            let totalInUS = products.reduce(0) { $0 + $1.price }
            totalinUS.text = String(totalInUS)
            var totalInRS: Float = 0
            
            for product in products {
                var productPrice: Float = product.price
                productPrice += product.price * (product.state!.tax / 100)
                                
                if product.creditCard { productPrice += productPrice * (iof / 100) }
                
                print("currency \(productPrice) * \(productPrice * currency) =")

                productPrice = productPrice * currency
                print(productPrice)
                
                totalInRS += productPrice
            }
            
            totalinRS.text = String(totalInRS)
           
        } catch {
            print("Erro no tableView")
        }
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
