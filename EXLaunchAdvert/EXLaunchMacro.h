//
//  EXLaunchMacro.h
//  EXLaunchDemo
//
//  Created by MiaoShichang on 2019/10/11.
//  Copyright © 2019 MiaoShichang. All rights reserved.
//

#ifndef EXLaunchMacro_h
#define EXLaunchMacro_h

/*
 autoreleasepool{} 和 try{} @finally{} 是为了和@符号一块使用
 */
#ifndef weakSelf
    #if DEBUG
        #if __has_feature(objc_arc)
            #define weakSelf(object) autoreleasepool{} \
                __weak __typeof__(object) weak##__##object = object;
        #else
            #define weakSelf(object) autoreleasepool{} \
                __block __typeof__(object) block##__##object = object;
        #endif
    #else
        #if __has_feature(objc_arc)
            #define weakSelf(object) try{} @finally{} \
                __weak __typeof__(object) weak##__##object = object;
        #else
            #define weakSelf(object) try{} @finally{} \
                __block __typeof__(object) block##__##object = object;
        #endif
    #endif
#endif


#ifndef strongSelf
    #if DEBUG
        #if __has_feature(objc_arc)
            #define strongSelf(object) autoreleasepool{} \
                __typeof__(object) object = weak##__##object;
        #else
            #define strongSelf(object) autoreleasepool{} \
                __typeof__(object) object = block##__##object;
        #endif
    #else
        #if __has_feature(objc_arc)
            #define strongSelf(object) try{} @finally{} \
                __typeof__(object) object = weak##__##object;
        #else
            #define strongSelf(object) try{} @finally{} \
                __typeof__(object) object = block##__##object;
        #endif
    #endif
#endif

// EXLaunchLog
#ifdef DEBUG
    #define EXLaunchLog(FORMAT, ...) \
        NSLog(@"【EXLaunchLog】-- %@", [NSString stringWithFormat:FORMAT, ##__VA_ARGS__]);
#else
    #define EXLaunchLog(...)
#endif






#endif /* EXLaunchMacro_h */
