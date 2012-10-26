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

#import <Foundation/Foundation.h>

@interface INCache : NSObject

@property (nonatomic, readonly) NSString* cacheName;
@property (nonatomic, readonly) NSURL* wsAddress;
@property (nonatomic, copy) void (^callback)(NSString* key, id value);

-(id)initWith:(NSString*) name url:(NSURL*)url;
+(id)cacheWith:(NSString*) name url:(NSURL*)url;

-(void)put:(NSString*) key value:(NSString*)value;
-(void)get:(NSString*) key;
-(void)remove:(NSString*) key;

-(void)notify:(NSString*) key events:(id)events;
-(void)unnotify:(NSString*) key;

@end
