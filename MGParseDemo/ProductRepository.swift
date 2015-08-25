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
}
