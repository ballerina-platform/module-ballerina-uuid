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

import ballerina/test;

@test:Config {}
isolated function testCreateType3AsStringNegative() {
    string|Error uuid3 = createType3AsString(NAME_SPACE_DNS, " ");
    if (uuid3 is string) {
        test:assertFail("function did not return an error when the name is empty");
    } else {
        test:assertEquals(uuid3.message(), "Name cannot be empty");
    }
}

@test:Config {}
isolated function testCreateType3AsRecordNegative() {
    Uuid|Error uuid3 = createType3AsRecord(NAME_SPACE_DNS, " ");
    if (uuid3 is Uuid) {
        test:assertFail("function did not return an error when the name is empty");
    } else {
        test:assertEquals(uuid3.message(), "Failed to create UUID of type 3");
        test:assertEquals((<error>uuid3.cause()).message(), "Name cannot be empty");
    }
}

@test:Config {}
isolated function testCreateType5AsStringNegative() {
    string|Error uuid5 = createType5AsString(NAME_SPACE_DNS, " ");
    if (uuid5 is string) {
        test:assertFail("function did not return an error when the name is empty");
    } else {
        test:assertEquals(uuid5.message(), "Name cannot be empty");
    }
}

@test:Config {}
isolated function testCreateType5AsRecordNegative() {
    Uuid|Error uuid5 = createType5AsRecord(NAME_SPACE_DNS, " ");
    if (uuid5 is Uuid) {
        test:assertFail("function did not return an error when the name is empty");
    } else {
        test:assertEquals(uuid5.message(), "Failed to create UUID of type 3");
        test:assertEquals((<error>uuid5.cause()).message(), "Name cannot be empty");
    }
}

@test:Config {}
isolated function testUuidVersionNegative() {
    Version|Error v = getVersion("4397465e-invalid-uuid-string-0242ac120002");
    if (v is Version) {
        test:assertFail("function did not return an error for invalid UUID string");
    } else {
        test:assertEquals(v.message(), "Invalid UUID string provided");
    }
}

@test:Config {}
isolated function testStringToBytesNegative() {
    byte[]|Error b = toBytes("4397465e-invalid-uuid-string-0242ac120002");
    if (b is byte[]) {
        test:assertFail("function did not return an error for invalid UUID string");
    } else {
        test:assertEquals(b.message(), "Invalid UUID string provided");
    }
}

@test:Config {}
isolated function testStringToRecordNegative() {
    Uuid|Error r = toRecord("4397465e-invalid-uuid-string-0242ac120002");
    if (r is Uuid) {
        test:assertFail("function did not return an error for invalid UUID string");
    } else {
        test:assertEquals(r.message(), "Invalid UUID string provided");
    }
}
