//
//  ViewController.m
//  PianoApp
//
//  Created by kunge on 2018/7/6.
//  Copyright © 2018年 kunge. All rights reserved.
//

#import "ViewController.h"
#import "PianoListCell.h"
#define lineMargin 2

#import <AudioToolbox/AudioToolbox.h>

@interface ViewController ()
{
    NSString *soundFile;
}
@property (strong, nonatomic) IBOutlet UICollectionView *pianoCollection;
@property (nonatomic,strong) NSMutableArray *pianoArr;

@end

@implementation ViewController

-(NSMutableArray *)pianoArr{
    if (_pianoArr == nil) {
        _pianoArr = [NSMutableArray arrayWithArray:@[@"01-A    -大字2组",@"02-A# -大字2组",@"03-B    -大字2组",@"04-C  -大字1组",@"05-C#-大字1组",@"06-D  -大字1组",@"07-D#-大字1组",@"08-E  -大字1组",@"09-F  -大字1组",@"10-F#-大字1组",@"11-G  -大字1组",@"12-G#-大字1组",@"13-A   -大字1组",@"14-A#-大字1组",@"15-B  -大字1组",@"16-C  -大字组",@"17-C#-大字组",@"18-D  -大字组",@"19-D# -大字组",@"20-E -大字组",@"21-F -大字组",@"22-F#-大字组",@"23-G -大字组",@"24-G#-大字组",@"25-A -大字组",@"26-A#-大字组",@"27-B -大字组",@"28-C   -小字组",@"29-C# -小字组",@"30-D  -小字组",@"31-D# -小字组",@"32-E  -小字组",@"33-F  -小字组",@"34-F# -小字组",@"35-G  -小字组",@"36-G# -小字组",@"37-A  -小字组",@"38-A# -小字组",@"39-B  -小字组",@"40-C  -小字1组",@"41-C# -小字1组",@"42-D -小字1组",@"43-D# -小字1组",@"44-E  -小字1组",@"45-F   -小字1组",@"46-F# -小字1组",@"47-G  -小字1组",@"48-G# -小字1组",@"49-A  -小字1组",@"50-A# -小字1组",@"51-B    -小字1组",@"52-C    -小字2组",@"53-C# -小字2组",@"54-D   -小字2组",@"55-D# -小字2组",@"56-E   -小字2组",@"57-F   -小字2组",@"58-F# -小字2组",@"59-G   -小字2组",@"60-G#-小字2组",@"61-A  -小字2组",@"62-A# -小字2组",@"63-B   -小字2组",@"64-C  -小字3组",@"65-C#  -小字3组",@"66-D    -小字3组",@"67-D#  -小字3组",@"68-E   -小字3组",@"69-F  -小字3组",@"70-F# -小字3组",@"71-G  -小字3组",@"72-G# -小字3组",@"73-A  -小字3组",@"74-A# -小字3组",@"75-B  -小字3组",@"76-C  -小字4组",@"77-C# -小字4组",@"78-D  -小字4组",@"79-D# -小字4组",@"80-E  -小字4组",@"81-F  -小字4组",@"82-F# -小字4组",@"83-G  -小字4组",@"84-G# -小字4组",@"85-A  -小字4组",@"86-A# -小字4组",@"87-B  -小字4组",@"88-C  -小字5组"]];
    }
    return _pianoArr;
}

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUpUI];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title = @"琴音测试";
}

#pragma mark - Method
-(void)setUpUI{
    UICollectionViewFlowLayout *layOut = [[UICollectionViewFlowLayout alloc] init];
    layOut.scrollDirection = UICollectionViewScrollDirectionVertical;
    layOut.minimumInteritemSpacing = lineMargin/2;
    layOut.minimumLineSpacing = lineMargin;
    layOut.sectionInset = UIEdgeInsetsMake(0, 2, 0, 2);//设置section的编距
    self.pianoCollection.collectionViewLayout = layOut;
    [self.pianoCollection registerNib:[UINib nibWithNibName:@"PianoListCell" bundle:nil] forCellWithReuseIdentifier:@"PianoListCell"];
}

-(void)playSound:(NSString*)soundKey{
    NSString *path = [NSString stringWithFormat:@"%@%@",[[NSBundle mainBundle] resourcePath],soundKey];
    SystemSoundID soundID;
    NSURL *filePath = [NSURL fileURLWithPath:path isDirectory:NO];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)filePath, &soundID);
    AudioServicesPlaySystemSound(soundID);
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.pianoArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PianoListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PianoListCell" forIndexPath:indexPath];
    if (self.pianoArr.count > 0) {
        cell.pianoName.text = self.pianoArr[indexPath.row];
    }
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return (CGSize){[UIScreen mainScreen].bounds.size.width/3-5,100};
}

#pragma mark - UICollectionViewDelegate
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

// 点击高亮
- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

// 选中某item
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击Item");
    soundFile = [NSString stringWithFormat:@"/%@.mp3",self.pianoArr[indexPath.row]];
    [self playSound: soundFile];
}




@end
