//
//  ViewController.m
//  PanCollectionView
//
//  Created by YouLoft_MacMini on 16/1/4.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "ViewController.h"
#import "XWCell.h"
#import "XWCellModel.h"
#import "XWDragCellCollectionView.h"

@interface ViewController ()<XWDragCellCollectionViewDataSource, XWDragCellCollectionViewDelegate>
@property (nonatomic, strong) NSArray *data;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(80, 80);
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    XWDragCellCollectionView *mainView = [[XWDragCellCollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    mainView.delegate = self;
    mainView.dataSource = self;
    mainView.backgroundColor = [UIColor whiteColor];
    [mainView registerNib:[UINib nibWithNibName:@"XWCell" bundle:nil] forCellWithReuseIdentifier:@"XWCell"];
    [self.view addSubview:mainView];
}

- (NSArray *)data{
    if (!_data) {
        NSMutableArray *temp = @[].mutableCopy;
        NSArray *colors = @[[UIColor redColor], [UIColor blueColor], [UIColor yellowColor], [UIColor orangeColor], [UIColor greenColor]];
        for (int i = 0; i < 5; i ++) {
            NSMutableArray *tempSection = @[].mutableCopy;
            for (int j = 0; j < arc4random() % 6 + 5; j ++) {
                NSString *str = [NSString stringWithFormat:@"%d--%d", i, j];
                XWCellModel *model = [XWCellModel new];
                model.backGroundColor = colors[i];
                model.title = str;
                [tempSection addObject:model];
            }
            [temp addObject:tempSection.copy];
        }
        _data = temp.copy;
    }
    return _data;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.data.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSArray *sec = _data[section];
    return sec.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    XWCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XWCell" forIndexPath:indexPath];
    cell.data = _data[indexPath.section][indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    XWCellModel *model = _data[indexPath.section][indexPath.item];
    NSLog(@"%@", model.title);
}

- (NSArray *)dataSourceArrayOfCollectionView:(XWDragCellCollectionView *)collectionView{
    return _data;
}

- (void)dragCellCollectionView:(XWDragCellCollectionView *)collectionView newDataArrayAfterMove:(NSArray *)newDataArray{
    _data = newDataArray;
}



@end
