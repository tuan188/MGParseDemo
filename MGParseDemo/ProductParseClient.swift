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
        let obj = PFObject(className: "Product")
        obj.setObject(product.id, forKey: "id")
        obj.setObject(product.creationDate, forKey: "creationDate")
        obj.setObject(product.modificationDate, forKey: "modificationDate")
        obj.setObject(product.name, forKey: "name")
        obj.setObject(product.price, forKey: "price")
        obj.setObject(product.status.rawValue, forKey: "status")
        do {
            try obj.save()
        }
        catch {
            print("Save error!")
        }
    }
    
    func updateProduct(product: ProductDto) {
        let query = PFQuery(className: "Product")
        query.whereKey("id", equalTo: product.id)
        do {
            let objects = try query.findObjects()
            for obj in objects {
                obj.setObject(product.modificationDate, forKey: "modificationDate")
                obj.setObject(product.name, forKey: "name")
                obj.setObject(product.price, forKey: "price")
                obj.setObject(product.status.rawValue, forKey: "status")
                try obj.save()
            }
            
        }
        catch {
            print("Query error!")
        }
    }    
    
    func isProductExistedForId(id: String) -> Bool {
        let query = PFQuery(className: "Product")
        query.whereKey("id", equalTo: id)
        do {
            let objects = try query.findObjects()
            return objects.count > 0
        }
        catch {
            print("Query error!")
        }
        return false
    }
    
    func deleteProduct(productID: String) {
        let query = PFQuery(className: "Product")
        query.whereKey("id", equalTo: productID)
        do {
            let objects = try query.findObjects()
            for obj in objects {
                try obj.delete()
            }
        }
        catch {
            print("Delete object error!")
        }
        
    }
    
    func count() -> Int {
        let query = PFQuery(className: "Product")
        var count = -1
        var error: NSError?
        count = query.countObjects(&error)
        
        return count
    }
    
    func getAllProducts() -> [ProductDto] {
        var products = [ProductDto]()
        let query = PFQuery(className: "Product")
        
        do {
            let objects = try query.findObjects()
            products += productDtosFromPFObjects(objects)
        }
        catch {
            print("Get products error!")
        }
        
        return products
    }
    
    private func productDtosFromPFObjects(objects: [PFObject]) -> [ProductDto] {
        var products = [ProductDto]()
        for obj in objects {
            let product = ProductDto()
            product.id = obj.objectForKey("id") as! String
            product.name = obj.objectForKey("name") as! String
            product.price = obj.objectForKey("price") as! Float
            product.creationDate = obj.objectForKey("creationDate") as! NSDate
            product.modificationDate = obj.objectForKey("modificationDate") as! NSDate
            product.status = ProductStatus(rawValue: obj.objectForKey("status") as! Int)!
            products.append(product)
        }
        return products
    }
    
    func mostRecentUpdatedDate() -> NSDate? {
        let query = PFQuery(className: "Product")
        query.orderByDescending("modificationDate")
        do {
            let obj = try query.getFirstObject()
            return obj.objectForKey("modificationDate") as? NSDate
        }
        catch {
            print("Get most recent updated date error!")
        }
        
        return nil
    }
    
    func getProductsUpdatedAfterDate(date: NSDate) -> [ProductDto] {
        var products = [ProductDto]()
        let query = PFQuery(className: "Product")
        query.whereKey("modificationDate", greaterThan: date)
        
        do {
            let objects = try query.findObjects()
            products += productDtosFromPFObjects(objects)
        }
        catch {
            print("Get products error!")
        }
        return products
    }
    
}
