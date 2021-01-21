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
import ballerina/crypto;
import ballerina/lang.'int as ints;
import ballerina/regex;

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
# uuid:Uuid|uuid:Error uuid1 = uuid:createType1AsRecord();
# ```
#
# + return - UUID of type 1 as a UUID record or error
public isolated function createType1AsRecord() returns Uuid|Error {
    return check toRecord(createType1AsString());
}

# Returns a UUID of type 3 as a string.
# ```ballerina
# string|uuid:Error uuid3 = uuid:createType3AsString(uuid:NAME_SPACE_DNS, “ballerina.io”);
# ```
#
# + namespace - string representation for pre-defined namespace UUIDs
# + name - a name within the namespace
#
# + return - UUID of type 3 as a string
public isolated function createType3AsString(NamespaceUUID namespace, string name) returns string|Error {
    string trimmedName = name.trim();
    if (trimmedName.length() == 0) {
        return error Error("Name cannot be empty");
    }
    byte[] namespaceBytes = getBytesFromUUID(namespace);
    byte[] nameBytes = trimmedName.toBytes();
    namespaceBytes.push(...nameBytes);

    byte[] uuid3 = crypto:hashMd5(namespaceBytes);

    uuid3[6] = uuid3[6] & 0x0f;
    uuid3[6] = <byte>(uuid3[6] | 0x30);
    uuid3[8] = uuid3[8] & 0x3f;
    uuid3[8] = <byte>(uuid3[8] | 0x80);
    return getUUIDFromBytes(uuid3);
}

# Returns a UUID of type 3 as a UUID record.
# ```ballerina
# uuid:Uuid|uuid:Error uuid3 = uuid:createType3AsRecord(uuid:NAME_SPACE_DNS, “ballerina.io”);
# ```
#
# + namespace - string representation for pre-defined namespace UUIDs
# + name - a name within the namespace
#
# + return - UUID of type 3 as a UUID record or error
public isolated function createType3AsRecord(NamespaceUUID namespace, string name) returns Uuid|Error {
    string|Error uuid3 = createType3AsString(namespace, name);
    if (uuid3 is string) {
        return check toRecord(uuid3);
    } else {
        return error Error("Failed to create UUID of type 3", uuid3);
    }
}

# Returns a UUID of type 4 as a string.
# ```ballerina
# string uuid4 = uuid:createType4AsString();
# ```
#
# + return - UUID of type 4 as a string
public isolated function createType4AsString() returns string {
    return java:toString(getRandomUUID()).toString();
}

# Returns a UUID of type 4 as a UUID record.
# ```ballerina
# uuid:Uuid|uuid:Error uuid4 = uuid:createType4AsRecord();
# ```
#
# + return - UUID of type 4 as a UUID record or error
public isolated function createType4AsRecord() returns Uuid|Error {
    return check toRecord(createType4AsString());
}

# Returns a UUID of type 5 as a string.
# ```ballerina
# string|uuid:Error uuid5 = uuid:createType5AsString(uuid:NAME_SPACE_DNS, “ballerina.io”);
# ```
#
# + namespace - string representation for pre-defined namespace UUIDs
# + name - a name within the namespace
#
# + return - UUID of type 5 as a string
public isolated function createType5AsString(NamespaceUUID namespace, string name) returns string|Error {
    string trimmedName = name.trim();
    if (trimmedName.length() == 0) {
        return error Error("Name cannot be empty");
    }
    byte[] namespaceBytes = getBytesFromUUID(namespace);
    byte[] nameBytes = trimmedName.toBytes();
    namespaceBytes.push(...nameBytes);

    byte[] uuid5 = crypto:hashSha1(namespaceBytes);

    uuid5[6] = uuid5[6] & 0x0f;
    uuid5[6] = <byte>(uuid5[6] | 0x50);
    uuid5[8] = uuid5[8] & 0x3f;
    uuid5[8] = <byte>(uuid5[8] | 0x80);
    return getUUIDFromBytes(uuid5);
}

