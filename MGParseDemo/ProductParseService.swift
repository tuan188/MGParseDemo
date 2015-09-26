//
//  ProductParseService.swift
//  MGParseDemo
//
//  Created by Tuan Truong on 9/26/15.
//  Copyright © 2015 Tuan Truong. All rights reserved.
//

import UIKit

class ProductParseService: NSObject {
    let productParseClient = ProductParseClient()
    
    func mostRecentUpdatedDate() -> NSDate? {
        return productParseClient.mostRecentUpdatedDate()
    }
    
    func getProductsUpdatedAfterDate(date: NSDate) -> [ProductDto] {
        return productParseClient.getProductsUpdatedAfterDate(date)
    }
    
    func addProduct(product: ProductDto) {
        productParseClient.addProduct(product)
    }
    
    func addOrUpdateProduct(product: ProductDto) {
        if productParseClient.isProductExistedForId(product.id) {
            productParseClient.updateProduct(product)
        }
        else {
            productParseClient.addProduct(product)
        }
    }
    
    func getAllProducts() -> [ProductDto] {
        return productParseClient.getAllProducts()
    }
}
