//
//  KKMacros.h
//  KKUtils
//
//  Created by Tolga Seremet on 24.09.2019.
//  Copyright © 2019 Tolga Seremet. All rights reserved.
//

#ifndef KKMacros_h
#define KKMacros_h

#if !TARGET_INTERFACE_BUILDER
#define getBundle [NSBundle mainBundle]
#else
#define getBundle [NSBundle bundleForClass:[self class]]
#endif

#endif /* KKMacros_h */
