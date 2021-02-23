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
    }
}

@test:Config {}
isolated function testCreateType3AsRecordNegative() {
    Uuid|Error uuid3 = createType3AsRecord(NAME_SPACE_DNS, " ");
    if (uuid3 is Uuid) {
        test:assertFail("function did not return an error when the name is empty");
    }
}

@test:Config {}
isolated function testCreateType5AsStringNegative() {
    string|Error uuid5 = createType5AsString(NAME_SPACE_DNS, " ");
    if (uuid5 is string) {
        test:assertFail("function did not return an error when the name is empty");
    }
}

@test:Config {}
isolated function testCreateType5AsRecordNegative() {
    Uuid|Error uuid5 = createType5AsRecord(NAME_SPACE_DNS, " ");
    if (uuid5 is Uuid) {
        test:assertFail("function did not return an error when the name is empty");
    }
}

@test:Config {}
isolated function testUuidVersionNegative() {
    Version|Error uuid5 = getVersion("4397465e-invalid-uuid-string-0242ac120002");
    if (uuid5 is Version) {
        test:assertFail("function did not return an error for invalid UUID string");
    }
}

@test:Config {}
isolated function testStringToBytesNegative() {
    byte[]|Error uuid5 = toBytes("4397465e-invalid-uuid-string-0242ac120002");
    if (uuid5 is byte[]) {
        test:assertFail("function did not return an error for invalid UUID string");
    }
}

@test:Config {}
isolated function testStringToRecordNegative() {
    Uuid|Error r1 = toRecord("4397465e-invalid-uuid-string-0242ac120002");
    if (r1 is Uuid) {
        test:assertFail("function did not return an error for invalid UUID string");
    }
    Uuid|Error r2 = toRecord("4397x65e-35f9-11eb-adc1-0242ac120002");
    if (r2 is Uuid) {
        test:assertFail("function did not return an error for invalid UUID string");
    }
    Uuid|Error r3 = toRecord("4397465e-35x9-11eb-adc1-0242ac120002");
    if (r3 is Uuid) {
        test:assertFail("function did not return an error for invalid UUID string");
    }
    Uuid|Error r4 = toRecord("4397465e-35f9-11xb-adc1-0242ac120002");
    if (r4 is Uuid) {
        test:assertFail("function did not return an error for invalid UUID string");
    }
    Uuid|Error r5 = toRecord("4397465e-35f9-11eb-adx1-0242ac120002");
    if (r5 is Uuid) {
        test:assertFail("function did not return an error for invalid UUID string");
    }
    Uuid|Error r6 = toRecord("4397465e-35f9-11eb-adc1-0242ac1200x2");
    if (r6 is Uuid) {
        test:assertFail("function did not return an error for invalid UUID string");
    }
}
