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
import ballerina/stringutils;

# Represents the UUID versions.
#
# + V1- UUID generated using the MAC address of the computer and the time of generation
# + V3- UUID generated using MD5 hashing and application-provided text string
# + V4- UUID generated using a pseudo-random number generator
# + V5- UUID generated using SHA-1 hashing and application-provided text string
public enum Version {
    V1,
    V3,
    V4,
    V5
}

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

# Test a string to see if it is a valid UUID.
# ```ballerina
# boolean valid = uuid:validate(“6ec0bd7f-11c0-43da-975e-e0b”);
# ```
#
# + uuid - UUID to be tested
#
# + return - true if a valied UUID, false if not
public isolated function validate(string uuid) returns boolean {
    return stringutils:matches(uuid, "[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}");
}

# Returns a nil UUID as a string.
# ```ballerina
# string nilUUID = uuid:nilAsString();
# ```
#
# + return - nil UUID
public isolated function nilAsString() returns string {
    return "00000000-0000-0000-0000-000000000000";
}

# Detect RFC version of a UUID. Returns an error if the uuid is invalid.
# ```ballerina
# uuid:UUIDVersion|error v = uuid:uuidVersion(“6ed7f-11c0-43da-975e-2b”);
# ```
#
# + uuid - UUID
#
# + return - uuid version, or error
public isolated function uuidVersion(string uuid) returns Version|error {
    int v = uuidVersionExtern(uuidObjectFromString(uuid));
    if (v == 1) {
        return V1;
    } else if (v == 3) {
        return V3;
    } else if (v == 4) {
        return V4;
    } else if (v == 5) {
        return V5;
    } else {
        if (!validate(uuid)) {
            return error("invalid uuid");
        } else {
            return error("unsupported uuid type");
        }
    }
}

isolated function uuidVersionExtern(handle uuid) returns int = @java:Method {
    name: "version",
    'class: "java.util.UUID"
} external;

isolated function uuidObjectFromString(string uuid) returns handle = @java:Method {
    name: "fromString",
    'class: "org.ballerinalang.stdlib.uuid.nativeimpl.Util"
} external;
