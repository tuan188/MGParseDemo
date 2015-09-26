//
//  ProductRepository.swift
//  MGParseDemo
//
//  Created by Tuan Truong on 8/25/15.
//  Copyright (c) 2015 Tuan Truong. All rights reserved.
//

import UIKit

class ProductRepository: NSObject {
    func addProduct(productDto: ProductDto) {
        MagicalRecord.saveWithBlockAndWait { (context) -> Void in
            let product = Product.MR_createEntityInContext(context)
            Mapper.mapFromProductDto(productDto, toProduct: product)
        }
    }
    
    func updateProduct(productDto: ProductDto) {
        MagicalRecord.saveWithBlockAndWait { (context) -> Void in
            let predicate = NSPredicate(format: "id = '\(productDto.id)'")
            let product = Product.MR_findFirstWithPredicate(predicate, inContext: context)
            if product != nil {
                Mapper.mapFromProductDto(productDto, toProduct: product)
            }
        }
    }
    
    func deleteProductById(id: String) {
        MagicalRecord.saveWithBlockAndWait { (context) -> Void in
            let predicate = NSPredicate(format: "id = '\(id)'")
            let product = Product.MR_findFirstWithPredicate(predicate, inContext: context)
            if product != nil {
                Product.MR_deleteAllMatchingPredicate(predicate, inContext: context)
            }
        }
    }
    
    func count() -> Int {
        return Int(Product.MR_countOfEntities())
    }
    
    func getAllProducts() -> [ProductDto] {
        let products = Product.MR_findAll() as! [Product]
        var productDtos = [ProductDto]()
        
        for product in products {
            let productDto = Mapper.productDtoFromProduct(product)
            productDtos.append(productDto)
        }
        return productDtos
    }
    
    func mostRecentUpdatedDate() -> NSDate? {
        if let products = Product.MR_findAllSortedBy("modification_date", ascending: false) as? [Product] {
            if products.count > 0 {
                return products[0].modification_date
            }
        }
        
        return nil
    }
    
    func getProductsUpdatedAfterDate(date: NSDate) -> [ProductDto] {
        let predicate = NSPredicate(format: "modification_date > %@", date)
        let products = Product.MR_findAllSortedBy("modification_date", ascending: true, withPredicate: predicate) as! [Product]
        var productDtos = [ProductDto]()
        
        for product in products {
            let productDto = Mapper.productDtoFromProduct(product)
            productDtos.append(productDto)
        }
        return productDtos
    }
}
