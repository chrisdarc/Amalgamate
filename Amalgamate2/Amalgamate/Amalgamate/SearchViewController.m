//
//  SearchViewController.m
//  Amalgamate
//
//  Created by Chris Darc on 2016-03-14.
//  Copyright © 2016 Group10. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController
@synthesize searchTable, searchTerms;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //load search terms previously saved
    [self loadArray];
    
    //add button
    UIBarButtonItem * addButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    [[UIBarButtonItem appearance] setTintColor:[UIColor whiteColor]];
    
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    
    [self whatToDisplay];
}


-(void)whatToDisplay
{
    [self loadArray];
    NSLog(@"%s%lu", "Number of items in searchTerms", (unsigned long)searchTerms.count);
    if(searchTerms.count == 0)
    {
        SearchInfoLabel.alpha = 1;
    }
    else
    {
        SearchInfoLabel.alpha = 0;
    }
}

-(void)loadArray
{
    //Load search terms previously saved
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray * storedArray= [userDefaults objectForKey:@"tableViewSearchTerms"];
    if (storedArray == nil)
    {
        //initialize data structure that holds search terms
        searchTerms = [[NSMutableArray alloc]init];//initWithObjects: @"First", nil];//@"Test Search Term", nil];
    }
    else
    {
        //make search terms equal to the array that is stored
        searchTerms = [[NSMutableArray alloc]initWithArray:storedArray];
    }
}

-(void)saveArray
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:searchTerms forKey:@"tableViewSearchTerms"];
    [userDefaults synchronize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    [searchTable setEditing:editing animated:animated];
}

-(void)insertNewObject
{
    //display a UIAlertView
//    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Enter a Search Term" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
//    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
//    [alert show];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Enter a Search Term" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action") style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){NSLog(@"Cancel Action");}];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField)
     {
         textField.placeholder = NSLocalizedString(@"Keyword", @"KeywordPlaceholder");
         
     }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", "OK action") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                               {
                                   NSString *term = alert.textFields.firstObject.text;
                                   NSLog(@"%@", term);
                                   if(!searchTerms)
                                   {
                                       searchTerms = [[NSMutableArray alloc]init];
                                   }
                                   [searchTerms insertObject:term atIndex:0];
                                   
                                   //save here
                                   [self saveArray];
                                   
                                   NSIndexPath * indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
                                   
                                   [self.searchTable insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                                   [self whatToDisplay];
                               }];
    [alert addAction:cancelAction];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}


//Table View Stuff
#pragma mark - UITableView Datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //number of sections to display social media
    return (1);
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //number of terms in the searchTerms
    return searchTerms.count;
}

-(UITableViewCell *)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell* cellToReturn = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cellToReturn == nil)
    {
        cellToReturn = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: cellIdentifier];
    }
    
    //Call a get content function and put content here.
    cellToReturn.textLabel.text = [searchTerms objectAtIndex: indexPath.row];
    
    return (cellToReturn);
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *) indexPath
{
    return YES;
}

// Swipe to delete.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        //removes from array
        [searchTerms removeObjectAtIndex:indexPath.row];
        //save
        [self saveArray];
        
        //remove from table view
        [searchTable deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        [self whatToDisplay];
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
