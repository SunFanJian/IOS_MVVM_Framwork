
//  LXDBLEManageCenter.m
//  HK_Sensor
//
//  Created by Experimental Computer on 2018/7/5.
//  Copyright © 2018年 Luxondata. All rights reserved.
//

#import "LXDBLEManageCenter.h"

@interface LXDBLEManageCenter()

@property (nonatomic , strong)CBCentralManager *centerManager;

@end

// 创建静态对象 防止外部访问
__strong static LXDBLEManageCenter *bleManager = nil ;

// 蓝牙4.0设备名
static NSString * const PeripheralName = @"公司硬件蓝牙名称";
// 服务ID
static NSString * const ServiceUUID = @"FFE0";
// 特征ID
static NSString * const CharacterUUID = @"FFE1";

@implementation LXDBLEManageCenter

-(NSArray *)characterDescriptors
{
    if (!_characterDescriptors) {
        _characterDescriptors = [NSArray array];
    }
    return _characterDescriptors;
}

//创建单例
+(instancetype)shareBLE
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        bleManager = [[LXDBLEManageCenter alloc]init];
    });
    return bleManager;
}

//初始化管理中心
-(void)initBLECenter
{
    self.centerManager = [[CBCentralManager alloc]initWithDelegate:self queue:nil];
}

//开始扫描设备
-(void)scanPerial:(int)timeout
{
    //定时器的其中两种写法
    if (@available(iOS 10.0, *)) {
        [NSTimer scheduledTimerWithTimeInterval:(float)timeout repeats:NO block:^(NSTimer * _Nonnull timer) {
            [self.centerManager stopScan];   //IOS 10 +
        }];
    } else {
        [NSTimer scheduledTimerWithTimeInterval:(float)timeout target:self selector:@selector(stopScanPerial) userInfo:nil repeats:NO];   //时间一到 ，停止扫描
    }

    //开始扫描外部设备
    //第一个参数nil，表示扫描所有设备；也可以指定 CBUUID 对象的数组，即services。这时扫描只会返回正在广告这些服务的设备。
    //第二个参数表示不会重复扫描已发现的设备
    [self.centerManager scanForPeripheralsWithServices:nil options:@{ CBCentralManagerScanOptionAllowDuplicatesKey : @NO}];
}

//停止扫描
-(void)stopScanPerial
{
    [self.centerManager stopScan];
    
    if ([self.BLEDelegate respondsToSelector:@selector(manageStopScanDevice)]) {
        [self.BLEDelegate manageStopScanDevice];
    }
    
}

//开始连接设备
/**  options
 CBConnectPeripheralOptionNotifyOnConnectionKey 应用程序被挂起时，成功连接到外设，是否向用户显示警告对话框，对应NSNumber对象，默认值为NO
 CBConnectPeripheralOptionNotifyOnDisconnectionKey 应用程序被挂起时，与外设断开连接，是否向用户显示警告对话框，对应NSNumber对象，默认值为NO
 CBConnectPeripheralOptionNotifyOnNotificationKey 应用程序被挂起时，只要接收到给定peripheral的通知，是否弹框显示
 */
-(void)connectPeripheral:(CBPeripheral *)peripheral
{
    if (peripheral.state != CBPeripheralStateConnected || peripheral.state != CBPeripheralStateConnecting) {
        [self.centerManager connectPeripheral:peripheral options:nil];
    }
}

//断开连接
-(void) disconnectPeripheral:(CBPeripheral *)peripheral
{
    if (peripheral.state != CBPeripheralStateDisconnected) {
         [self.centerManager cancelPeripheralConnection:peripheral];
    }
}

//开始通知
-(void)startNotify
{
    if (!self.activeCharacteristic.isNotifying) {
        NSLog(@"开始通知");
        [self.activePeripheral setNotifyValue:YES forCharacteristic:self.activeCharacteristic];
    }
}

//停止通知
-(void)stopNotify
{
    if (self.activeCharacteristic.isNotifying) {
         NSLog(@"停止通知");
        [self.activePeripheral setNotifyValue:NO forCharacteristic:self.activeCharacteristic];
    }
}

//写指令
-(void)writeOrder:(NSString *)order
{
    NSData *data = [order dataUsingEncoding:NSUTF8StringEncoding];
    
    [self.activePeripheral writeValue:data forCharacteristic:self.activeCharacteristic type:CBCharacteristicWriteWithResponse];
}

#pragma 蓝牙的代理方法 - 判断蓝牙状态
-(void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    switch (central.state) {
        case CBManagerStateUnknown:
            self.blueToothState = BLEStateUnknow;
            break;
         case CBManagerStateResetting:
            self.blueToothState = BLEStateResetting;
            break;
            case CBManagerStateUnsupported:
            self.blueToothState = BLEStatUnSupport;
            break;
            case CBManagerStateUnauthorized:
            self.blueToothState = BLEStateUnauthorized;
            break;
            case CBManagerStatePoweredOff:
            self.blueToothState = BLEStateClosed;
            break;
            case CBManagerStatePoweredOn:
            self.blueToothState = BLEStateOpen;
            break;
        default:
            break;
    }
    if([self.BLEDelegate respondsToSelector:@selector(promptBlueToothState:)])
    {
        [self.BLEDelegate promptBlueToothState:self.blueToothState];
    }
    
}

#pragma  扫描到设备
/**
 扫描到设备
 
 @param central 中心管理者
 @param peripheral 扫描到的设备
 @param advertisementData 广告信息
 @param RSSI 信号强度
 */
