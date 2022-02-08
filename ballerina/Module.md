## Overview

This module provides APIs to generate and inspect UUIDs (Universally Unique Identifiers).

The UUIDs are generated based on the [RFC 4122](https://www.rfc-editor.org/rfc/rfc4122.html) standard. This module supports generating 4 versions of UUIDs.

### Version 1

Generated using the MAC address of the computer and the time of generation.

### Version 3

Cryptographic hashing and application-provided text strings are used to generate a UUID. MD5 hashing is used.

### Version 4

Uses a pseudo-random number generator to generate the UUID. Every bit of the string is randomly generated.

### Version 5

Similar to Version 3 but uses SHA-1 instead of MD5.

Other operations include validating a given UUID string and getting the version of a UUID string.
