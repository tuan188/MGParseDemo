//
//  ProductService.swift
//  MGParseDemo
//
//  Created by Tuan Truong on 8/26/15.
//  Copyright (c) 2015 Tuan Truong. All rights reserved.
//

import UIKit

class ProductService: NSObject {
    let productRepository = ProductRepository()
    
    func addProduct(productDto: ProductDto) {
        productRepository.addProduct(productDto)
    }
    
    func updateProduct(productDto: ProductDto) {
        productDto.modificationDate = NSDate()
        productDto.status = ProductStatus.Updated
        productRepository.updateProduct(productDto)
    }
    
    func addOrUpdateProduct(productDto: ProductDto) {
        if isProductExistedForId(productDto.id) {
            productRepository.updateProduct(productDto)
        }
        else {
            productRepository.addProduct(productDto)
        }
    }
    
    func deleteProduct(productDto: ProductDto) {
        productDto.modificationDate = NSDate()
        productDto.status = ProductStatus.Deleted
        productRepository.updateProduct(productDto)
    }
    
    func isProductExistedForId(id: String) -> Bool {
        return productRepository.isProductExistedForId(id)
    }
    
    func getAllProducts(includeDeletedProduct: Bool = false) -> [ProductDto] {
        return productRepository.getAllProducts(includeDeletedProduct)
    }
    
    func mostRecentUpdatedDate() -> NSDate? {
        return productRepository.mostRecentUpdatedDate()
    }
    
    func getProductsUpdatedAfterDate(date: NSDate) -> [ProductDto] {
        return productRepository.getProductsUpdatedAfterDate(date)
    }
}
