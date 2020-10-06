/*
 * Copyright (c) 2018-2020 The Forge Interactive Inc.
 * 
 * This file is part of The-Forge
 * (see https://github.com/ConfettiFX/The-Forge).
 * 
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 * 
 *   http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
*/

// USERMACRO: SAMPLE_COUNT [1,2,4]

struct PsIn
{
    float4 position : SV_Position;
};

Texture2DMS<float4, SAMPLE_COUNT>  msaaSource;

float4 main(PsIn In) : SV_Target
{
    float4 value = 0;

    uint2 texCoord = uint2(In.position.xy);
    for(int i = 0; i < SAMPLE_COUNT; ++i)
        value += msaaSource.Load(texCoord, i);
    value /= SAMPLE_COUNT;

    return value;
}
