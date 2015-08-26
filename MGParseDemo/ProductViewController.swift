//
//  ProductViewController.swift
//  ParseDemo
//
//  Created by Truong Anh Tuan on 3/26/15.
//  Copyright (c) 2015 Truong Tuan. All rights reserved.
//

import UIKit

protocol ProductViewControllerDelegate: class {
    func productViewControllerDidAdd(product: ProductDto)
    func productViewControllerDidUpdate(product: ProductDto)
}

class ProductViewController: UITableViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var priceTextField: UITextField!
    
    var product: ProductDto!
    
    weak var delegate: ProductViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if product != nil {
            nameTextField.text = product.name
            priceTextField.text = "\(product.price)"
        }
        
        nameTextField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onSaveButtonClicked(sender: AnyObject) {
        var isUpdatingProduct = true
        if product == nil {
            product = ProductDto()
            isUpdatingProduct = false
        }
        product.name = nameTextField.text
        var string = NSString(string: priceTextField.text)
        product.price = string.floatValue
        product.modificationDate = NSDate()
        
        if !isUpdatingProduct {
            delegate?.productViewControllerDidAdd(product)
        }
        else {
            delegate?.productViewControllerDidUpdate(product)
        }
        
        dismissView()
    }
    
    @IBAction func onCancelButtonClicked(sender: AnyObject) {
        dismissView()
    }
    
    private func dismissView() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
}
