//
//  Screen1.swift
//  A2_FA_IOS_sukhvir_c0785858
//
//  Created by user185614 on 2/1/21.
//


import UIKit
import CoreData

class Screen1: UIViewController {
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var searchBar : UISearchBar!
    var arrayP : [Products] = []
    let context =
        (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Products"
    }
    override func viewWillAppear(_ animated: Bool) {
        fetchDataFromDB()
    }
    
    func fetchDataFromDB(){
        arrayP = []
        arrayP = try! context.fetch(Products.fetchRequest())
        addProducts()
        tableView.reloadData()
    }
    func addProducts(){
        
        
        if arrayP.isEmpty{
            let provider = Providers(context: context)
            let provider2 = Providers(context: context)
            for i in 1...10{
                let product  = Products(context: context)
                product.product_desc = "Best Phones"
                product.product_id = "\(i)"
                
                product.product_price = "\(i)000"
                
                if i%2 == 0 {
                    provider.provider_name = "Apple"
                    product.product_name = "iPhone \(i)"
                    product.provider = provider
                }
                else{
                    provider2.provider_name = "Samsung"
                    product.product_name = "S \(i)"
                    product.provider = provider2
                }
                
                
            }
            try! context.save()
            fetchDataFromDB()
        }
        
    }
    
   
}
extension Screen1 : UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            var predicate: NSPredicate = NSPredicate()
            predicate = NSPredicate(format: "product_name contains[c] '\(searchText)' || product_desc contains[c] '\(searchText)'")
            let fetchRequest : NSFetchRequest<Products> = Products.fetchRequest()
            fetchRequest.predicate = predicate
            do {
                arrayP = try context.fetch(fetchRequest)
            } catch let error as NSError {
                print("Could not fetch. \(error)")
            }
        }
        else{
            fetchDataFromDB()
            
        }
        tableView.reloadData()
    }
    
}
extension Screen1 : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
            return arrayP.count
       
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
       
            cell.textLabel?.text =
                arrayP[indexPath.row].product_name
            cell.detailTextLabel?.text = arrayP[indexPath.row].provider?.provider_name
        
        
        return cell
    }
    
    
}
extension Screen1 : UITableViewDelegate{
     
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            
                let objc = arrayP[indexPath.row]
                context.delete(objc)
                try! context.save()
                fetchDataFromDB()
            
        }
    }
}
