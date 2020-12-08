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
import ballerina/crypto;
import ballerina/lang.'int as ints;
import ballerina/stringutils;

# Returns a UUID of type 1 as a string.
# ```ballerina
# string uuid1 = uuid:createType1AsString();
# ```
#
# + return - UUID of type 1 as a string
public isolated function createType1AsString() returns string = @java:Method {
    name: "generateType1UUID",
    'class: "org.ballerinalang.stdlib.uuid.nativeimpl.Util"
} external;

# Returns a UUID of type 1 as a UUID record.
# ```ballerina
# UUID|error uuid1 = uuid:createType1AsRecord();
# ```
#
# + return - UUID of type 1 as a UUID record or error
public isolated function createType1AsRecord() returns UUID|error {
    return check toRecord(createType1AsString());
}

# Returns a UUID of type 3 as a string.
# ```ballerina
# string uuid3 = uuid:createType3AsString(uuid:NameSpaceDNS, “python.org”);
# ```
#
# + name - name
# + namespace - namespace
#
# + return - UUID of type 3 as a string
public isolated function createType3AsString(NamespaceUUID namespace, string name) returns string {
    byte[] namespaceBytes = getBytesFromUUID(namespace);
    byte[] nameBytes = name.toBytes();

    namespaceBytes.push(...nameBytes);

    byte[] uuid = crypto:hashMd5(namespaceBytes);

    uuid[6] = uuid[6] & 0x0f;
    uuid[6] = <byte>(uuid[6] | 0x30);
    uuid[8] = uuid[8] & 0x3f;
    uuid[8] = <byte>(uuid[8] | 0x80);
    return getUUIDFromBytes(uuid);
}

# Returns a UUID of type 4 as a string.
# ```ballerina
# string uuid4 = uuid:createType4AsString();
# ```
#
# + return - UUID of type 4 as a string
public isolated function createType4AsString() returns string {
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

# Returns a UUID of type 5 as a string.
# ```ballerina
# string uuid5 = uuid:createType5AsString(uuid:NameSpaceDNS, “python.org”);
# ```
#
# + name - name
# + namespace - namespace
#
# + return - UUID of type 5 as a string
public isolated function createType5AsString(NamespaceUUID namespace, string name) returns string {
    byte[] namespaceBytes = getBytesFromUUID(namespace);
    byte[] nameBytes = name.toBytes();

    namespaceBytes.push(...nameBytes);

    byte[] uuid = crypto:hashSha1(namespaceBytes);

    uuid[6] = uuid[6] & 0x0f;
    uuid[6] = <byte>(uuid[6] | 0x50);
    uuid[8] = uuid[8] & 0x3f;
    uuid[8] = <byte>(uuid[8] | 0x80);
    return getUUIDFromBytes(uuid);
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

isolated function getBytesFromUUID(string uuid) returns byte[] = @java:Method {
    name: "getBytesFromUUID",
    'class: "org.ballerinalang.stdlib.uuid.nativeimpl.Util"
} external;

isolated function getUUIDFromBytes(byte[] uuid) returns string = @java:Method {
    name: "getUUIDFromBytes",
    'class: "org.ballerinalang.stdlib.uuid.nativeimpl.Util"
} external;

# Convert to UUID record. Returns error if the array is invalid.
# ```ballerina
# UUID|error r1 = uuid:toRecord("4397465e-35f9-11eb-adc1-0242ac120002");
# UUID|error r2 = uuid:toRecord([10, 20, 30]);
# ```
#
# + uuid - UUID to be converted
#
# + return - corresponding UUID
public isolated function toRecord(string|byte[] uuid) returns UUID|error {
    string[] uuidArray;
    if (uuid is string) {
        if (!validate(uuid)) {
            return error("invalid uuid");
        }
        uuidArray = stringutils:split(uuid, "-");
    } else {
        uuidArray = stringutils:split(getUUIDFromBytes(uuid), "-");
    }
    int timeLowInt = check ints:fromHexString(uuidArray[0]);
    int timeMidInt = check ints:fromHexString(uuidArray[1]);
    int timeHiAndVersionInt = check ints:fromHexString(uuidArray[2]);
    int clockSeqHiAndReservedInt = check ints:fromHexString(uuidArray[3].substring(0, 2));
    int clockSeqLoInt = check ints:fromHexString(uuidArray[3].substring(2, 4));
    int nodeInt = check ints:fromHexString(uuidArray[4]);
    UUID uuidRecord = {
        timeLow: <ints:Unsigned32>timeLowInt,
        timeMid: <ints:Unsigned16>timeMidInt,
        timeHiAndVersion: <ints:Unsigned16>timeHiAndVersionInt,
        clockSeqHiAndReserved: <ints:Unsigned8>clockSeqHiAndReservedInt,
        clockSeqLo: <ints:Unsigned8>clockSeqLoInt,
        node: nodeInt
    };
    return uuidRecord;
}