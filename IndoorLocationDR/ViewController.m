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
        [self setScaleFactor:map];
    }];
    
}

- (void)didUpdateRelativeLocation:(MistPoint *)relativeLocation {
    double xWithPPM = [relativeLocation x] * [_mistMap ppm] * _mapScaleX;
    double yWithPPM = [relativeLocation y] * [_mistMap ppm] * _mapScaleY;
   
    _xOfUSer.constant = xWithPPM;
    _yOfUSer.constant = yWithPPM;
}
- (void)didErrorOccurWithType:(ErrorType)errorType andMessage:(NSString *)errorMessage{
    NSLog(@"error %@", errorMessage);
}

- (void)setScaleFactor:(MistMap *)mapObj{
    double ScreenWidth = [UIScreen mainScreen].bounds.size.width;
    double ScreenHeight = [UIScreen mainScreen].bounds.size.height;
    
    double screenRatio = ScreenWidth / ScreenHeight;
    double mapRatio = (double)mapObj.width / (double)mapObj.height;
    
    if(mapRatio > screenRatio){
        self.mapViewWidth.constant = screenRatio * mapObj.width;
        self.mapViewHeight.constant = screenRatio * mapObj.height;
    }
    else{
        self.mapViewWidth.constant = mapObj.width;
        self.mapViewHeight.constant = mapObj.height;
    }
    
    self.mapScaleX = self.mapViewWidth.constant / mapObj.width;
    self.mapScaleY = self.mapViewHeight.constant / mapObj.height;
}
@end
