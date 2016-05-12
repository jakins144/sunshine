//
//  ChooseColorCollectionViewController.m
//  Draw My Life App 2
//
//  Created by Owner on 2/21/16.
//  Copyright © 2016 Josh Akins. All rights reserved.
//

#import "ChooseColorCollectionViewController.h"

@interface ChooseColorCollectionViewController ()

@end

@implementation ChooseColorCollectionViewController

static NSString * const reuseIdentifier = @"colorCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Choose Background Color";
    
    self.colorArray = [[NSMutableArray alloc]init];
    
    UIColor *white = [UIColor whiteColor];
    UIColor *blue = [UIColor blueColor];
    UIColor *red = [UIColor redColor];
    UIColor *green = [UIColor greenColor];
    UIColor *black = [UIColor blackColor];
    UIColor *purple = [UIColor purpleColor];
    UIColor *orange = [UIColor orangeColor];
    UIColor *magenta = [UIColor magentaColor];
    UIColor *brown = [UIColor brownColor];
    UIColor *cyan = [UIColor cyanColor];
    UIColor *yellow = [UIColor yellowColor];
    UIColor *lightGray = [UIColor colorWithRed:170.0/255.0 green:170.0/255.0 blue:170.0/255.0 alpha:1.0];
    
    
    
    
    [self.colorArray addObject: white];
    [self.colorArray addObject: blue];
    [self.colorArray addObject: red];
    [self.colorArray addObject: green];
    [self.colorArray addObject: purple];
    [self.colorArray addObject: orange];
    [self.colorArray addObject: magenta];
    [self.colorArray addObject: brown];
    [self.colorArray addObject: cyan];
    [self.colorArray addObject: yellow];
    [self.colorArray addObject: lightGray];
    [self.colorArray addObject: black];   

    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    NSLog(@"");
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return [self.colorArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ChooseColorCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    
    [cell setBackgroundColor:self.colorArray[indexPath.row]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
{
    [self performSegueWithIdentifier:@"toRecordDrawing" sender:self.colorArray[indexPath.row]];
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    RecordDrawingViewController *vc = [segue destinationViewController];
    
    vc.boardColor = (UIColor*)sender;
}

@end
