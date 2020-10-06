
/*
 * Copyright (c) 2018-2020 The Forge Interactive Inc.
 *
 * This file is part of TheForge
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

#include <metal_stdlib>
using namespace metal;

#include "Shader_Defs.h"
#include "packing.h"
#include "vb_argument_buffers.h"

struct PsIn
{
	float4 Position [[position]];
	float2 TexCoord;
};

struct VSInput
{
	float4 Position [[attribute(0)]];
	uint TexCoord [[attribute(1)]];
};

vertex PsIn stageMain(
    VSInput input               [[stage_in]],
    constant ArgDataPerDraw& vsData     [[buffer(UPDATE_FREQ_PER_DRAW)]]
)
{
	PsIn output;
	output.Position = vsData.objectUniformBlock.mWorldViewProjMat * input.Position;
	output.TexCoord = unpack2Floats(input.TexCoord);
	return output;
}