# Returns a UUID of type 5 as a UUID record.
# ```ballerina
# uuid:Uuid|uuid:Error uuid5 = uuid:createType5AsRecord(uuid:NAME_SPACE_DNS, “ballerina.io”);
# ```
#
# + namespace - string representation for pre-defined namespace UUIDs
# + name - a name within the namespace
#
# + return - UUID of type 5 as a UUID record or error
public isolated function createType5AsRecord(NamespaceUUID namespace, string name) returns Uuid|Error {
    string|Error uuid5 = createType5AsString(namespace, name);
    if (uuid5 is string) {
        return check toRecord(uuid5);
    } else {
        return error Error("Failed to create UUID of type 3", uuid5);
    }
}

# Returns a nil UUID as a string.
# ```ballerina
# string nilUUID = uuid:nilAsString();
# ```
#
# + return - nil UUID
public isolated function nilAsString() returns string {
    return NIL_UUID;
}

# Returns a nil UUID as a UUID record.
# ```ballerina
# uuid:Uuid nilUUID = uuid:nilAsRecord();
# ```
#
# + return - nil UUID
public isolated function nilAsRecord() returns Uuid {
    Uuid nilUuid = {
        timeLow: 0,
        timeMid: 0,
        timeHiAndVersion: 0,
        clockSeqHiAndReserved: 0,
        clockSeqLo: 0,
        node: 0
    };
    return nilUuid;
}

# Test a string to see if it is a valid UUID.
# ```ballerina
# boolean valid = uuid:validate("4397465e-35f9-11eb-adc1-0242ac120002");
# ```
#
# + uuid - UUID to be tested
#
# + return - true if a valied UUID, false if not
public isolated function validate(string uuid) returns boolean {
    return regex:matches(uuid, "[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}");
}

# Detect RFC version of a UUID. Returns an error if the UUID is invalid.
# ```ballerina
# uuid:Version|uuid:Error v = uuid:getVersion("4397465e-35f9-11eb-adc1-0242ac120002");
# ```
#
# + uuid - UUID
#
# + return - UUID version, or error
public isolated function getVersion(string uuid) returns Version|Error {
    if (!validate(uuid)) {
        return error Error("Invalid UUID string provided");
    }
    int v = getUUIDVersion(uuid);
    match v {
        1 => {
            return V1;
        }
        3 => {
            return V3;
        }
        4 => {
            return V4;
        }
        5 => {
            return V5;
        }
        _ => {
            return error Error("Unsupported UUID version");
        }
    }
}

# Convert to an array of bytes. Returns an error if the UUID is invalid.
# ```ballerina
# byte[]|uuid:Error b = uuid:toBytes(“6ec0bd7f-11c0-43da-975e-2aesass0b”);
# ```
#
# + uuid - UUID to be converted
#
# + return - UUID as bytes
public isolated function toBytes(string|Uuid uuid) returns byte[]|Error {
    if (uuid is string) {
        if (!validate(uuid)) {
            return error Error("Invalid UUID string provided");
        }
        return getBytesFromUUID(uuid);
    } else {
        var uuidString = toString(uuid);
        if (uuidString is string) {
            return getBytesFromUUID(uuidString);
        } else {
            return error Error("Failed to convert UUID record to a string", uuidString);
        }
    }
}

# Convert to UUID string. Returns error if the array is invalid.
# ```ballerina
# string|error s = uuid:toString([5, 12, 16, 35]);
# ```
#
# + uuid - UUID to be converted
#
# + return - UUID as string
public isolated function toString(byte[]|Uuid uuid) returns string|error {
    if (uuid is byte[]) {
        return getUUIDFromBytes(uuid);
    } else {
        return constructComponent(ints:toHexString(uuid.timeLow), 8) + "-" +
        constructComponent(ints:toHexString(uuid.timeMid), 2) + "-" +
        constructComponent(ints:toHexString(uuid.timeHiAndVersion), 2) + "-" +
        constructComponent(ints:toHexString(uuid.clockSeqHiAndReserved), 1) +
        constructComponent(ints:toHexString(uuid.clockSeqLo), 1) + "-" +
        constructComponent(ints:toHexString(uuid.node), 12);
    }
}

