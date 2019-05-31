# 网络解析数据
NSURLConnection同步
```
[NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
```
NSURLConnection异步
```
[NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if(data!=nil){
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
           
            //重点，重新加载table
            [self.table reloadData];
            
        }
        if(connectionError!=nil){
            NSLog(@"%@",[connectionError description]);
        }
        if(data==nil&&connectionError==nil)
            NSLog(@"null data");
    }];
```

NSSession 网络解析数据
```
NSURLSession *session = [NSURLSession sharedSession];
NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                    
                    //重点，重新加载table
                    [self.table reloadData];

}];
//发送
[task resume];
```

