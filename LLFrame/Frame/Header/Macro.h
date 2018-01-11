//
//  Macro.h
//  LLFrame
//
//  Created by Hailong Guo on 2017/12/29.
//  Copyright © 2017年 Hailong Guo. All rights reserved.
//

#ifndef Macro_h
#define Macro_h

// 通用灰色
#define HUI rgb(245,245,245)

// 状态栏、导航栏、选项卡高度
#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define kNavBarHeight 44.0
#define kTopHeight (kStatusBarHeight + kNavBarHeight)
#define kTabBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height > 20 ? 83 : 49)

// 屏幕宽高
#define KScreenHeight [[UIScreen mainScreen] bounds].size.height
#define KScreenWidth  [[UIScreen mainScreen] bounds].size.width

// 自适应宽高（参照手机：苹果6S）
#define AdaptedWidth(x)  ceilf((x) * (KScreenWidth / 375.0))
#define AdaptedHeight(x) ceilf((x) * (KScreenHeight / 667.0))

// 字体适配
#define AdaptedFontSize(FONTSIZE) [UIFont systemFontOfSize:AdaptedWidth(FONTSIZE)]
#define BoldSystemFont(FONTSIZE)  [UIFont boldSystemFontOfSize:AdaptedWidth(FONTSIZE)]

#define RequestFailedTip @"网络出错!"

// 偏好设置
#define UserDefaults [NSUserDefaults standardUserDefaults]
// 当前用户
#define kUser [AppUser sharedUser]
// 当前主题
#define kTheme [ThemeManager currentTheme]

#endif /* Macro_h */
