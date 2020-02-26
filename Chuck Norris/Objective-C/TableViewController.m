//
//  TableViewController.m
//  Chuck Norris
//
//  Created by Marcello Pontes Domingos on 24/01/20.
//

#import "TableViewController.h"
#import "Chuck_Norris-Swift.h"

@interface TableViewController ()

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    apiUrl= @"https://api.chucknorris.io/jokes/categories";
    NSArray *resp = [self makeRestAPICall: apiUrl];
    dataTableView = [NSMutableArray arrayWithArray:resp];
    
}

-(NSArray*) makeRestAPICall : (NSString*) reqURLStr
 {
     NSURLRequest *Request = [NSURLRequest requestWithURL:[NSURL URLWithString: reqURLStr]];
     NSURLResponse *resp = nil;
     NSError *error = nil;
     NSData *response = [NSURLConnection sendSynchronousRequest: Request returningResponse: &resp error: &error];
     NSArray *json = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingAllowFragments error:nil];
     return json;
 }

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [dataTableView count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Category" forIndexPath:indexPath];
    cell.textLabel.text = dataTableView[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    category = dataTableView[indexPath.row];
    DetailViewController *destination = [[DetailViewController alloc] init];
    destination.selectedCategory = category;
    [[self navigationController] pushViewController:destination animated:YES];
}

#pragma mark - Action

- (IBAction)shuffle:(id)sender {
    NSUInteger contador = [dataTableView count];
    for(NSUInteger i = 0; i < contador; i++){
        long x = contador - i;
        long y = (arc4random() % x) +i;
        [dataTableView exchangeObjectAtIndex: i withObjectAtIndex: y];
    }
    self.tableView.reloadData;
}

- (IBAction)reload:(id)sender {
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:nil ascending:TRUE];
    NSArray *aux;
    aux = [dataTableView sortedArrayUsingDescriptors:@[sort]];
    dataTableView = [NSMutableArray arrayWithArray:aux];
    self.tableView.reloadData;
}
@end
