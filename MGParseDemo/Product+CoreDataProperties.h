//
//  Product+CoreDataProperties.h
//  MGParseDemo
//
//  Created by Tuan Truong on 9/26/15.
//  Copyright © 2015 Tuan Truong. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Product.h"

NS_ASSUME_NONNULL_BEGIN

@interface Product (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *creation_date;
@property (nullable, nonatomic, retain) NSString *id;
@property (nullable, nonatomic, retain) NSDate *modification_date;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *price;
@property (nullable, nonatomic, retain) NSNumber *status;

@end

NS_ASSUME_NONNULL_END
