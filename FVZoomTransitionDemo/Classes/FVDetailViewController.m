//
//  FVDetailViewController.m
//  FVZoomTransitionDemo
//
//  Created by iforvert on 2017/5/23.
//  Copyright © 2017年 iforvert. All rights reserved.
//

#import "FVDetailViewController.h"

@interface FVDetailViewController ()

@property (nonatomic, strong) FVProduct *product;
/** 视图 */
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UILabel *descriptionLabel;
@property (strong, nonatomic, readwrite) UIImageView *imageView;

@end

@implementation FVDetailViewController

- (instancetype)initWithProduct:(FVProduct *)product
{
    self = [super init];
    if (self)
    {
        self.product = product;
        self.title = _product.title;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.97 alpha:1.0];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_scrollView];
    
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:_product.imageName]];
    _imageView.frame = CGRectMake(0.0, 0.0, _scrollView.frame.size.width, _scrollView.frame.size.width);
    
    [_scrollView addSubview:_imageView];
    
    self.descriptionLabel = [[UILabel alloc] init];
    _descriptionLabel.font = [UIFont systemFontOfSize:16.0];
    _descriptionLabel.numberOfLines = 0;
    _descriptionLabel.text = @"Helvetica scenester deep v fixie. Austin messenger bag cliche slow-carb, umami Shoreditch pop-up bicycle rights brunch vinyl viral narwhal disrupt pug. Godard cliche crucifix typewriter 8-bit ugh. Raw denim freegan pork belly direct trade gentrify you probably haven't heard of them.\n\nSartorial retro tattooed asymmetrical Williamsburg, hoodie locavore leggings roof party umami. Forage bitters polaroid freegan master cleanse jean shorts. Wes Anderson hella wolf, retro Blue Bottle literally leggings gluten-free DIY fap bespoke fashion axe Helvetica quinoa direct trade.\n\nFour dollar toast ennui Thundercats, chillwave single-origin coffee hashtag sustainable irony Intelligentsia. Whatever chia meditation 90's drinking vinegar, migas Williamsburg deep v typewriter kitsch. Small batch cold-pressed Pitchfork direct trade occupy sartorial, blog 8-bit mustache readymade Marfa cred butcher meggings hella. Asymmetrical photo booth pork belly, semiotics banjo pug health goth Vice farm-to-table Banksy.\n\nPortland fashion axe meditation sartorial gluten-free seitan. Cold-pressed deep v 90's, literally iPhone hashtag Bushwick banh mi organic put a bird on it bicycle rights ugh paleo stumptown. Photo booth quinoa Banksy, Intelligentsia deep v literally fingerstache lomo distillery raw denim taxidermy asymmetrical gluten-free.";
    [_scrollView addSubview:_descriptionLabel];
    
    CGSize descriptionSize = [_descriptionLabel sizeThatFits:CGSizeMake((_scrollView.frame.size.width - 14.0 * 2.0), CGFLOAT_MAX)];
    _descriptionLabel.frame = CGRectMake(14.0, _imageView.frame.origin.y + _imageView.frame.size.height + 14.0, descriptionSize.width, descriptionSize.height);
    
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width, _descriptionLabel.frame.origin.y + _descriptionLabel.frame.size.height + 14.0);
}

- (void)setCoverCard:(UIView *)view
{
    if (view)
    {
//        BukaOpenCardTranNavigationDelegate *navidelegate = [BukaOpenCardTranNavigationDelegate new];
//        navidelegate.transitCard = view;
//        _cardNaviDelegate = navidelegate;
//        self.bk_navigationDelegate = _cardNaviDelegate;
        //        self.bk_swipeBackDisabled = YES;
    }
    else
    {
//        _cardNaviDelegate = nil;
//        self.bk_navigationDelegate = nil;
        //        self.bk_swipeBackDisabled = NO;
    }
}

@end
