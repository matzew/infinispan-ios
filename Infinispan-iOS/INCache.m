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

#import "INCache.h"
#import "JSONKit.h"
#import "SRWebSocket.h"

@interface INCache() <SRWebSocketDelegate>

@end
@implementation INCache {
    SRWebSocket* client;
     BOOL _open;
}

@synthesize cacheName = _cacheName;
@synthesize wsAddress = _wsAddress;
@synthesize callback = _callback;

- (id)init {
    self = [super init];
    if (self) {
        // init stuff
    }
    return self;
}

-(id)initWith:(NSString*) name url:(NSURL*)url {
    self = [self init];
    if (self) {
        _cacheName = name;
        _wsAddress = url;
        
        client = [[SRWebSocket alloc] initWithURL:_wsAddress];
        client.delegate = self;
        
        // open the cache:
        [client open];
    }

    //  establish the connection:
    // keep the run loop going
    while(!_open) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
    
    return self;
}

+(id)cacheWith:(NSString*) name url:(NSURL*)url {
    return [[self alloc] initWith:name url:url];
}

-(void)put:(NSString*) key value:(NSString*)value {
    //    "opCode" : "put",
    //    "cacheName" : cacheName,
    //    "key" : key,
    //    "value" : value,
    //    "mime" : mimeType
    NSMutableDictionary* data = [NSMutableDictionary dictionary];
    [data setValue:@"put" forKey:@"opCode"];
    [data setValue:_cacheName forKey:@"cacheName"];
    [data setValue:key forKey:@"key"];
    [data setValue:value forKey:@"value"];
    
    // just text/plain......, right now
    [data setValue:@"text/plain" forKey:@"mime"];
    
    NSString* jsonString = [self stringify:data];
    [client send:jsonString];
}


-(void)get:(NSString*) key {
//    "opCode" : "get",
//    "cacheName" : cacheName,
//    "key" : key
    NSMutableDictionary* data = [NSMutableDictionary dictionary];
    [data setValue:@"get" forKey:@"opCode"];
    [data setValue:_cacheName forKey:@"cacheName"];
    [data setValue:key forKey:@"key"];
    
    [client send:[self stringify:data]];
}


-(void)remove:(NSString*) key {
    //    "opCode" : "remove",
    //    "cacheName" : cacheName,
    //    "key" : key
    NSMutableDictionary* data = [NSMutableDictionary dictionary];
    [data setValue:@"remove" forKey:@"opCode"];
    [data setValue:_cacheName forKey:@"cacheName"];
    [data setValue:key forKey:@"key"];
    
    [client send:[self stringify:data]];
}

-(void)notify:(NSString*) key events:(id)events {
//    "opCode" : "notify",
//    "cacheName" : cacheName,
//    "key" : key,
//    "onEvents" : onEvents
    NSMutableDictionary* data = [NSMutableDictionary dictionary];
    [data setValue:@"notify" forKey:@"opCode"];
    [data setValue:_cacheName forKey:@"cacheName"];
    [data setValue:key forKey:@"key"];
    [data setValue:events forKey:@"onEvents"];
    
    [client send:[self stringify:data]];

}

-(void)unnotify:(NSString*) key {
//    "opCode" : "unnotify",
//    "cacheName" : cacheName,
//    "key" : key
    NSMutableDictionary* data = [NSMutableDictionary dictionary];
    [data setValue:@"unnotify" forKey:@"opCode"];
    [data setValue:_cacheName forKey:@"cacheName"];
    [data setValue:key forKey:@"key"];
    
    [client send:[self stringify:data]];
}

#pragma mark - SRWebSocketDelegate

- (void)webSocketDidOpen:(SRWebSocket *)webSocket {
    NSLog(@"Cache Connected");
    _open = YES;
    // queued messages...
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error {
    NSLog(@":( Websocket Failed With Error %@", error);
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
    NSDictionary* dic = [self parse:message];
    if (_callback) {
        _callback([dic valueForKey:@"key"], [dic valueForKey:@"value"]);
    }
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean {
    NSLog(@"WebSocket closed ('%@')", reason);
}


/// JSON helpers:
-(NSString*) stringify:(id) object {
    return [object JSONString];
}
-(id) parse:(NSString*) json {
    return [json objectFromJSONString];
}

@end
