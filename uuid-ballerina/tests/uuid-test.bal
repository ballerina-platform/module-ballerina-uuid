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
isolated function testNewType4AsString() {
    test:assertEquals(newType4AsString().length(), 36);
}

@test:Config {}
isolated function testNewType3AsString() {
    byte[] nbyte = [10, 20, 30];
    test:assertEquals(newType3AsString(nbyte).length(), 36);
}

@test:Config {}
isolated function testValidate() {
    test:assertTrue(validate("4397465e-35f9-11eb-adc1-0242ac120002"));
}

@test:Config {}
isolated function testNilAsString() {
    test:assertEquals(nilAsString(), "00000000-0000-0000-0000-000000000000");
}

@test:Config {}
isolated function testUuidVersion() {
    test:assertEquals(uuidVersion("4397465e-35f9-11eb-adc1-0242ac120002"), V1);
    test:assertEquals(uuidVersion("a3bb189e-8bf9-3888-9912-ace4e6543002"), V3);
    test:assertEquals(uuidVersion("66a9f41f-4066-46d1-a838-51952fe64ff3"), V4);
    test:assertEquals(uuidVersion("a6edc906-2f9f-5fb2-a373-efac406f0ef2"), V5);
}

@test:Config {}
isolated function testNewType1AsString() {
    test:assertEquals(newType1AsString().length(), 36);
}