-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI
{
    if ([peripheral.name compare: @" HK-003"]) {
        
        NSData *advData = advertisementData[@"kCBAdvDataManufacturerData"];
        NSString *string = [NSString hexadecimalString:advData];
    
        NSLog(@"扫描到设备了-%@ --- %@ -- %@\n %@",peripheral,RSSI,advertisementData,string);
        
    }
    
    if ([self.BLEDelegate respondsToSelector:@selector(peripheralFound:RSSI:)]) {
        [self.BLEDelegate peripheralFound:peripheral RSSI:RSSI];
    }

    //扫描到之后，在这里可以连接指定的设备
    
}

#pragma 连接状态
/**
 连接失败
 
 @param central 中心管理者
 @param peripheral 连接失败的设备
 @param error 错误信息
 */
-(void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSLog(@"连接失败");
    
    if ([self.BLEDelegate respondsToSelector:@selector(peripheralConnectFailed:)]) {
        [self.BLEDelegate peripheralConnectFailed:peripheral];
    }
}

/**
 连接断开
 
 @param central 中心管理者
 @param peripheral 连接断开的设备
 @param error 错误信息
 */
-(void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSLog(@"连接断开");
    
    if ([self.BLEDelegate respondsToSelector:@selector(peripherDisconnect:)]) {
         [self.BLEDelegate peripherDisconnect:peripheral];
    }
   
    //重新连接
    //[self.centerManager connectPeripheral:peripheral options:nil];
}

/**
 连接成功
 
 @param central 中心管理者
 @param peripheral 连接成功的设备
 一个中心管理角色(center)可以连接多个外设(peripheral)，但是一个外设只能被一个角色连接，外设被连接后就不能能再被扫描到
 */
-(void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    NSLog(@"连接成功 - 设备信息：%@",peripheral);
    
    self.activePeripheral = peripheral;
    
    if ([self.BLEDelegate respondsToSelector:@selector(peripheralConnectSuccessed:)]) {
        [self.BLEDelegate peripheralConnectSuccessed:peripheral];
    }

    /**
     --     外设的服务、特征、描述等方法是CBPeripheralDelegate的内容，所以要先设置代理peripheral.delegate = self
     --     参数表示你关心的服务的UUID，比如我关心的是"FFF0",参数就可以为@[[CBUUID UUIDWithString:@"FFF0"]].那么didDiscoverServices方法回调内容就只有这两个UUID的服务，不会有其他多余的内容，提高效率。nil表示扫描所有服务
     --     成功发现服务，回调didDiscoverServices
     */
    peripheral.delegate = self;  //设备peripheral 的代理
    [peripheral discoverServices:nil];  //传入nil表示扫描所有的服务
    
}

//获取 RSSI的值
-(void)peripheral:(CBPeripheral *)peripheral didReadRSSI:(NSNumber *)RSSI error:(NSError *)error
{
    
}

#pragma  扫描服务
/**
 扫描到服务
 
 @param peripheral 服务对应的设备
 @param error 扫描错误信息
 */
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    for (CBService *service in peripheral.services) {
        NSLog(@"服务：%@",service);
        if ([service.UUID.UUIDString isEqualToString:ServiceUUID]) {
            
            self.activeService = service;
            /**
             --     第一个参数是数组，表示扫描指定服务下那些我关心的特征的UUID。nil表示扫描所有的特征
             --     成功扫描到特征后回调didDiscoverCharacteristicsForService
             */
            [peripheral discoverCharacteristics:nil forService:service];
        }
    }
}

#pragma  扫描特征
/**
 扫描到对应的特征
 
 @param peripheral 设备
 @param service 特征对应的服务
 @param error 错误信息
 */
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    for (CBCharacteristic *character in service.characteristics) {
        NSLog(@"特征：%@",character);
        if ([character.UUID.UUIDString isEqualToString:CharacterUUID]) {
            
            self.activeCharacteristic = character;
            //这里就可以 对指定的 特征值 进行读/写操作了
           // [peripheral writeValue:<#(nonnull NSData *)#> forCharacteristic:character type:CBCharacteristicWriteWithResponse];
           // [peripheral readValueForCharacteristic:character];
            
            /**
             -- 订阅成功后回调didUpdateNotificationStateForCharacteristic
             -- 订阅后characteristic的值发生变化会发送通知到didUpdateValueForCharacteristic
             -- 取消订阅：设置setNotifyValue为NO
             **/
            [peripheral setNotifyValue:YES forCharacteristic:character];  //开始通知
        }
    }
}

/**
 根据特征读到数据
 
 @param peripheral 读取到数据对应的设备
 @param characteristic 特征
 @param error 错误信息
 -- peripheral调用readValueForCharacteristic成功后会回调该方法
 -- peripheral调用setNotifyValue后，特征发出通知也会调用该方法
 */
-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    if ([self.BLEDelegate respondsToSelector:@selector(receivePeripheralData:error:)]) {
        [self.BLEDelegate receivePeripheralData:characteristic.value error:error];
    }
    
}

#pragma mark 订阅通知回调
- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
     NSLog(@"订阅成功");
    if ([self.BLEDelegate respondsToSelector:@selector(peripheralSubscrobeSuccess)]) {
        [self.BLEDelegate peripheralSubscrobeSuccess];
    }
}

#pragma mark 发现descriptors回调
/**
    关于特征值的描述：读/写(有/无回应)/允许通知... 等
 */
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverDescriptorsForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    
    self.characterDescriptors = characteristic.descriptors;  //特征描述列表
    NSLog(@"特征描述：%@",characteristic.descriptors);
}

#pragma mark 写入成功回掉
-(void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
        if ([self.BLEDelegate respondsToSelector:@selector(sendOrderBack:)]) {
            [self.BLEDelegate sendOrderBack:error];
        }
}
@end
