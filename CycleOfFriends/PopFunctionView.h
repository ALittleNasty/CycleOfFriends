//
//  PopFunctionView.h
//  CycleOfFriends
//
//  Created by 胡阳 on 15/12/21.
//  Copyright © 2015年 young4ever. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PopFunctionView ;

typedef NS_ENUM(NSInteger , PopFunctionViewType) {

    PopFunctionViewTypeCopy ,
    PopFunctionViewTypeCopyAndDelete
};

@protocol PopFunctionViewDelegate <NSObject>

@optional

/**
 *  复制按钮点击代理方法
 */
- (void)copyButtonClickedOnPopFunctionView:(PopFunctionView *)functionView ;

/**
 *  删除按钮点击代理方法
 */
- (void)deleteButtonClickedOnPopFunctionView:(PopFunctionView *)functionView ;

@end

@interface PopFunctionView : UIView

/**
 *  长按评论弹出的工具框
 *
 *  @param frame    直接给CGRectZero
 *  @param location 点击的位置
 *  @param type     类型
 *  @param delegate 代理
 */
- (instancetype)initWithFrame:(CGRect)frame position:(CGPoint)location type:(PopFunctionViewType)type delegate:(id<PopFunctionViewDelegate>)delegate ;

/**
 *  显示弹窗
 */
- (void)show ;

@end
