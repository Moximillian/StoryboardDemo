//
//  DetailViewController.h
//  StoryboardDemo
//
//  Created by Mox Soini on 9.8.2012.
//  Copyright (c) 2012 Mox Soini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
