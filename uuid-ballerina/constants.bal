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

public type UUID readonly & record {
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
# + NameSpaceDNS- Namespace is a fully-qualified domain name
# + NameSpaceURL- Namespace is a URL
# + NameSpaceOID- Namespace is an ISO OID
# + NameSpaceX500- Namespace is an X.500 DN (in DER or a text output format)
# + NameSpaceNil- Empty UUID
public enum NamespaceUUID {
    NameSpaceDNS = "6ba7b810-9dad-11d1-80b4-00c04fd430c8",
    NameSpaceURL = "6ba7b811-9dad-11d1-80b4-00c04fd430c8",
    NameSpaceOID = "6ba7b812-9dad-11d1-80b4-00c04fd430c8",
    NameSpaceX500 = "6ba7b814-9dad-11d1-80b4-00c04fd430c8",
    NameSpaceNil = "00000000-0000-0000-0000-000000000000"
}
