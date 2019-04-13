//
//  BlockBasedSelector.h
//  sasheramed
//
//  Created by Aleksandr on 4/13/19.
//  Copyright © 2019 Aleksandr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BlockBasedSelector : NSObject

@end

typedef void (^OBJCBlock)(id foo);

void class_addMethodWithBlock(Class class, SEL newSelector, OBJCBlock block);
