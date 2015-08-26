//
//  ProductParseClient.swift
//  MGParseDemo
//
//  Created by Tuan Truong on 8/26/15.
//  Copyright (c) 2015 Tuan Truong. All rights reserved.
//

import UIKit
import Parse

class ProductParseClient: NSObject {
    func addProduct(product: ProductDto) {
        var obj = PFObject(className: "Product")
        obj.setObject(product.id, forKey: "id")
        obj.setObject(product.creationDate, forKey: "creationDate")
        obj.setObject(product.modificationDate, forKey: "modificationDate")
        obj.setObject(product.name, forKey: "name")
        obj.setObject(product.price, forKey: "price")
        obj.save()
    }
    
    func updateProduct(product: ProductDto) {
        var query = PFQuery(className: "Product")
        query.whereKey("id", equalTo: product.id)
        if let objects = query.findObjects() {
            for obj in objects {
                obj.setObject(product.modificationDate, forKey: "modificationDate")
                obj.setObject(product.name, forKey: "name")
                obj.setObject(product.price, forKey: "price")
                obj.save()
            }
        }
    }
    
    func deleteProduct(productID: String) {
        var query = PFQuery(className: "Product")
        query.whereKey("id", equalTo: productID)
        if let objects = query.findObjects() {
            for obj in objects {
                obj.delete()
            }
        }
    }
    
    func count() -> Int {
        var query = PFQuery(className: "Product")
        return query.countObjects()
    }
    
    func getAllProducts() -> [ProductDto] {
        var products = [ProductDto]()
        var query = PFQuery(className: "Product")
        
        if let objects = query.findObjects() {
            for obj in objects {
                var product = ProductDto()
                product.id = obj.objectForKey("id") as! String
                product.name = obj.objectForKey("name") as! String
                product.price = obj.objectForKey("price") as! Float
                product.creationDate = obj.objectForKey("creationDate") as! NSDate
                product.modificationDate = obj.objectForKey("modificationDate") as! NSDate
                products.append(product)
            }
        }
        
        return products
    }
    
    func mostRecentUpdatedDate() -> NSDate? {
        var query = PFQuery(className: "Product")
        query.orderByDescending("modificationDate")
        if let obj = query.getFirstObject() {
            return obj.objectForKey("modificationDate") as? NSDate
        }
        return nil
    }
    
    func getProductsUpdatedAfterDate(date: NSDate) -> [ProductDto] {
        var products = [ProductDto]()
        var query = PFQuery(className: "Product")
        query.whereKey("modificationDate", greaterThan: date)
        
        if let objects = query.findObjects() {
            for obj in objects {
                var product = ProductDto()
                product.id = obj.objectForKey("id") as! String
                product.name = obj.objectForKey("name") as! String
                product.price = obj.objectForKey("price") as! Float
                product.creationDate = obj.objectForKey("creationDate") as! NSDate
                product.modificationDate = obj.objectForKey("modificationDate") as! NSDate
                products.append(product)
            }
        }
        
        return products
    }
}
