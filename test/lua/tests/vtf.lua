local flags = {
	-- flags from the *.txt config file
	pointsample = 0x00000001,
	trilinear = 0x00000002,
	clamps = 0x00000004,
	clampt = 0x00000008,
	anisotropic = 0x00000010,
	hint_dxt5 = 0x00000020,
	pwl_corrected = 0x00000040,
	normal = 0x00000080,
	nomip = 0x00000100,
	nolod = 0x00000200,
	all_mips = 0x00000400,
	procedural = 0x00000800,

	-- these are automatically generated by vtex from the texture data.
	onebitalpha = 0x00001000,
	eightbitalpha = 0x00002000,

	-- newer flags from the *.txt config file
	envmap = 0x00004000,
	rendertarget = 0x00008000,
	depthrendertarget = 0x00010000,
	nodebugoverride = 0x00020000,
	singlecopy	= 0x00040000,
	pre_srgb = 0x00080000,
 
	unused_00100000 = 0x00100000,
	unused_00200000 = 0x00200000,
	unused_00400000 = 0x00400000,

	nodepthbuffer = 0x00800000,

	unused_01000000 = 0x01000000,

	clampu = 0x02000000,
	vertextexture = 0x04000000,
	ssbump = 0x08000000,			

	unused_10000000 = 0x10000000,

	border = 0x20000000,

	unused_40000000 = 0x40000000,
	unused_80000000 = 0x80000000,
}

local formats = {
	[-1] = "none",
	[0] = "RGBA8888",
	[1] = "ABGR8888",
	[2] = "RGB888",
	[3] = "BGR888",
	[4] = "RGB565",
	[5] = "I8",
	[6] = "IA88",
	[7] = "P8",
	[8] = "A8",
	[9] = "RGB888_BLUESCREEN",
	[10] = "BGR888_BLUESCREEN",
	[11] = "ARGB8888",
	[12] = "BGRA8888",
	[13] = "DXT1",
	[14] = "DXT3",
	[15] = "DXT5",
	[16] = "BGRX8888",
	[17] = "BGR565",
	[18] = "BGRX5551",
	[19] = "BGRA4444",
	[20] = "DXT1_ONEBITALPHA",
	[21] = "BGRA5551",
	[22] = "UV88",
	[23] = "UVWQ8888",
	[24] = "RGBA16161616F",
	[25] = "RGBA16161616",
	[2] = "UVLX88886",
}

