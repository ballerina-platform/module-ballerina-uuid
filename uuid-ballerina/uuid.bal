// Copyright (c) 2020 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/java;

# Returns a UUID of type 4 as a string.
# ```ballerina
# string uuid4 = uuid:newType4AsString();
# ```
#
# + return - UUID of type 4 as a string
public isolated function newType4AsString() returns string {
    var result = java:toString(newType4AsStringExtern());
    if (result is string) {
        return result;
    } else {
        panic error("Error occured when converting the UUID to string.");
    }
}

isolated function newType4AsStringExtern() returns handle = @java:Method {
    name: "randomUUID",
    'class: "java.util.UUID"
} external;

# Returns a UUID of type 3 as a string.
# ```ballerina
# string uuid3 = uuid:newType3AsString([10, 20, 30]);
# ```
#
# + name - the byte array to be used to construct the UUID
#
# + return - UUID of type 3 as a string
public isolated function newType3AsString(byte[] name) returns string = @java:Method {
    name: "nameUUIDFromBytes",
    'class: "org.ballerinalang.stdlib.uuid.nativeimpl.Util"
} external;
