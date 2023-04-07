//
//  ViewController.m
//  IndoorLocationDR
//
//  Created by Guru Narayanan on 05/04/23.
//

#import "ViewController.h"
#import <SDWebImage/SDWebImage.h>

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.indoorLocationManager = [IndoorLocationManager sharedInstance: @"PPRsreycFghetRLsPKHDTRH71gVDULVC"];
    [_indoorLocationManager startWithIndoorLocationDelegate:self];
}



- (void)didUpdateMap:(MistMap *)map {
    _mistMap = map;
    
    [_mistMapView sd_setImageWithURL:[NSURL URLWithString:map.url] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
       
        [self.mistMapView setHidden:false];
        
        double ScreenWidth = [UIScreen mainScreen].bounds.size.width;
        double ScreenHeight = [UIScreen mainScreen].bounds.size.height;
        
        double screenRatio = ScreenWidth / ScreenHeight;
        double mapRatio = (double)map.width / (double)map.height;
        
        if(mapRatio > screenRatio){
            self.mapViewWidth.constant = ScreenWidth;
            self.mapViewHeight.constant = screenRatio * map.height;
        }
        else{
            self.mapViewWidth.constant = map.width + 25.0;
            self.mapViewHeight.constant = map.height;
            self.mistMapView.frame = CGRectMake(0, 0,  map.width + 25.0, map.height);
        }
        
        self.mapScaleX = self.mapViewWidth.constant / map.width;
        self.mapScaleY = self.mapViewHeight.constant / map.height;
    }];
}

- (void)didUpdateRelativeLocation:(MistPoint *)relativeLocation {
    double xWithPPM = [relativeLocation x] * [_mistMap ppm] * _mapScaleX;
    double yWithPPM = [relativeLocation y] * [_mistMap ppm] * _mapScaleY;
    [_userIcon setHidden:false];
    _userIcon.frame = CGRectMake(xWithPPM, yWithPPM, 20.0, 20.0);
}
- (void)didErrorOccurWithType:(ErrorType)errorType andMessage:(NSString *)errorMessage{
    printf("%s", errorMessage);
}

@end
