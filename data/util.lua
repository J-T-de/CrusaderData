function printAddress(address)
    -- prints address in format 0xAB12CD34
    print(string.format("0x%8.8X", address))
end
  
function printHex(number)
    -- prints number in hex AB11CD22
    print(string.format("0x%X", number))
end


-- Read a single byte
function ReadInt8(address)
	return readBytes(address, 1, false)
end

-- Write a single byte
function WriteInt8(address, value)
	return writeBytes(address, value)
end


-- Gets the function for reading from memory the specified datatype
-- valid values for dtype are {1, int8, 2, int16, 4, int32} and StructSpec
function GetReader(dtype)
	if dtype == 1 or dtype=="int8" then
		return ReadInt8
	elseif dtype == 2 or dtype=="int16" then
		return readSmallInteger
	elseif dtype == 4 or dtype=="int32" then
		return readInteger
	elseif type(dtype) == "table" then
		-- a custom struct: This is lazy reading!
		if getmetatable(dtype) == StructSpec then
			return function(address) return dtype:create(address) end
		end
	end
	error("Unsupported dtype " .. dtype)
end


-- Gets the size of a data type
function GetSize(dtype)
	if dtype == 1 or dtype=="int8" then
		return 1
	elseif dtype == 2 or dtype=="int16" then
		return 2
	elseif dtype == 4 or dtype=="int32" then
		return 4
	elseif type(dtype) == "table" then
		return dtype.size
	end
	error("Unsupported dtype " .. dtype)
end


-- Gets the function for writing from memory an integer of the specified size.
function GetWriter(dtype)
	if dtype == 1 then
		return WriteInt8
	elseif dtype == 2 then
		return writeSmallInteger
	elseif dtype == 4 then
		return writeInteger
	elseif type(dtype) == "table" then
		-- a custom struct writing not yet supported
		if getmetatable(dtype) == StructSpec then
			return function(address) return error("Custom struct writing not supported yet!") end
		end
	else
		error("Unsupported write size " .. dtype)
	end
end



function MakeStridedArray(base_address, stride, size, name)
	local array = {}
	array.base_address = base_address
	array.base = getAddress(base_address)
	array.stride = stride
	array.size = size
	array.name = name
	local read_fn = GetReader(size)
	function array:read(index) 
		return read_fn(self.base + self.stride * index)
	end
	local write_fn = GetWriter(size)
	function array:write(index, value) 
		return write_fn(self.base + self.stride * index, value)
	end
	return array
end

StructSpec = {}
StructSpec.__index = StructSpec

function StructSpec:declare(name, size)
   local spec = {}                 	-- our new object
   setmetatable(spec, StructSpec)  	-- make StructSpec handle lookup
   spec.name = name                	-- initialize our object
   spec.size = size				  	-- Size of this struct	
   spec.fields = {}					-- Table containing the known fields of this struct
   
   spec.mt = {
	__index = function(t, k) 
		if t.spec.fields[k] ~= nil then
			local field = t.spec.fields[k]
			return field.read(t.address + field.offset)
		end
		error("Unknown field " .. k)
	end,
	__newindex = function(t, k, v)
		if t.spec.fields[k] ~= nil then
			local field = t.spec.fields[k]
			return field.write(t.address + field.offset, v)
		end
		error("Unknown field " .. k)
	end
   }						-- Metatable to be used for instances of this struct
   return spec
end

function StructSpec:declare_array(name, dtype, entries)
	local spec = StructSpec:declare(name, GetSize(dtype) * #entries)
	spec:add_consecutive(0, dtype, entries)
	return spec
end

function StructSpec:add(name, offset, dtype)
	local size = GetSize(dtype)
    self.fields[name] = {offset=offset, size=size, dtype=dtype, read=GetReader(dtype), write=GetWriter(dtype)}
    if offset + size > self.size then
		error("Invalid offset " .. offset .. " (size: " .. size .. ")")
    end
end

function StructSpec:add_consecutive(offset, dtype, names)
	local size = GetSize(dtype)
	for _, name in pairs(names) do 
		self:add(name, offset, dtype)
		offset = offset + size
	end
end

function StructSpec:create(address)
	local object = {}
	object.address = getAddress(address)
	object.spec = self
	setmetatable(object, self.mt)
	return object
end

function StructSpec:add_to_addresslist(base_address, name)
	if name == nil then
		name = self.name 
	end
	local addressList = getAddressList()
	local root = addressList.createMemoryRecord()
	root.setAddress(base_address)
	root.DontSave = true
	root.Description = name
	root.Options = "[moAllowManualCollapseAndExpand,moManualExpandCollapse]"
	root.Collapsed = true
	
	local ordered = {}
    for k in pairs(self.fields) do ordered[#ordered+1] = k end
	table.sort(ordered, function(a,b) return self.fields[a].offset < self.fields[b].offset end)
	
	for _, key in pairs(ordered) do
		local entry = nil
		if type(self.fields[key].dtype) == "table" then
			-- recurse. Can use a fake address, it will be set correctly below
			entry = self.fields[key].dtype:add_to_addresslist("0", key)
		else
			entry = addressList.createMemoryRecord()
		end
		entry.setAddress("+" .. string.format("%x", self.fields[key].offset))
		entry.appendToEntry(root)
		entry.Description = key
		entry.DontSave = true
	end
	return root
end
