//
//  ViewController.m
//  LLInstalmentPayData
//
//  Created by zdy on 2017/11/23.
//  Copyright © 2017年 lianlianpay. All rights reserved.
//

#import "ViewController.h"
#import <MessageUI/MessageUI.h>

NSString *namep = @"王李张刘陈杨黄赵吴周徐孙马朱胡郭何高林罗郑梁谢宋唐许韩冯邓曹彭曾萧田董潘袁于蒋蔡余杜叶程苏魏吕丁任沈姚卢姜崔钟谭陆汪范金石廖贾夏韦傅方白邹孟熊秦邱江尹位薛阎段雷侯龙史陶黎贺顾毛郝龚邵万钱严覃武戴莫孔向汤";
NSString *namen = @"的一是在不了有和人这中大为上个国我以要他时来用们生到作地于出就分对成会可主发年动同工也能下过子说产种面而方后多定行学法所民得经十三之进着等部度家电力里如水化高自二理起小物现实加量都两体制机当使点从业本去把性好应开它合还因由其些然前外天政四日那社义事平形相全表间样与关各重新线内数正心反你明看原又么利比或但质气第向道命此变条只没结解问意建月公无系军很情者最立代想已通并提直题党程展五果料象员革位入常文总次品式活设及管特件长求老头基资边流路级少图山统接知较将组见计别她手角期根论运农指几九区强放决西被干做必战先回则任取据处队南给色光门即保治北造百规热领七海口东导器压志世金增争济阶油思术极交受联什认六共权收证改清己美再采转更单风切打白教速花带安场身车例真务具万每目至达走积示议声报斗完类八离华名确才科张信马节话米整空元况今集温传土许步群广石记需段研界拉林律叫且究观越织装影算低持音众书布复容儿须际商非验连断深难近矿千周委素技备半办青省列习响约支般史感劳便团往酸历市克何除消构府称太准精值号率族维划选标写存候毛亲快效斯院查江型眼王按格养易置派层片始却专状育厂京识适属圆包火住调满县局照参红细引听该铁价严龙飞";



@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}


- (NSString *)randomBankCard {
    int d = arc4random()%10000;
    return [NSString stringWithFormat:@"%04d",d];
}

- (NSString *)randomName {
    NSString *name = @"";
    
    NSInteger rp = arc4random()%100;
    NSString *p = [namep substringWithRange:NSMakeRange(rp, 1)];
    
    if (arc4random()%2 == 0) {
        // 2个字
        NSInteger rn = arc4random()%100;
        NSString *n = [namep substringWithRange:NSMakeRange(rn, 1)];
        
        name = [NSString stringWithFormat:@"%@%@",p,n];
    } else {
        // 3个字
        NSInteger rn1 = arc4random()%100;
        NSString *n1 = [namep substringWithRange:NSMakeRange(rn1, 1)];
        
        NSInteger rn2 = arc4random()%100;
        NSString *n2 = [namep substringWithRange:NSMakeRange(rn2, 1)];
        
        name = [NSString stringWithFormat:@"%@%@%@",p,n1,n2];
    }
    
    return name;
}

- (NSString *)randomAreaCode {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"RegionCode" ofType:@"txt"];
    NSString *str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSArray *regionCodeArray = [str componentsSeparatedByString:@","];
    
    NSInteger i = arc4random()%regionCodeArray.count;
    NSString *code = regionCodeArray[i];
    return code;
}

- (NSString *)randomBirthday {
    int y = 1950 + arc4random()%100;
    int m = 1 + arc4random()%12;
    int d = 1 + arc4random()%30;
    return [NSString stringWithFormat:@"%d%02d%02d",y,m,d];
}

- (NSString *)randomCode {
    int code = arc4random()%1000;
    return [NSString stringWithFormat:@"%03d",code];
}

- (NSString *)randomId {
    NSString *sfz = @"";
    
    NSString *areaCode = [self randomAreaCode];
    NSString *birthday = [self randomBirthday];
    NSString *code = [self randomCode];
    
    NSString *string = [NSString stringWithFormat:@"%@%@%@",areaCode,birthday,code];
    NSArray *mask = @[@"7",@"9",@"10",@"5",@"8",@"4",@"2",@"1",@"6",@"3",@"7",@"9",@"10",@"5",@"8",@"4",@"2"];
    NSArray *check = @[@"1",@"0",@"X",@"9",@"8",@"7",@"6",@"5",@"4",@"3",@"2"];
    
    int c = 0;
    for (int i =0; i<string.length; i++) {
        int p1 = [[string substringWithRange:NSMakeRange(i, 1)] intValue];
        int p2= [mask[i] intValue];
        int p = p1 * p2;
        c += p;
    }
    int r = c%11;
    
    sfz = [string stringByAppendingString:check[r]];
    
    return sfz;
}

- (NSString *)bankCardIdWithBankCard:(NSString *)bankCard witIndex:(int)index {
    if (bankCard.length < 4) {
        return bankCard;
    }
    int p1 = [[bankCard substringFromIndex:bankCard.length-4] intValue];
    int p =  p1 + index;
    NSString *rep = [NSString stringWithFormat:@"%d",p];
    return [NSString stringWithFormat:@"%@%@",[bankCard substringToIndex:bankCard.length-4],rep];
}

- (IBAction)donePressed:(id)sender {
    NSString *phone = self.phoneTextField.text;
    NSInteger count = [self.countTextField.text integerValue];
    NSString *bankCard = self.bankCardTextField.text;
    NSString *email = self.emailTextField.text;

    
    NSString *string = @"";
    for (int i=0; i<count; i++) {
        NSString *name = [self randomName];
        NSString *sid = [self randomId];
        NSString *bankCardId = [self bankCardIdWithBankCard:bankCard witIndex:i];
        string = [string stringByAppendingFormat:@"%@ %@ %@ %@\n",bankCardId,name,sid,phone];
        NSLog(@"bankCode=%@/name = %@/id=%@/phone = %@",bankCardId,name,sid,phone);
    }
    
//    NSString *filePath = [NSHomeDirectory() stringByAppendingString:@"/a.txt"];
//    [string writeToFile:filePath atomically:YES encoding:NSUnicodeStringEncoding error:nil];
//    NSLog(@"File = %@",filePath);
    
    if (email.length == 0) {
        return;
    }
    
    // 发送邮件
    MFMailComposeViewController *vc = [[MFMailComposeViewController alloc] init];
    vc.mailComposeDelegate = self;
    [vc setSubject:@"发送邮件"];
    [vc setToRecipients:@[email]];
    NSData *data = [string dataUsingEncoding:NSUnicodeStringEncoding];
    [vc addAttachmentData:data mimeType:@"" fileName:@"a.txt"];
    NSString *emailBody = [NSMutableString stringWithFormat:@"生成了%d条四要素信息",count];
    [vc setMessageBody:emailBody isHTML:NO];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(nullable NSError *)error {
    [controller dismissViewControllerAnimated:YES completion:nil];
    
    if (result == MFMailComposeResultSent) {
        UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"" message:@"发送成功" preferredStyle:UIAlertControllerStyleAlert];
        [vc addAction:[UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:vc animated:YES completion:nil];
    }
}
@end
