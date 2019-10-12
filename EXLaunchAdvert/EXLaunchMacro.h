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
 if(){} 是为了消除object 未使用的警告
 */
#ifndef weakify
    #if DEBUG
        #if __has_feature(objc_arc)
            #define weakify(object) autoreleasepool{} \
                __weak __typeof__(object) weak##_##object = object;if(weak##_##object){}
        #else
            #define weakify(object) autoreleasepool{} \
                __block __typeof__(object) block##_##object = object;if(block##_##object){}
        #endif
    #else
        #if __has_feature(objc_arc)
            #define weakify(object) try{} @finally{} \
                __weak __typeof__(object) weak##_##object = object{};if(weak##_##object){}
        #else
            #define weakify(object) try{} @finally{} \
                __block __typeof__(object) block##_##object = object;if(block##_##object){}
        #endif
    #endif
#endif


#ifndef strongify
    #if DEBUG
        #if __has_feature(objc_arc)
            #define strongify(object) autoreleasepool{} \
                __typeof__(object) object = weak##_##object;if(object){}
        #else
            #define strongify(object) autoreleasepool{} \
                __typeof__(object) object = block##_##object;if(object){}
        #endif
    #else
        #if __has_feature(objc_arc)
            #define strongify(object) try{} @finally{} \
                __typeof__(object) object = weak##_##object;if(object){}
        #else
            #define strongify(object) try{} @finally{} \
                __typeof__(object) object = block##_##object;if(object){}
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
