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
    test:assertEquals(createType3AsString(NAME_SPACE_DNS, " "), error Error("Name cannot be empty"));
}

@test:Config {}
isolated function testCreateType3AsRecordNegative() {
    test:assertEquals(createType3AsString(NAME_SPACE_DNS, " "), error Error("Name cannot be empty"));
}

@test:Config {}
isolated function testCreateType5AsStringNegative() {
    test:assertEquals(createType5AsString(NAME_SPACE_DNS, " "), error Error("Name cannot be empty"));
}

@test:Config {}
isolated function testCreateType5AsRecordNegative() {
    test:assertEquals(createType5AsString(NAME_SPACE_DNS, " "), error Error("Name cannot be empty"));
}

@test:Config {}
isolated function testUuidVersionNegative() {
    test:assertEquals(getVersion("4397465e-invalid-uuid-string-0242ac120002"),
    error Error("Invalid UUID string provided"));
}

@test:Config {}
isolated function testStringToBytesNegative() {
    test:assertEquals(toBytes("4397465e-invalid-uuid-string-0242ac120002"), error Error("Invalid UUID string provided"));
}

@test:Config {}
isolated function testStringToRecordNegative() {
    test:assertEquals(toRecord("4397465e-invalid-uuid-string-0242ac120002"), error Error("Invalid UUID string provided"));
    test:assertEquals(toRecord("4397x65e-35f9-11eb-adc1-0242ac120002"), error Error("Invalid UUID string provided"));
    test:assertEquals(toRecord("4397465e-35x9-11eb-adc1-0242ac120002"), error Error("Invalid UUID string provided"));
    test:assertEquals(toRecord("4397465e-35f9-11xb-adc1-0242ac120002"), error Error("Invalid UUID string provided"));
    test:assertEquals(toRecord("4397465e-35f9-11eb-adx1-0242ac120002"), error Error("Invalid UUID string provided"));
    test:assertEquals(toRecord("4397465e-35f9-11eb-adc1-0242ac1200x2"), error Error("Invalid UUID string provided"));
}
