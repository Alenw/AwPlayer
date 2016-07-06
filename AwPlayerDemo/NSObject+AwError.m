//
//  NSObject+AwError.m
//  消息转发
//
//  Created by yelin on 16/6/11.
//  Copyright © 2016年 nero. All rights reserved.
//

#import "NSObject+AwError.h"
#import <objc/runtime.h>

void noneClassMethod(id self, SEL _cmd);

@interface NoneClass : NSObject

@end

@implementation NoneClass

@end

@implementation NSObject (AwError)

+(void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class=[self class];
        swizzleMethod(class,@selector(forwardingTargetForSelector:),@selector(AwError_forwardingTargetForSelector:));
    });
}
void swizzleMethod(Class class,SEL originalSelector,SEL swizzledSelector){
    Method originalMethod=class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod=class_getInstanceMethod(class, swizzledSelector);
    BOOL didAddMethod=class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }else{
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

-(id)AwError_forwardingTargetForSelector:(SEL)aSelector{
    [self AwError_forwardingTargetForSelector:aSelector];
    
    NSLog(@"From : [%@ Class] forwardingTargetForSelector:%@",NSStringFromClass([self class]),NSStringFromSelector(aSelector));
    NoneClass *noneclass=[[NoneClass alloc]init];
    class_addMethod([NoneClass class], aSelector, (IMP)noneClassMethod, "v@:");

    if([noneclass respondsToSelector:aSelector]){
        return noneclass;
    }
    
    return nil;
}
@end
void noneClassMethod(id self, SEL _cmd){
    
}