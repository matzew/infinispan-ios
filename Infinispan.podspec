#
# JBoss, Home of Professional Open Source
# Copyright ${year}, Red Hat, Inc., and individual contributors
# by the @authors tag. See the copyright.txt in the distribution for a
# full listing of individual contributors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
Pod::Spec.new do |s|
  s.name         = "Infinispan"
  s.version      = "0.9.1"
  s.summary      = "Provides an iOS client library to access the JBoss Infinispan Cache"
  s.homepage     = "https://github.com/matzew/infinispan-ios"
  s.license      = 'Apache License, Version 2.0'
  s.author       = "Red Hat, Inc."
  s.source       = { :git => 'https://github.com/matzew/infinispan-ios.git', :tag => '0.9.1' }
  s.platform     = :ios, '5.0'
  s.source_files = 'Infinispan-iOS'
s.public_header_files = 'Infinispan-iOS/Infinispan.h', 'Infinispan-iOS/INCache.h'
  s.requires_arc = true
  s.dependency 'SocketRocket', '0.2.0'
  s.dependency 'JSONKit', '1.4'
end