# Convert to UUID record. Returns error if the array is invalid.
# ```ballerina
# uuid:Uuid|uuid:Error r1 = uuid:toRecord("4397465e-35f9-11eb-adc1-0242ac120002");
# uuid:Uuid|uuid:Error r2 = uuid:toRecord([10, 20, 30]);
# ```
#
# + uuid - UUID to be converted
#
# + return - UUID as record
public isolated function toRecord(string|byte[] uuid) returns Uuid|Error {
    ints:Unsigned32 timeLowInt;
    ints:Unsigned16 timeMidInt;
    ints:Unsigned16 timeHiAndVersionInt;
    ints:Unsigned8 clockSeqHiAndReservedInt;
    ints:Unsigned8 clockSeqLoInt;
    int nodeInt;
    string[] uuidArray;

    if (uuid is string) {
        if (!validate(uuid)) {
            return error Error("Invalid UUID string provided");
        }
        uuidArray = regex:split(uuid, "-");
    } else {
        uuidArray = regex:split(getUUIDFromBytes(uuid), "-");
    }
    ints:Unsigned32|error timeLowResult = <ints:Unsigned32> checkpanic (ints:fromHexString(uuidArray[0]));
    if (timeLowResult is error) {
        return error Error("Failed to get int value of time-low hex string", timeLowResult);
    } else {
        timeLowInt = timeLowResult;
    }
    ints:Unsigned16|error timeMidResult = <ints:Unsigned16> checkpanic (ints:fromHexString(uuidArray[1]));
    if (timeMidResult is error) {
        return error Error("Failed to get int value of time-mid hex string", timeMidResult);
    } else {
        timeMidInt = timeMidResult;
    }
    ints:Unsigned16|error timeHiAndVersionResult = <ints:Unsigned16> checkpanic (ints:fromHexString(uuidArray[2]));
    if (timeHiAndVersionResult is error) {
        return error Error("Failed to get int value of time-hi-and-version hex string", timeHiAndVersionResult);
    } else {
        timeHiAndVersionInt = timeHiAndVersionResult;
    }
    ints:Unsigned8|error clockSeqHiAndReservedResult = <ints:Unsigned8> checkpanic (ints:fromHexString(
    uuidArray[3].substring(0, 2)));
    if (clockSeqHiAndReservedResult is error) {
        return error Error("Failed to get int value of clock-seq-hi-and-reserved hex string",
        clockSeqHiAndReservedResult);
    } else {
        clockSeqHiAndReservedInt = clockSeqHiAndReservedResult;
    }
    ints:Unsigned8|error clockSeqLoResult = <ints:Unsigned8> checkpanic
    (ints:fromHexString(uuidArray[3].substring(2, 4)));
    if (clockSeqLoResult is error) {
        return error Error("Failed to get int value of clock-seq-lo hex string", clockSeqLoResult);
    } else {
        clockSeqLoInt = clockSeqLoResult;
    }
    int|error nodeResult = ints:fromHexString(uuidArray[4]);
    if (nodeResult is error) {
        return error Error("Failed to get int value of node string", nodeResult);
    } else {
        nodeInt = nodeResult;
    }
    Uuid uuidRecord = {
        timeLow: timeLowInt,
        timeMid: timeMidInt,
        timeHiAndVersion: timeHiAndVersionInt,
        clockSeqHiAndReserved: clockSeqHiAndReservedInt,
        clockSeqLo: clockSeqLoInt,
        node: nodeInt
    };
    return uuidRecord;
}
