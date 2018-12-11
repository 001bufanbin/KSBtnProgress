//
//  UIButtonLongPress.h
//  KSBtnProgress
//
//  Created by Kris on 2018/12/11.
//  Copyright © 2018年 Kris. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BtnLongPressCompleteBlock)(void);

@interface UIButtonLongPress : UIButton

/**
 长按时间
 */
@property (nonatomic, assign)double longPressDuration;

/**
 长按完成回调
 */
@property (nonatomic, copy)BtnLongPressCompleteBlock completeBlock;

@end
