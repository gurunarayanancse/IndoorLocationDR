//
//  UIImage+Mist.h
//  Mist
//
//  Created by Cuong Ta on 7/7/15.
//  Copyright (c) 2015 Mist. All rights reserved.
//

#import <UIKit/UIKit.h>
__attribute__((deprecated("Don't use this")))
@interface UIImage (Mist)

@property (nonatomic,readonly) double ratio;

-(instancetype)getImageAtScale:(double)scale;

@end
