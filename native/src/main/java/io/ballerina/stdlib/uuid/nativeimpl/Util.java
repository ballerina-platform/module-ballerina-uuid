/*
 * Copyright (c) 2020, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
 *
 * WSO2 Inc. licenses this file to you under the Apache License,
 * Version 2.0 (the "License"); you may not use this file except
 * in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

package io.ballerina.stdlib.uuid.nativeimpl;

import io.ballerina.runtime.api.creators.ValueCreator;
import io.ballerina.runtime.api.utils.StringUtils;
import io.ballerina.runtime.api.values.BArray;
import io.ballerina.runtime.api.values.BString;

import java.nio.ByteBuffer;
import java.time.Duration;
import java.time.LocalDateTime;
import java.util.Random;
import java.util.UUID;

/**
 * Utility functions relevant to uuid operations.
 *
 * @since 0.9.0
 */
public class Util {
    private static final int YEAR = 1582;
    private static final int MONTH = 10;
    private static final int DAY_OF_MONTH = 15;
    private static final int HOUR = 0;
    private static final int MINUTE = 0;
    private static final int SECOND = 0;

    public static BString generateType1UUID() {
        long most64SigBits = get64MostSignificantBitsForVersion1();
        long least64SigBits = get64LeastSignificantBitsForVersion1();

        return StringUtils.fromString(new UUID(most64SigBits, least64SigBits).toString());
    }

    private static long get64LeastSignificantBitsForVersion1() {
        Random random = new Random();
        long random63BitLong = random.nextLong() & 0x3FFFFFFFFFFFFFFFL;
        long variant3BitFlag = 0x8000000000000000L;
        return random63BitLong + variant3BitFlag;
    }

    private static long get64MostSignificantBitsForVersion1() {
        LocalDateTime start = LocalDateTime.of(YEAR, MONTH, DAY_OF_MONTH, HOUR, MINUTE, SECOND);
        Duration duration = Duration.between(start, LocalDateTime.now());
        long seconds = duration.getSeconds();
        long nanos = duration.getNano();
        long timeForUuidIn100Nanos = seconds * 10000000 + nanos * 100;
        long least12SignificantBitOfTime = (timeForUuidIn100Nanos & 0x000000000000FFFFL) >> 4;
        long version = 1 << 12;
        return (timeForUuidIn100Nanos & 0xFFFFFFFFFFFF0000L) + version + least12SignificantBitOfTime;
    }

    public static BArray getBytesFromUUID(BString uuid) {
        UUID uuid1 = UUID.fromString(uuid.toString());
        ByteBuffer bb = ByteBuffer.wrap(new byte[16]);
        bb.putLong(uuid1.getMostSignificantBits());
        bb.putLong(uuid1.getLeastSignificantBits());

        return ValueCreator.createArrayValue(bb.array());
    }

    public static BString getUUIDFromBytes(BArray bytes) {
        ByteBuffer byteBuffer = ByteBuffer.wrap(bytes.getBytes());
        long high = byteBuffer.getLong();
        long low = byteBuffer.getLong();

        return StringUtils.fromString(new UUID(high, low).toString());
    }
}
