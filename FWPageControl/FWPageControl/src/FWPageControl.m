//
//  FWPageControl.m
//  FWPageControl
//
//  Created by Chin on 15/3/16.
//  Copyright (c) 2015年 Chin. All rights reserved.
//

#import "FWPageControl.h"
static NSInteger const kBaseTag = 1001;
@interface NSMutableArray (FWPageControl)
- (void)resize:(NSInteger)count loader:(id (^)(void))loader;
@end

@implementation NSMutableArray (FWPageControl)
- (void)resize:(NSInteger)count loader:(id (^)(void))loader
{
    NSInteger currentCount = [self count];
    NSInteger difference = currentCount - count;
    if (difference == 0)
        return;

    if (difference > 0) {
        while (difference--) {
            [self removeLastObject];
        }
    }
    else {
        difference = -difference;
        while (difference--) {
            id obj = loader();
            [self addObject:obj];
        }
    }
}
@end

@interface FWPageControl () {
    UIView* _selectedView;
}
@property (nonatomic, strong) NSMutableArray* views;
@end

@implementation FWPageControl
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _views = [NSMutableArray array];
        _selectedView = [UIView new];
        _vagueTouches = YES;
        [self addSubview:_selectedView];
        
        self.normalColor  = [UIColor colorWithRed:137.0/255 green:196.0/255 blue:92.0/255 alpha:1];
        self.selectedColor = [UIColor colorWithRed:238.0/255 green:120.0/255 blue:60.0/255 alpha:1];
                
        _selectedEnabled = YES;
    }
    return self;
}
- (void)setNumberOfPages:(NSInteger)numberOfPages
{
    _numberOfPages = numberOfPages;
    [_views enumerateObjectsUsingBlock:^(UIButton* obj, NSUInteger idx, BOOL* stop) {
        [obj removeFromSuperview];
        [obj removeTarget:self action:@selector(itemClicked:) forControlEvents:UIControlEventTouchUpInside];
    }];
    [_views resize:_numberOfPages loader:^id {
        return [UIButton new];
    }];
    [self layout];
}
- (void)itemClicked:(UIButton*)sender
{
    if (!_selectedEnabled) {
        return;
    }
    NSInteger page  = [sender tag] - kBaseTag;
    [self setCurrentPage:page animated:YES];
    if (_didPageSelected) {
        _didPageSelected(page,self);
    }
}
- (void)setItemSpacing:(float)itemSpacing
{
    _itemSpacing = itemSpacing;
    [self setNumberOfPages:_numberOfPages];
}
- (void)setContentInset:(UIEdgeInsets)contentInset
{
    _contentInset = contentInset;
    [self setNumberOfPages:_numberOfPages];
}
- (void)setViewStyle:(UIView*)view
{
    [view setBackgroundColor:_normalColor];
}
- (void)setSelectedColor:(UIColor *)selectedColor{
    _selectedColor = selectedColor;
    [_selectedView setBackgroundColor:_selectedColor];
}
- (void)setNormalColor:(UIColor *)normalColor{
    _normalColor = normalColor;
    [_views enumerateObjectsUsingBlock:^(UIButton *obj, NSUInteger idx, BOOL *stop) {
        [obj setBackgroundColor:_normalColor];
    }];
}
- (void)layout
{
    float itemWidth = (self.frame.size.width - (_numberOfPages - 1) * _itemSpacing - _contentInset.left - _contentInset.right) / _numberOfPages;
    float itemHeight = self.frame.size.height - _contentInset.top - _contentInset.bottom;
    float y = _contentInset.top;
    __block float x = _contentInset.left;

    __weak FWPageControl* me = self;
    [_views enumerateObjectsUsingBlock:^(UIButton* obj, NSUInteger idx, BOOL* stop) {
        [self setViewStyle:obj];
        [obj setFrame:CGRectMake(x, y, itemWidth, itemHeight)];
        [obj setTag:idx + kBaseTag];
        x += itemWidth + me.itemSpacing;
        [self addSubview:obj];
        [obj addTarget:self action:@selector(itemClicked:) forControlEvents:UIControlEventTouchUpInside];
    }];
    [self bringSubviewToFront:_selectedView];
    [self setCurrentPage:_currentPage];
}

- (void)setCurrentPage:(NSInteger)currentPage
{
    [self setCurrentPage:currentPage animated:NO];
}
- (void)setCurrentPage:(NSInteger)currentPage animated:(BOOL)animated
{
    _currentPage = currentPage;
    CGRect currentSelectedFrame = [[self viewWithTag:kBaseTag + _currentPage] frame];
    if (!animated) {
        [_selectedView setFrame:currentSelectedFrame];
    }
    else {
        [UIView animateWithDuration:0.3f animations:^{
            [_selectedView setFrame:currentSelectedFrame];
        }];
    }
}
- (UIView*)hitTest:(CGPoint)point withEvent:(UIEvent*)event
{
    if (_vagueTouches && CGRectContainsPoint(self.bounds, point)) {
       __block UIView *view = nil;
        [_views enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
            if (point.x >= obj.frame.origin.x && point.x < CGRectGetMaxX(obj.frame)) {
                view = obj;
                *stop = YES;
            }
        }];
        return view;
    }
    return [super hitTest:point withEvent:event];
}
@end
