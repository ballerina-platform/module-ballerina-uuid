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

import ballerina/lang.'int as ints;

# String representing the nil uuid.
const string NIL_UUID = "00000000-0000-0000-0000-000000000000";

# Represents a UUID.
#
# + timeLow - The low field of the timestamp
# + timeMid - The middle field of the timestamp
# + timeHiAndVersion - The high field of the timestamp multiplexed with the version number
# + clockSeqHiAndReserved - The high field of the clock sequence multiplexed with the variant
# + clockSeqLo - The low field of the clock sequence
# + node - The spatially unique node identifier
public type Uuid readonly & record {
    ints:Unsigned32 timeLow;
    ints:Unsigned16 timeMid;
    ints:Unsigned16 timeHiAndVersion;
    ints:Unsigned8 clockSeqHiAndReserved;
    ints:Unsigned8 clockSeqLo;
    int node;    // Should be Unsigned48, but not available in lang.int at the moment
};

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

# Represents UUIDs strings of well known namespace IDs.
#
# + NAME_SPACE_DNS- Namespace is a fully-qualified domain name
# + NAME_SPACE_URL- Namespace is a URL
# + NAME_SPACE_OID- Namespace is an ISO OID
# + NAME_SPACE_X500- Namespace is an X.500 DN (in DER or a text output format)
# + NAME_SPACE_NIL- Empty UUID
public enum NamespaceUUID {
    NAME_SPACE_DNS = "6ba7b810-9dad-11d1-80b4-00c04fd430c8",
    NAME_SPACE_URL = "6ba7b811-9dad-11d1-80b4-00c04fd430c8",
    NAME_SPACE_OID = "6ba7b812-9dad-11d1-80b4-00c04fd430c8",
    NAME_SPACE_X500 = "6ba7b814-9dad-11d1-80b4-00c04fd430c8",
    NAME_SPACE_NIL = NIL_UUID
}

# The duration between the Gregorian time (1582-10-15 0:0:0) and UTC start time (1970-01-01 0:0:0) in seconds.
const decimal GREGORIAN_TIME_IN_SECONDS = 12219292800;

# The characters used to generate a UUID string.
# These characters will be converted to bytes and the UUID string will be derived from the byte array. 
final string[] & readonly digits = [
    "0", "1", "2", "3", "4", "5", 
    "6", "7", "8", "9", "a", "b", 
    "c", "d", "e", "f", "g", "h", 
    "i", "j", "k", "l", "m", "n", 
    "o", "p", "q", "r", "s", "t", 
    "u", "v", "w", "x", "y", "z"
];
