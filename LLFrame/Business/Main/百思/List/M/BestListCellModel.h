//
//  BestListCellModel.h
//  LLFrame
//
//  Created by Hailong Guo on 2017/12/31.
//  Copyright © 2017年 Hailong Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListType.h"

@interface BestListCellModel : RootModel

@property (nonatomic,assign) ListType type;

/**
 创建时间
 */
@property (nonatomic,copy) NSString *create_time;

/**
 点赞的数量
 */
@property (nonatomic,copy) NSString *love;

/**
 点踩的数量
 */
@property (nonatomic,copy) NSString *hate;

/**
 图片高度
 */
@property (nonatomic,assign) CGFloat height;

/**
 图片宽度
 */
@property (nonatomic,assign) CGFloat width;

/**
 图片id
 */
@property (nonatomic,copy) NSString *id;

/**
 0号图，数字越大，尺寸越大
 */
@property (nonatomic,copy) NSString *image0;

/**
 1号图
 */
@property (nonatomic,copy) NSString *image1;

/**
 2号图
 */
@property (nonatomic,copy) NSString *image2;

/**
 3号图
 */
@property (nonatomic,copy) NSString *image3;

/**
 段子正文
 */
@property (nonatomic,copy) NSString *text;

/**
 过滤后的正文
 */
@property (nonatomic,copy) NSString *filteredText;

/**
 视频时长
 */
@property (nonatomic,copy) NSString *videotime;

/**
 视频url
 */
@property (nonatomic,copy) NSString *video_uri;

/**
 声音文件大小
 */
@property (nonatomic,copy) NSString *voicelength;

/**
 声音时长
 */
@property (nonatomic,copy) NSString *voicetime;

/**
 声音url
 */
@property (nonatomic,copy) NSString *voiceuri;

/**
 微信链接地址
 */
@property (nonatomic,copy) NSString *weixin_url;

/**
 用户头像
 */
@property (nonatomic,copy) NSString *profile_image;

/**
 用户昵称
 */
@property (nonatomic,copy) NSString *name;

@end
