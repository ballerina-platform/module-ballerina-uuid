Ballerina UUID Library
===================

  [![Build](https://github.com/ballerina-platform/module-ballerina-uuid/actions/workflows/build-timestamped-master.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerina-uuid/actions/workflows/build-timestamped-master.yml)
  [![Trivy](https://github.com/ballerina-platform/module-ballerina-uuid/actions/workflows/trivy-scan.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerina-uuid/actions/workflows/trivy-scan.yml)
  [![GitHub Last Commit](https://img.shields.io/github/last-commit/ballerina-platform/module-ballerina-uuid.svg)](https://github.com/ballerina-platform/module-ballerina-uuid/commits/main)
  [![Github issues](https://img.shields.io/github/issues/ballerina-platform/ballerina-standard-library/module/uuid.svg?label=Open%20Issues)](https://github.com/ballerina-platform/ballerina-standard-library/labels/module%2Fuuid)
  [![codecov](https://codecov.io/gh/ballerina-platform/module-ballerina-uuid/branch/main/graph/badge.svg)](https://codecov.io/gh/ballerina-platform/module-ballerina-uuid)

This library provides APIs to generate and inspect UUIDs (Universally Unique Identifiers).

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

## Issues and projects

Issues and Projects tabs are disabled for this repository as this is part of the Ballerina Standard Library. To report bugs, request new features, start new discussions, view project boards, etc. please visit Ballerina Standard Library [parent repository](https://github.com/ballerina-platform/ballerina-standard-library).

This repository only contains the source code for the package.

## Build from the source

### Set up the prerequisites

1. Download and install Java SE Development Kit (JDK) version 11 (from one of the following locations).
   * [Oracle](https://www.oracle.com/java/technologies/javase-jdk11-downloads.html)
   
   * [OpenJDK](https://adoptopenjdk.net/)
   
        > **Note:** Set the JAVA_HOME environment variable to the path name of the directory into which you installed JDK.
     
2. Export Github Personal access token with read package permissions as follows,
   
              export packageUser=<Username>
              export packagePAT=<Personal access token>
                   
### Build the source

Execute the commands below to build from source.

1. To build the package:
    ```    
    ./gradlew clean build
    ```
2. To run the tests:
    ```
    ./gradlew clean test
    ```

3. To run a group of tests
    ```
    ./gradlew clean test -Pgroups=<test_group_names>
    ```

4. To build the without the tests:
    ```
    ./gradlew clean build -x test
    ```

5. To debug package implementation:
    ```
    ./gradlew clean build -Pdebug=<port>
    ```

6. To debug with Ballerina language:
    ```
    ./gradlew clean build -PbalJavaDebug=<port>
    ```

7. Publish the generated artifacts to the local Ballerina central repository:
    ```
    ./gradlew clean build -PpublishToLocalCentral=true
    ```

8. Publish the generated artifacts to the Ballerina central repository:
    ```
    ./gradlew clean build -PpublishToCentral=true
    ```

## Contribute to Ballerina

As an open source project, Ballerina welcomes contributions from the community. 

For more information, go to the [contribution guidelines](https://github.com/ballerina-platform/ballerina-lang/blob/master/CONTRIBUTING.md).

## Code of conduct

All contributors are encouraged to read the [Ballerina Code of Conduct](https://ballerina.io/code-of-conduct).

## Useful links

* Chat live with us via our [Slack channel](https://ballerina.io/community/slack/).
* Post all technical questions on Stack Overflow with the [#ballerina](https://stackoverflow.com/questions/tagged/ballerina) tag. 
* For more information go to the [`uuid` library](https://lib.ballerina.io/ballerina/uuid/latest).
* For example demonstrations of the usage, go to [Ballerina By Examples](https://ballerina.io/swan-lake/learn/by-example/).
