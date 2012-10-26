/*
 * JBoss, Home of Professional Open Source.
 * Copyright 2012 Red Hat, Inc., and individual contributors
 * as indicated by the @author tags.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
#import <SenTestingKit/SenTestingKit.h>
#import "INCache.h"

@interface Infinispan_iOSTests : SenTestCase

@end
@implementation Infinispan_iOSTests{
     BOOL _finishedFlag;
}

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testExample
{
//    NSMutableDictionary* object = [NSMutableDictionary dictionary];
//    [object setValue:@"A" forKey:@"keyA"];
//    [object setValue:@"B" forKey:@"keyB"];
//    [object setValue:@"C" forKey:@"keyC"];
//    
//    NSData *JSONData = [NSJSONSerialization dataWithJSONObject:object options:0 error:nil];
//    NSLog(@"\n\n\n%@\n\n", [[NSString alloc] initWithData:JSONData encoding:NSUTF8StringEncoding]);
//    
//    
//    NSDictionary* RET = [NSJSONSerialization JSONObjectWithData:JSONData options:0 error:nil];
//    
//    NSLog(@"\n\n\n%@\n\n", [RET valueForKey:@"keyA"]);
    
    
    
    INCache* cache = [INCache cacheWith:@"" url:[NSURL URLWithString:@"ws://localhost:8181"]];
    
    NSLog(@"BEFORE");
    
    [cache put:@"SOME_KEY" value:@"AWESOME........"];
    
    NSLog(@"AFTER");
    
    
    
    // keep the run loop going
    while(!_finishedFlag) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
    
    
    
    
    
}

@end
