//
//  WSHomeViewController.m
//  WalkShopper
//
//  Created by Ding Yi on 15/9/23.
//  Copyright (c) 2015年 Ding Yi. All rights reserved.
//

#import "WSHomeViewController.h"
#import "WSHomeProductCell.h"
#import "LDPMPopoverMenu.h"
#import "WSSellCreationViewController.h"

static NSString * const kProductCellIdentifier = @"Home Product Cell";


@interface WSHomeViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *menuItemArray;

@end

@implementation WSHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发现";
    
    UIButton *createBtn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [createBtn addTarget:self action:@selector(createNew:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:createBtn];
}


#pragma mark - TableView dataSource & delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [WSHomeProductCell cellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WSHomeProductCell *cell = [tableView dequeueReusableCellWithIdentifier:kProductCellIdentifier forIndexPath:indexPath];
    [cell setSeparatorInset:UIEdgeInsetsZero];
    [cell setLayoutMargins:UIEdgeInsetsZero];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Actions

- (void)createNew:(id)sender
{
    [self.menuItemArray removeAllObjects];
    NSArray *titles = @[@"我要卖", @"我要买"];
    for (NSString *title in titles) {
        LDPMPopoverMenuItem *item = [[LDPMPopoverMenuItem alloc]initWithTitle:title titleColor:[UIColor colorWithRGB:0xd7a101] titleFont:[UIFont systemFontOfSize:14] titleAlignment:NSTextAlignmentCenter image:nil target:self action:@selector(menuTapped:)];
        [self.menuItemArray addObject:item];
    }

    LDPMPopoverMenu *menu = [[LDPMPopoverMenu alloc] initWithTintColor:[UIColor whiteColor] maskColor:[UIColor colorWithWhite:0 alpha:0.2] itemHorizontalMargin:15. itemVerticalMargin:15. leftInsetOfSepline:0 seplineColor:[UIColor lightGrayColor] arrowSize:6];
    
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    
    [menu showMenuInView:window fromView:self.navigationItem.rightBarButtonItem.customView menuItems:self.menuItemArray];
    
}

- (void)menuTapped:(LDPMPopoverMenuItem *)sender
{
    for (int i = 0; i < self.menuItemArray.count; i++) {
        LDPMPopoverMenuItem *item = self.menuItemArray[i];
        if (sender == item) {
            if (i == 0) {
                UIViewController *vc = [UIViewController ws_initViewControllerWithStoryBoard:@"Home" withIdentifier:NSStringFromClass([WSSellCreationViewController class])];
                [self.navigationController pushViewController:vc animated:YES];
            } else if (i == 1) {
                
            }
        }
    }
}

- (NSMutableArray *)menuItemArray
{
    if (_menuItemArray == nil) {
        _menuItemArray = [NSMutableArray new];
    }
    
    return _menuItemArray;
}

@end
