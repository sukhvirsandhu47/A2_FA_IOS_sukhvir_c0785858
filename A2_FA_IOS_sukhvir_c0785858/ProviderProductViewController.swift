//
//  GetProductsTableViewController.swift
//  A2_FA_ios_Baljeet_782220
//
//  Created by Mac on 01/02/21.
//

import UIKit
import CoreData

class ProviderProductViewController: UITableViewController {
    var provider : Providers?
    var products : [Products] = []
    let context =
        (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        if let _ = provider{
            let req : NSFetchRequest<Products> =  Products.fetchRequest()
            products = try! context.fetch(req)
            products = products.filter({$0.provider?.provider_name == provider?.provider_name})
            tableView.reloadData()
        }
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text =
            products[indexPath.row].product_name
        cell.detailTextLabel?.text = products[indexPath.row].provider?.provider_name

        return cell
    }
    

}
