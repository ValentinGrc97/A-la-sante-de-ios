//
//  utils.h
//  A la santé de
//
//  Created by Valentin on 04/04/2019.
//  Copyright © 2019 Valentin Garcia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#ifndef utils_h
#define utils_h

@class AppDelegate;

@interface NSString (extended)
-(NSString*)without:(NSString*)stringToreplace;
-(UIColor*)color;
-(NSString*)str;
@end

@interface utils : NSObject
AppDelegate* getAppdelegate(void);
@end

#endif /* utils_h */
