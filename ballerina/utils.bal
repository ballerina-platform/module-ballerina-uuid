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
import ballerina/time;
import ballerina/regex;

isolated function generateLeastSigBits() returns int {
    int random63BitLong = nextLong() & 0x3FFFFFFFFFFFFFFF;
    int variant3BitFlag = -0x8000000000000000;
    return random63BitLong + variant3BitFlag;
}

isolated function generateMostSigBits() returns int {
    decimal gregorianTimeInSeconds = 12219292800;
    time:Utc duration = time:utcAddSeconds(time:utcNow(), gregorianTimeInSeconds);
    int timeInNanos = duration[0] * 10000000 + <int>duration[1] * 100;

    int leastSigBitOfTime = (timeInNanos & 0x000000000000FFFF) >> 4;
    int uuidVersion = 1 << 12;
    return (timeInNanos & 0x7FFFFFFFFFFF0000) + uuidVersion + leastSigBitOfTime;
}

isolated function getBytesFromUuid(string uuid) returns byte[]|Error {
    int msb = check getMostSignificantBits(uuid);
    int lsb = check getLeastSignificantBits(uuid);
    return getBytesFromSignificantBits(msb, lsb);
}

isolated function getMostSignificantBits(string uuid) returns int|Error {
    Uuid u = check toRecord(uuid);

    int mostSigBits = u.timeLow & 0xffffffff;
    mostSigBits <<= 16;
    mostSigBits |= u.timeMid & 0xffff;
    mostSigBits <<= 16;
    mostSigBits |= u.timeHiAndVersion & 0xffff;

    return mostSigBits;
}

isolated function getLeastSignificantBits(string uuid) returns int|Error {
    Uuid u = check toRecord(uuid);

    int leastSigBits;
    string clockSeq = regex:split(uuid, "-")[3];
    int|error clockSeqInt = int:fromHexString(clockSeq);
    if clockSeqInt is int {
        leastSigBits = clockSeqInt & 0xffff;
    } else {
        return error Error("Failed to get clock sequence value of the uuid");
    }

    leastSigBits <<= 48;
    leastSigBits |= u.node & 0xffffffffffff;

    return leastSigBits;
}

isolated function getUuidFromBytes(byte[] uuid) returns string {
    int msb = ((uuid[0] & 0xFF) << 56) |
            ((uuid[1] & 0xFF) << 48) |
            ((uuid[2] & 0xFF) << 40) |
            ((uuid[3] & 0xFF) << 32) |
            ((uuid[4] & 0xFF) << 24) |
            ((uuid[5] & 0xFF) << 16) |
            ((uuid[6] & 0xFF) << 8) |
            ((uuid[7] & 0xFF) << 0);

    int lsb = ((uuid[8] & 0xFF) << 56) |
            ((uuid[9] & 0xFF) << 48) |
            ((uuid[10] & 0xFF) << 40) |
            ((uuid[11] & 0xFF) << 32) |
            ((uuid[12] & 0xFF) << 24) |
            ((uuid[13] & 0xFF) << 16) |
            ((uuid[14] & 0xFF) << 8) |
            ((uuid[15] & 0xFF) << 0);

    return getUuidFromSignificantBits(msb, lsb);
}

isolated function getBytesFromSignificantBits(int msb, int lsb) returns byte[] {
    byte[] result = [];

    result[0] = <byte>((msb >> 56) & 0xff);
    result[1] = <byte>((msb >> 48) & 0xff);
    result[2] = <byte>((msb >> 40) & 0xff);
    result[3] = <byte>((msb >> 32) & 0xff);
    result[4] = <byte>((msb >> 24) & 0xff);
    result[5] = <byte>((msb >> 16) & 0xff);
    result[6] = <byte>((msb >> 8) & 0xff);
    result[7] = <byte>((msb >> 0) & 0xff);

    result[8] = <byte>((lsb >> 56) & 0xff);
    result[9] = <byte>((lsb >> 48) & 0xff);
    result[10] = <byte>((lsb >> 40) & 0xff);
    result[11] = <byte>((lsb >> 32) & 0xff);
    result[12] = <byte>((lsb >> 24) & 0xff);
    result[13] = <byte>((lsb >> 16) & 0xff);
    result[14] = <byte>((lsb >> 8) & 0xff);
    result[15] = <byte>((lsb >> 0) & 0xff);

    return result;
}

isolated function getUuidFromSignificantBits(int mostSigBits, int leastSigBits) returns string {

    byte[] bytes1 = formatUnsignedInt(leastSigBits, 4,12);
    byte[] bytes2 = formatUnsignedInt(leastSigBits >>> 48, 4, 4);
    byte[] bytes3 = formatUnsignedInt(mostSigBits, 4, 4);
    byte[] bytes4 = formatUnsignedInt(mostSigBits >>> 16, 4, 4);
    byte[] bytes5 = formatUnsignedInt(mostSigBits >>> 32, 4, 8);
    
    return checkpanic string:fromBytes(constructUuidBytesArray([bytes5,bytes4, bytes3, bytes2, bytes1]));
}

isolated function constructUuidBytesArray(byte[][] byteArrays) returns byte[] {
    byte[] bytes = [];
    int count = 0;
    foreach var byteArray in byteArrays {
        foreach int i in 0...byteArray.length() - 1 {
            bytes.push(byteArray[i]);
        }
        if count < byteArrays.length() - 1 {
            bytes.push("-".toBytes()[0]);
        }
        count+=1;
    }
    return bytes;
}

isolated function formatUnsignedInt(int val, int shift, int len) returns byte[] {
    byte[] buf = [];
    int result = val;
    int charPos = len - 1;
    int radix = 1 << shift;
    int mask = radix - 1;

    while charPos > -1 {
        buf[charPos] = digits[result & mask].toBytes()[0];
        result >>>= shift;
        charPos -= 1;
    }
    return buf;
}

isolated function constructComponent(string hex, int length) returns string {
    string hexString = "";
    foreach var _ in 0 ..< (length - hex.length()) {
        hexString += "0";
    }
    return hexString + hex;
}

isolated function nextLong() returns int {
    handle randomObj = newRandom();
    return nextLongExtern(randomObj);
}

isolated function newRandom() returns handle = @java:Constructor {
   'class: "java.util.Random"
} external;

isolated function nextLongExtern(handle randomObj) returns int = @java:Method {
    name: "nextLong",
   'class: "java.util.Random"
} external;

isolated function getRandomUUID() returns handle = @java:Method {
    name: "randomUUID",
    'class: "java.util.UUID"
} external;
