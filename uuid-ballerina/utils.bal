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

import ballerina/jballerina.java;

isolated function getRandomUUID() returns handle = @java:Method {
    name: "randomUUID",
    'class: "java.util.UUID"
} external;

isolated function getUUIDVersion(string uuid) returns int = @java:Method {
    name: "getVersion",
    'class: "org.ballerinalang.stdlib.uuid.nativeimpl.Util"
} external;

isolated function getBytesFromUUID(string uuid) returns byte[] = @java:Method {
    name: "getBytesFromUUID",
    'class: "org.ballerinalang.stdlib.uuid.nativeimpl.Util"
} external;

isolated function getUUIDFromBytes(byte[] uuid) returns string = @java:Method {
    name: "getUUIDFromBytes",
    'class: "org.ballerinalang.stdlib.uuid.nativeimpl.Util"
} external;

isolated function constructComponent(string hex, int length) returns string {
    string hexString = "";
    foreach var i in 0 ..< (length - hex.length()) {
        hexString += "0";
    }
    return hexString + hex;
}
