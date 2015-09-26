//
//  ProductListViewController.swift
//  ParseDemo
//
//  Created by Truong Anh Tuan on 3/26/15.
//  Copyright (c) 2015 Truong Tuan. All rights reserved.
//

import UIKit

class ProductListViewController: UITableViewController, ProductViewControllerDelegate {
    
    var productService = ProductService()
    var products: [ProductDto]!
    
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    var syncButton: UIBarButtonItem!
    
    let syncService = SyncService()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        syncButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Refresh, target: self, action: Selector("onSyncButtonClicked:"))
        
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.navigationItem.leftBarButtonItems = [ addButton, syncButton ]
        
        products = productService.getAllProducts()
    }
    
    func onSyncButtonClicked(sender: AnyObject) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        syncService.sync()
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        
        products = productService.getAllProducts()
        
        tableView.reloadData()
        
        let alertView = UIAlertView(title: "Sync completed!", message: nil, delegate: nil, cancelButtonTitle: "OK")
        alertView.show()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onAddButtonClicked(sender: AnyObject) {
        self.performSegueWithIdentifier("showProduct", sender: nil)
    }
    

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if self.editing {
            let product = products[indexPath.row]
            self.performSegueWithIdentifier("showProduct", sender: product)
        }
    }

  
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ProductCell", forIndexPath: indexPath) 
        
        let product = products[indexPath.row]
        cell.textLabel?.text = product.name
        cell.detailTextLabel?.text = "$\(product.price)"
        
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let product = products[indexPath.row]
            productService.deleteProduct(product)
            
            var row = -1
            for (index, value) in products.enumerate() {
                if value.id == product.id {
                    row = index
                    break
                }
            }
            if row != -1 {
                products.removeAtIndex(row)
            }
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
 
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showProduct" {
            let controller = (segue.destinationViewController as! UINavigationController).topViewController as! ProductViewController
            if let product = sender as? ProductDto {
                controller.product = product
            }
            
            controller.delegate = self
        }
    }
    
    // MARK: - ProductViewControllerDelegate
    
    func productViewControllerDidAdd(product: ProductDto) {
        productService.addProduct(product)
        products.append(product)
        tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: products.count - 1, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Automatic)
    }
    
    func productViewControllerDidUpdate(product: ProductDto) {
        productService.updateProduct(product)
        var row = -1
        for (index, value) in products.enumerate() {
            if value.id == product.id {
                row = index
                break
            }
        }
        if row != -1 {
            tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: row, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
}
