//
//  ZSSFontsViewController.m
//  ZSSRichTextEditor
//
//  Created by Will Swan on 03/09/2016.
//  Copyright © 2016 Zed Said Studio. All rights reserved.
//

#import "ZSSFontsViewController.h"

@interface ZSSFontsViewController () <UITableViewDelegate,UITableViewDataSource> {
    
    ZSSFontFamily selectedFontFamily;
    
}

@end

@implementation ZSSFontsViewController

@synthesize delegate;

#pragma mark - Init Section
+ (ZSSFontsViewController *)cancelableFontPickerViewControllerWithFontFamily:(ZSSFontFamily)fontFamily {
    return [[ZSSFontsViewController alloc] initWithFontFamily:fontFamily];
}

- (id)initWithFontFamily:(ZSSFontFamily)fontFamily {

    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _font = fontFamily;
    }
    return self;
    
}

#pragma mark - View Did Load Section
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //Set up navigation
    [self setUpNavigation];
    
    //Create table view
    [self createTableView];
    
}

#pragma mark - Set Up View Section

- (void)setUpNavigation {
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    
    self.navigationItem.title = NSLocalizedStringFromTableInBundle(@"Fonts", nil, bundle, nil);
    
    UIBarButtonItem *buttonItem;
    
    buttonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
    self.navigationItem.leftBarButtonItem = buttonItem;
    
    buttonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedStringFromTableInBundle(@"Save", nil, bundle, nil)
                                                  style:UIBarButtonItemStyleDone
                                                 target:self action:@selector(save:)];
    self.navigationItem.rightBarButtonItem = buttonItem;
    
}

- (void)createTableView {
    
    UITableView *tableView = [[UITableView alloc] init];
    tableView.frame = self.view.bounds;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self.view addSubview:tableView];
    
}

#pragma mark - Table View Section

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"fontCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    float fontSize = cell.textLabel.font.pointSize;
    
    switch (indexPath.row) {
        case 0:
        cell.textLabel.text = @"Default";
        cell.textLabel.font = [UIFont fontWithName:@"ArialMT" size:fontSize];
        break;

        case 1:
        cell.textLabel.text = @"Trebuchet";
        cell.textLabel.font = [UIFont fontWithName:@"TrebuchetMS" size:fontSize];
        break;
        
        case 2:
        cell.textLabel.text = @"Verdana";
        cell.textLabel.font = [UIFont fontWithName:@"Verdana" size:fontSize];
        break;
        
        case 3:
        cell.textLabel.text = @"Georgia";
        cell.textLabel.font = [UIFont fontWithName:@"Georgia" size:fontSize];
        break;
        
        case 4:
        cell.textLabel.text = @"Palatino";
        cell.textLabel.font = [UIFont fontWithName:@"Palatino-Roman" size:fontSize];
        break;
        
        case 5:
        cell.textLabel.text = @"Times New Roman";
        cell.textLabel.font = [UIFont fontWithName:@"TimesNewRomanPSMT" size:fontSize];
        break;
        
        case 6:
        cell.textLabel.text = @"Courier New";
        cell.textLabel.font = [UIFont fontWithName:@"CourierNewPSMT" size:fontSize];
        break;
        
        default:
        break;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell != nil)
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    switch (indexPath.row) {
        case 0:
        selectedFontFamily = ZSSFontFamilyDefault;
        break;
        
        case 1:
        selectedFontFamily = ZSSFontFamilyTrebuchet;
        break;
        
        case 2:
        selectedFontFamily = ZSSFontFamilyVerdana;
        break;
        
        case 3:
        selectedFontFamily = ZSSFontFamilyGeorgia;
        break;
        
        case 4:
        selectedFontFamily = ZSSFontFamilyPalatino;
        break;
        
        case 5:
        selectedFontFamily = ZSSFontFamilyTimesNew;
        break;
        
        case 6:
        selectedFontFamily = ZSSFontFamilyCourierNew;
        break;
        
        default:
        break;
    }
    
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell != nil)
        cell.accessoryType = UITableViewCellAccessoryNone;
}

#pragma mark - Navigation Item Interactions Section

- (void)save {
    
    if (self.delegate) {
        [self.delegate setSelectedFontFamily:selectedFontFamily];
        [self.delegate closeViewController:self];
    }
    
}

- (void)save:(id)sender {
    [self save];
}

- (void)cancel:(id)sender {
    [self.delegate closeViewController:self];
}

#pragma mark - Memory Warning Section
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
