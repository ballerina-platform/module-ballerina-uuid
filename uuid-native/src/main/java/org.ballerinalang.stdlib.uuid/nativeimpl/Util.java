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

package org.ballerinalang.stdlib.uuid.nativeimpl;

import io.ballerina.runtime.api.creators.ErrorCreator;
import io.ballerina.runtime.api.values.BArray;
import io.ballerina.runtime.api.creators.ValueCreator;
import io.ballerina.runtime.api.values.BString;
import io.ballerina.runtime.api.utils.StringUtils;

import java.nio.ByteBuffer;
import java.time.Duration;
import java.time.LocalDateTime;
import java.util.Random;
import java.util.UUID;

public class Util {

    public static Object fromString(BString uuid) {
        try {
            return UUID.fromString(uuid.toString());
        } catch (Exception e) {
            // Todo: update the error message
            throw ErrorCreator.createError(StringUtils.fromString("failed to generate uuid"));
        }
    }

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
        LocalDateTime start = LocalDateTime.of(1582, 10, 15, 0, 0, 0);
        Duration duration = Duration.between(start, LocalDateTime.now());
        long seconds = duration.getSeconds();
        long nanos = duration.getNano();
        long timeForUuidIn100Nanos = seconds * 10000000 + nanos * 100;
        long least12SignificatBitOfTime = (timeForUuidIn100Nanos & 0x000000000000FFFFL) >> 4;
        long version = 1 << 12;
        return (timeForUuidIn100Nanos & 0xFFFFFFFFFFFF0000L) + version + least12SignificatBitOfTime;
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
        Long high = byteBuffer.getLong();
        Long low = byteBuffer.getLong();

        return StringUtils.fromString(new UUID(high, low).toString());
    }
}
