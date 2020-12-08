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
isolated function testCreateType1AsString() {
    test:assertEquals(createType1AsString().length(), 36);
}

@test:Config {}
isolated function testCreateType1AsRecord() {
    test:assertTrue(createType1AsRecord() is UUID);
}

@test:Config {}
isolated function testCreateType3AsString() {
    test:assertEquals(createType3AsString(NameSpaceDNS, "python.org"), "6fa459ea-ee8a-3ca4-894e-db77e160355e");
}

@test:Config {}
isolated function testCreateType3AsRecord() {
    UUID expcectedUUID = {
        timeLow: 1873041898,
        timeMid: 61066,
        timeHiAndVersion: 15524,
        clockSeqHiAndReserved: 137,
        clockSeqLo: 78,
        node: 241307928769886
    };
    UUID|error actualUUID = createType3AsRecord(NameSpaceDNS, "python.org");
    test:assertTrue(actualUUID is UUID);
    if (actualUUID is UUID) {
        test:assertEquals(actualUUID, expcectedUUID);
    }
}

@test:Config {}
isolated function testCreateType4AsString() {
    test:assertEquals(createType4AsString().length(), 36);
}

@test:Config {}
isolated function testCreateType4AsRecord() {
    test:assertTrue(createType4AsRecord() is UUID);
}

@test:Config {}
isolated function testCreateType5AsString() {
    test:assertEquals(createType5AsString(NameSpaceDNS, "python.org"), "886313e1-3b8a-5372-9b90-0c9aee199e5d");
}

@test:Config {}
isolated function testCreateType5AsRecord() {
    UUID expcectedUUID = {
        timeLow: 2288194529,
        timeMid: 15242,
        timeHiAndVersion: 21362,
        clockSeqHiAndReserved: 155,
        clockSeqLo: 144,
        node: 13859559153245
    };
    UUID|error actualUUID = createType5AsRecord(NameSpaceDNS, "python.org");
    test:assertTrue(actualUUID is UUID);
    if (actualUUID is UUID) {
        test:assertEquals(actualUUID, expcectedUUID);
    }
}

@test:Config {}
isolated function testNilAsString() {
    test:assertEquals(nilAsString(), "00000000-0000-0000-0000-000000000000");
}

@test:Config {}
isolated function testNilAsRecord() {
    UUID expcectedUUID = {
        timeLow: 0,
        timeMid: 0,
        timeHiAndVersion: 0,
        clockSeqHiAndReserved: 0,
        clockSeqLo: 0,
        node: 0
    };
    test:assertEquals(nilAsRecord(), expcectedUUID);
}

@test:Config {}
isolated function testValidate() {
    test:assertTrue(validate("4397465e-35f9-11eb-adc1-0242ac120002"));
    test:assertFalse(validate("invalid-uuid-string"));
}

@test:Config {}
isolated function testUuidVersion() {
    test:assertEquals(uuidVersion("4397465e-35f9-11eb-adc1-0242ac120002"), V1);
    test:assertEquals(uuidVersion("6fa459ea-ee8a-3ca4-894e-db77e160355e"), V3);
    test:assertEquals(uuidVersion("66a9f41f-4066-46d1-a838-51952fe64ff3"), V4);
    test:assertEquals(uuidVersion("886313e1-3b8a-5372-9b90-0c9aee199e5d"), V5);
}

@test:Config {}
isolated function testStringToBytes() {
    test:assertEquals(toBytes("4397465e-35f9-11eb-adc1-0242ac120002"),
    [67,151,70,94,53,249,17,235,173,193,2,66,172,18,0,2]);
}

@test:Config {}
isolated function testRecordToBytes() {
    UUID uuid = {
        timeLow: 1133987422,
        timeMid: 13817,
        timeHiAndVersion: 4587,
        clockSeqHiAndReserved: 173,
        clockSeqLo: 193,
        node: 2485377957890
    };
    test:assertEquals(toBytes(uuid), [67,151,70,94,53,249,17,235,173,193,2,66,172,18,0,2]);
}

@test:Config {}
isolated function testRecordToString() {
    UUID uuid = {
        timeLow: 1133987422,
        timeMid: 13817,
        timeHiAndVersion: 4587,
        clockSeqHiAndReserved: 173,
        clockSeqLo: 193,
        node: 2485377957890
    };
    test:assertEquals(toString(uuid), "4397465e-35f9-11eb-adc1-0242ac120002");
}

@test:Config {}
isolated function testBytesToString() {
    test:assertEquals(toString([67,151,70,94,53,249,17,235,173,193,2,66,172,18,0,2]),
    "4397465e-35f9-11eb-adc1-0242ac120002");
}

@test:Config {}
isolated function testStringToRecord() {
    UUID expcectedUUID = {
        timeLow: 1133987422,
        timeMid: 13817,
        timeHiAndVersion: 4587,
        clockSeqHiAndReserved: 173,
        clockSeqLo: 193,
        node: 2485377957890
    };
    test:assertEquals(toRecord("4397465e-35f9-11eb-adc1-0242ac120002"), expcectedUUID);
}

@test:Config {}
isolated function testBytesToRecord() {
    UUID expcectedUUID = {
        timeLow: 1133987422,
        timeMid: 13817,
        timeHiAndVersion: 4587,
        clockSeqHiAndReserved: 173,
        clockSeqLo: 193,
        node: 2485377957890
    };
    test:assertEquals(toRecord([67,151,70,94,53,249,17,235,173,193,2,66,172,18,0,2]), expcectedUUID);
}