local format_info = {
	A8 = {
		name = "A8",
		red_bits = 0, 
		green_bits = 0, 
		blue_bits = 0, 
		alpha_bits = 8, 
		total_bits = 8,
		total_bytes = 8/8, 
		compressed = false, 
		supported = true
	},
	ABGR8888 = { -- uncompressed texture with alpha
		name = "ABGR8888",
		red_bits = 8, 
		green_bits = 8, 
		blue_bits = 8, 
		alpha_bits = 8, 
		total_bits = 32,
		total_bytes = 32/8, 
		compressed = false, 
		supported = true
	}, 
	ARGB8888 = {
		name = "ARGB8888",
		red_bits = 8, 
		green_bits = 8, 
		blue_bits = 8, 
		alpha_bits = 8, 
		total_bits = 32,
		total_bytes = 32/8, 
		compressed = false, 
		supported = true
	},
	BGR565 = { -- uncompressed texture, limited color depth
		name = "BGR565",
		red_bits = 5, 
		green_bits = 6, 
		blue_bits = 5, 
		alpha_bits = 0, 
		total_bits = 16,
		total_bytes = 16/8, 
		compressed = false, 
		supported = true
	}, 
	BGR888 = { -- uncompressed texture
		name = "BGR888",
		red_bits = 8, 
		green_bits = 8, 
		blue_bits = 8, 
		alpha_bits = 0, 
		total_bits = 24,
		total_bytes = 24/8, 
		compressed = false, 
		supported = true
	}, 
	BGR888_BLUESCREEN = {
		name = "BGR888_BLUESCREEN",
		red_bits = 8, 
		green_bits = 8, 
		blue_bits = 8, 
		alpha_bits = 0, 
		total_bits = 24,
		total_bytes = 24/8, 
		compressed = false, 
		supported = true
	},
	BGRA4444 = { -- uncompressed texture with alpha, half color depth
		name = "BGRA4444",
		red_bits = 4, 
		green_bits = 4, 
		blue_bits = 4, 
		alpha_bits = 4, 
		total_bits = 16,
		total_bytes = 16/8, 
		compressed = false, 
		supported = true
	}, 
	BGRA5551 = {
		name = "BGRA5551",
		red_bits = 5, 
		green_bits = 5, 
		blue_bits = 5, 
		alpha_bits = 1, 
		total_bits = 16,
		total_bytes = 16/8, 
		compressed = false, 
		supported = true
	},
	BGRA8888 = { -- also used for compressed hdr
		name = "BGRA8888",
		red_bits = 8, 
		green_bits = 8, 
		blue_bits = 8, 
		alpha_bits = 8, 
		total_bits = 32,
		total_bytes = 32/8, 
		compressed = either, 
		supported = true
	}, 
	BGRX5551 = {
		name = "BGRX5551",
		red_bits = 5, 
		green_bits = 5, 
		blue_bits = 5, 
		alpha_bits = 1, 
		total_bits = 16,
		total_bytes = 16/8, 
		compressed = false, 
		supported = true
	},
	BGRX8888 = {
		name = "BGRX8888",
		red_bits = 8, 
		green_bits = 8, 
		blue_bits = 8, 
		alpha_bits = 8, 
		total_bits = 32,
		total_bytes = 32/8, 
		compressed = false, 
		supported = true
	},
	DXT1 = { -- standard compression, no alpha
		name = "DXT1",
		red_bits = 0, 
		green_bits = 0, 
		blue_bits = 0, 
		alpha_bits = 0, 
		total_bits = 4,
		total_bytes = 4/8, 
		compressed = true, 
		supported = true
	}, 
	DXT1_ONEBITALPHA = { -- standard compression, one bit alpha
		name = "DXT1_ONEBITALPHA",
		red_bits = 0, 
		green_bits = 0, 
		blue_bits = 0, 
		alpha_bits = 1, 
		total_bits = 4,
		total_bytes = 4/8, 
		compressed = true, 
		supported = true
	}, 
	DXT3 = {  -- uninterpolated alpha
		name = "DXT3",
		red_bits = 0, 
		green_bits = 0, 
		blue_bits = 0, 
		alpha_bits = 4, 
		total_bits = 8,
		total_bytes = 8/8, 
		compressed = true, 
		supported = true
	},
	DXT5 = { -- interpolated alpha (recommended)
		name = "DXT5",
		red_bits = 0, 
		green_bits = 0, 
		blue_bits = 0, 
		alpha_bits = 4, 
		total_bits = 8,
		total_bytes = 8/8, 
		compressed = true, 
		supported = true
	}, 
	I8 = { -- luminance (grayscale)
		name = "I8",
		red_bits = 0, 
		green_bits = 0, 
		blue_bits = 0, 
		alpha_bits = 0, 
		total_bits = 8,
		total_bytes = 8/8, 
		compressed = false, 
		supported = true
	}, 
	IA88 = { -- luminance (grayscale)
		name = "IA88",
		red_bits = 0, 
		green_bits = 0, 
		blue_bits = 0, 
		alpha_bits = 8, 
		total_bits = 16,
		total_bytes = 16/8, 
		compressed = false, 
		supported = true
	},  
	P8 = { -- paletted
		name = "P8",
		red_bits = 0, 
		green_bits = 0, 
		blue_bits = 0, 
		alpha_bits = 0, 
		total_bits = 8,
		total_bytes = 8/8, 
		compressed = false, 
		supported = false
	}, 
	RGB565 = {
		name = "RGB565",
		red_bits = 5, 
		green_bits = 6, 
		blue_bits = 5, 
		alpha_bits = 0, 
		total_bits = 16,
		total_bytes = 16/8, 
		compressed = false, 
		supported = true
	},
	RGB888 = {
		name = "RGB888",
		red_bits = 8, 
		green_bits = 8, 
		blue_bits = 8, 
		alpha_bits = 0, 
		total_bits = 24,
		total_bytes = 24/8, 
		compressed = false, 
		supported = true
	},
	RGB888_BLUESCREEN = {
		name = "RGB888_BLUESCREEN",
		red_bits = 8, 
		green_bits = 8, 
		blue_bits = 8, 
		alpha_bits = 0, 
		total_bits = 24,
		total_bytes = 24/8, 
		compressed = false, 
		supported = true
	},
	RGBA16161616 = { -- integer hdr format
		name = "RGBA16161616",
		red_bits = 16, 
		green_bits = 16, 
		blue_bits = 6, 
		alpha_bits = 16, 
		total_bits = 64,
		total_bytes = 64/8, 
		compressed = false, 
		supported = true
	}, 
	RGBA16161616F = { -- floating point hdr format
		name = "RGBA16161616F",
		red_bits = 16, 
		green_bits = 16, 
		blue_bits = 6, 
		alpha_bits = 16, 
		total_bits = 64,
		total_bytes = 64/8, 
		compressed = false, 
		supported = true
	}, 
	RGBA8888 = {
		name = "RGBA8888",
		red_bits = 8, 
		green_bits = 8, 
		blue_bits = 8, 
		alpha_bits = 8, 
		total_bits = 32,
		total_bytes = 32/8, 
		compressed = false, 
		supported = true
	},
	UV88 = { -- uncompressed du/dv format
		name = "UV88",
		red_bits = 0, 
		green_bits = 0, 
		blue_bits = 0, 
		alpha_bits = 0, 
		total_bits = 16,
		total_bytes = 16/8, 
		compressed = false, 
		supported = true
	}, 
	UVLX8888 = {
		name = "UVLX8888",
		red_bits = 0, 
		green_bits = 0, 
		blue_bits = 0, 
		alpha_bits = 0, 
		total_bits = 32,
		total_bytes = 32/8, 
		compressed = false, 
		supported = true
	},
	UVWQ8888 = {
		name = "UVWQ8888",
		red_bits = 0, 
		green_bits = 0, 
		blue_bits = 0, 
		alpha_bits = 0, 
		total_bits = 32,
		total_bytes = 32/8, 
		compressed = false, 
		supported = true
	},
}

