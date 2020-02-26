//
//  TableViewController.h
//  Chuck Norris
//
//  Created by Marcello Pontes Domingos on 24/01/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TableViewController : UITableViewController
{
    NSMutableArray *dataTableView;
    NSString *apiUrl;
    NSString *category;
}

@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)shuffle:(id)sender;
- (IBAction)reload:(id)sender;

@end

NS_ASSUME_NONNULL_END
