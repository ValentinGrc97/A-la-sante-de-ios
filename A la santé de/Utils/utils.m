//
//  utils.m
//  A la santé de
//
//  Created by Valentin on 04/04/2019.
//  Copyright © 2019 Valentin Garcia. All rights reserved.
//

#import "utils.h"
#include <ifaddrs.h>
#include <arpa/inet.h>
#include <sys/xattr.h>

@implementation NSString (extended)

-(NSString*)without:(NSString*)stringToreplace {
    return [self stringByReplacingOccurrencesOfString:stringToreplace withString:@""];
}

-(UIColor*)color {
    
    unsigned color = 0;
    NSScanner *scanner = [NSScanner scannerWithString:[self without:@"#"]];
    
    //[scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&color];
    
    float red = (color & 0xff0000) >> 16;
    float green = (color & 0x00ff00) >> 8;
    float blue = (color & 0x0000ff);
    
    return [UIColor colorWithRed:red/255. green:green/255. blue:blue/255. alpha:1];
    
}

-(NSString*)str {
    return NSLocalizedString(self, nil);
}

@end

@implementation utils

AppDelegate* getAppdelegate() {
    return [utils getAppDelegate];
}

+(id<UIApplicationDelegate>)getAppDelegate {
    return UIApplication.sharedApplication.delegate;
}

@end