local resource_types = {
	Unknown = 0x00000000,
	Lowres = 0x00000001,
	Hires = 0x00000030,
	CRC = 0x02435243,
}

local vtf_header_structure = [[
char			signature[4];		// File signature ("VTF\0"). (or as little-endian integer, 0x00465456)
unsigned int	version[2];			// version[0].version[1] (currently 7.2).
unsigned int	headerSize;			// Size of the header struct (16 byte aligned; currently 80 bytes).
unsigned short	width;				// Width of the largest mipmap in pixels. Must be a power of 2.
unsigned short	height;				// Height of the largest mipmap in pixels. Must be a power of 2.
unsigned int	flags;				// VTF flags.
unsigned short	frames;				// Number of frames, if animated (1 for no animation).
unsigned short	firstFrame;			// First frame in animation (0 based).
padding byte	padding0[4];		// reflectivity padding (16 byte alignment).
vec3			reflectivity;	// reflectivity vector.
padding byte	padding1[4];		// reflectivity padding (8 byte packing).
float			bumpmapScale;		// Bumpmap scale.
unsigned int	highResImageFormat;	// High resolution image format.
unsigned char	mipmapCount;		// Number of mipmaps.
unsigned int	lowResImageFormat;	// Low resolution image format (always DXT1).
unsigned char	lowResImageWidth;	// Low resolution image width.
unsigned char	lowResImageHeight;	// Low resolution image height.
]]

local buffer = vfs.Open("materials/nature/grassfloor002a.vtf")
local vtf = buffer:ReadStructure(vtf_header_structure)

local version = vtf.version[1] * 10 + vtf.version[2]

-- Depth of the largest mipmap in pixels.
-- Must be a power of 2. Can be 0 or 1 for a 2D texture (v7.2 only).
if version >= 72 then
	vtf.depth = buffer:ReadShort()
else	
	vtf.depth = 1
end

-- nicer version key
vtf.version = vtf.version[1] .. "." .. vtf.version[2]

