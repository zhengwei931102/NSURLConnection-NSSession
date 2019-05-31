# Session
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
