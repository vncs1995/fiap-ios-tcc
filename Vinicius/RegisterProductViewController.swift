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
    @IBOutlet weak var productPhoto: UIButton!
    @IBOutlet weak var productValue: UITextField!
    @IBOutlet weak var productState: UITextField!
    @IBOutlet weak var productCreditCard: UISwitch!
    @IBOutlet weak var submitButton: UIButton!
    var pickerView = UIPickerView()
    var states: [State] = []
    var selectedState: State?
    var productFromList: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        if let productFromList = productFromList {
            productName.text = productFromList.name
            if let photo = productFromList.photo {
                productPhoto.setImage(UIImage(data: photo), for: .normal)
            }
            productValue.text = String(productFromList.price)
            productState.text = productFromList.state?.name
            productCreditCard.setOn(productFromList.creditCard, animated: true)
            submitButton.setTitle("Atualizar", for: .normal)
        }
        pickerView.delegate = self
        pickerView.dataSource = self
        productState.inputView = pickerView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        getAllStates()
    }

    
    @IBAction func registerProduct(_ sender: Any) {
        if let updateProduct = productFromList {
            updateProduct.name = productName.text
            updateProduct.price = Float(productValue.text!)!
            updateProduct.photo = productPhoto.image(for: .normal)!.pngData()
            updateProduct.state = selectedState
            updateProduct.creditCard = productCreditCard.isOn
        } else {
            let newItem = Product(context: context)
            newItem.name = productName.text
            newItem.price = Float(productValue.text!)!
            newItem.photo = productPhoto.image(for: .normal)!.pngData()
            newItem.state = selectedState
            newItem.creditCard = productCreditCard.isOn
        }
        
        do{
            try context.save()
            navigationController?.popViewController(animated: true)
        } catch {
            
        }
    }
    
    func getAllStates() {
        do{
            states = try context.fetch(State.fetchRequest())
        } catch {
            print("Erro no tableView")
        }
    }
    
    @IBAction func selectProductImage(_ sender: Any) {
        let vc = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            vc.sourceType = .camera
        } else {
            vc.sourceType = .photoLibrary
        }
        vc.delegate = self
        present(vc, animated: true)
    }
    
    @IBAction func navigateToRegisterState(_ sender: Any) {
        // TO-DO: Navigate to RegisterState
        let viewController = storyboard?.instantiateViewController(withIdentifier: "RegisterStates") as! RegisterStatesViewController
        
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension RegisterProductViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerOriginalImage")] as? UIImage {
            productPhoto.setImage(image, for: .normal)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension RegisterProductViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return states.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return states[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        productState.text = states[row].name
        self.selectedState = states[row]
        productState.resignFirstResponder()
    }
}

