//
//  FWPageControl.h
//  FWPageControl
//
//  Created by Chin on 15/3/16.
//  Copyright (c) 2015年 Chin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FWPageControl : UIView {
}
@property (nonatomic) BOOL vagueTouches;
@property (nonatomic) UIEdgeInsets contentInset;
@property (nonatomic) float itemSpacing;
@property (nonatomic) NSInteger numberOfPages;
@property (nonatomic) NSInteger currentPage;

@property (nonatomic,strong)UIColor *selectedColor;
@property (nonatomic,strong)UIColor *normalColor;

@property (nonatomic,assign)BOOL selectedEnabled;

- (void)setCurrentPage:(NSInteger)currentPage animated:(BOOL)animated;
@property (nonatomic,copy)void (^didPageSelected)(NSInteger,FWPageControl *);
@end
