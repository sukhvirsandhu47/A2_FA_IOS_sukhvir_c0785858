//
//  AddProductTableViewController.swift
//  A2_FA_ios_Baljeet_782220
//
//  Created by Mac on 01/02/21.
//

import UIKit
import CoreData
class ProductViewController: UIViewController {
    let context =
            (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    @IBOutlet weak var id: UITextField!
    @IBOutlet weak var productName: UITextField!
    @IBOutlet weak var productDesc: UITextField!
    @IBOutlet weak var price: UITextField!
    @IBOutlet weak var txtProviderName: UITextField!
    var product : Products?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let pro = product{
            id.text = pro.product_id
            productName.text = pro.product_name
            productDesc.text = pro.product_desc
            price.text = pro.product_price
            txtProviderName.text = pro.provider?.provider_name
        }

    }

    @IBAction func save(_ sender: Any) {
        let req : NSFetchRequest<Providers> = Providers.fetchRequest()
        req.predicate = NSPredicate(format: "provider_name = '\(txtProviderName.text!)'")
        let storeProvider = try! context.fetch(req)
        var provider : Providers!
        if storeProvider.count == 0{
             provider = Providers(context: context)
             provider.provider_name = txtProviderName.text
        }
        else{
             provider = storeProvider[0]
        }
        if let pro = product{
            pro.product_desc = productDesc.text
            pro.product_id = id.text
            pro.product_name = productName.text
            pro.product_price = price.text
            pro.provider = provider
        }
        else{
            let pro = Products(context: context)
            pro.product_desc = productDesc.text
            pro.product_id = id.text
            pro.product_name = productName.text
            pro.product_price = price.text
            pro.provider = provider
        }
        try! context.save()
        self.navigationController?.popViewController(animated: true)
    }

}