-- translate the format enum
vtf.highResImageFormat = format_info[formats[vtf.highResImageFormat]]
vtf.lowResImageFormat = format_info[formats[vtf.lowResImageFormat]]

do -- flags to table of strings
	local found = {}

	for k, v in pairs(flags) do
		if bit.band(vtf.flags, v) > 0 then
			found[k] = true
		end
	end

	vtf.flags = found
end

if vtf.flags.envmap then
	if vtf.firstFrame ~= 0 and version < 75  then
		vtf.faces = 7
	else
		vtf.faces = 6
	end
else
	vtf.faces = 1
end

local function insert_textures(vtf, offset)
	buffer:PushPosition(offset)

	for mm = 0, vtf.mipmapCount - 1 do
		local w = bit.rshift(vtf.width, vtf.mipmapCount - mm - 1)
		local h = bit.rshift(vtf.height, vtf.mipmapCount - mm - 1)
		
		for frame = 0, vtf.frames-1 do
			for face = 0, vtf.faces-1 do
				for slice = 0, vtf.depth-1 do
					local size = w * h * vtf.highResImageFormat.total_bytes
									
					if slice ~= 0 then 
						size = size * bit.rshift(slice, i)
					end
					
					if size > 0 then
						local image = ffi.cast("uint8_t *", buffer:ReadString(size))
						
						table.insert(vtf.textures, {
							mip_map_level = mm,
							slice = slice,
							face = face,
							frame = frame,
							width = w,
							height = h,
							size = size,
							buffer = image,
							format = vtf.highResImageFormat,
						})
					end
				end
			end
		end
	end
	
	buffer:PopPosition()
end

local function insert_lowres_texture(vtf, offset)
	local size = vtf.lowResImageWidth * vtf.lowResImageHeight * (vtf.lowResImageFormat.total_bits / 8)
				
	buffer:PushPosition(offset)
	local image = ffi.cast("uint8_t *", buffer:ReadString(size))
	buffer:PopPosition()
	
	vtf.lowresTextureData = {
		width = vtf.lowResImageWidth,
		height = vtf.lowResImageHeight,
		size = size,
		buffer = image,
		format = vtf.lowResImageFormat,
	}
end

if version >= 73 then
	buffer:ReadString(3)
	vtf.resourceCount = buffer:ReadLong()
	buffer:ReadString(8)
			
	for i = 1, vtf.resourceCount do
		local type = buffer:ReadLong()
		local offset = buffer:ReadLong()
		
		if type == resource_types.Lowres then
			insert_lowres_texture(vtf, offset)
		elseif type == resource_types.Hires then		
			vtf.textures = {}			
			insert_textures(vtf, offset)
		elseif type == resource_types.CRC then
			vtf.crc = buffer:ReadLong()
		elseif type == resource_types.Unknown then
		
		end
	end
else
	if vtf.lowResImageFormat.name ~= "none" then
		insert_lowres_texture(vtf, vtf.headerSize)
	end
	
	buffer:SetPosition(vtf.headerSize)
	
	vtf.textures = {}
	insert_textures(vtf, buffer:GetPosition())
end

-- remove useless values
vtf.resourceCount = nil
vtf.width = nil
vtf.height = nil
vtf.lowResImageWidth = nil
vtf.lowResImageHeight = nil
vtf.highResImageFormat = nil
vtf.signature = nil
vtf.lowResImageFormat = nil

--table.print(vtf)

buffer:SetPosition(vtf.headerSize)
  
for k,v in pairs(vtf.textures) do
	local tex = render.CreateTexture("2d")
	tex:SetSize(Vec2(v.width, v.height))
	tex:SetInternalFormat("compressed_rgb_s3tc_dxt1_ext")
	tex:Upload({
		image_size = v.size,
		buffer = v.buffer,
	})
end  
 
event.AddListener("Draw2D", "vtf", function()
	local i = math.clamp(math.ceil(os.clock()*10%#vtf.textures),1, #vtf.textures)
	local tex = vtf.textures[i].tex
	
	surface.SetTexture(tex)
	surface.SetColor(1,1,1,1)
	surface.DrawRect(0,0,512,512)
	surface.SetTextPosition(60, 60)
	surface.DrawText(tostring(i))
end)