//
//  ViewController.h
//  IndoorLocationDR
//
//  Created by Guru Narayanan on 05/04/23.
//

#import <UIKit/UIKit.h>
#import <MistSDK/MistSDK.h>
@interface ViewController : UIViewController<IndoorLocationDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *userIcon;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mapViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mapViewWidth;
@property (strong, nonatomic) IBOutlet UIImageView *mistMapView;
@property (strong, nonatomic) IndoorLocationManager* indoorLocationManager;
@property (strong, nonatomic) MistMap* mistMap;

@property  double mapScaleX;
@property  double mapScaleY;

@end

