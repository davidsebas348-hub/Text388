repeat task.wait() until game:IsLoaded()

local Enemies = workspace:WaitForChild("Enemies")

-- TOGGLE GLOBAL
if _G.ESP_NPC_ON == nil then
    _G.ESP_NPC_ON = false
end

_G.ESP_NPC_ON = not _G.ESP_NPC_ON

-- conexiones
if not _G.ESP_NPC_CONNS then
    _G.ESP_NPC_CONNS = {}
end

--------------------------------------------------
-- COLORES
--------------------------------------------------

local function getColor(name)
	name = string.lower(name)

	if string.find(name, "buffemployee") then
		return Color3.fromRGB(255,140,0)
	elseif string.find(name, "employee") then
		return Color3.fromRGB(255,0,0)
	elseif string.find(name, "manager") then
		return Color3.fromRGB(0,0,0)
	elseif string.find(name, "roach") then
		return Color3.fromRGB(139,69,19)
	else
		return Color3.fromRGB(255,0,0)
	end
end

--------------------------------------------------
-- CREAR ESP
--------------------------------------------------

local function create(NPC)
	if not _G.ESP_NPC_ON then return end
	if not NPC or not NPC:IsA("Model") then return end

	if NPC:FindFirstChild("ESP_HIGHLIGHT") then return end
	
	local h = Instance.new("Highlight")
	h.Name = "ESP_HIGHLIGHT"
	h.FillColor = getColor(NPC.Name)
	h.OutlineColor = h.FillColor
	h.FillTransparency = 0.5
	h.OutlineTransparency = 0
	h.Adornee = NPC
	h.Parent = NPC -- 🔥 ahora va dentro del NPC
end

--------------------------------------------------
-- ACTIVAR
--------------------------------------------------

if _G.ESP_NPC_ON then

	print("ESP NPC ACTIVADO")

	-- existentes
	for _,v in ipairs(Enemies:GetChildren()) do
		create(v)
	end

	-- nuevos
	table.insert(_G.ESP_NPC_CONNS,
		Enemies.ChildAdded:Connect(function(v)
			task.wait(0.2)
			create(v)
		end)
	)

--------------------------------------------------
-- DESACTIVAR
--------------------------------------------------

else

	print("ESP NPC DESACTIVADO")

	-- desconectar todo
	for _,c in pairs(_G.ESP_NPC_CONNS) do
		pcall(function()
			c:Disconnect()
		end)
	end

	_G.ESP_NPC_CONNS = {}

	-- borrar highlights
	for _,v in ipairs(Enemies:GetChildren()) do
		local h = v:FindFirstChild("ESP_HIGHLIGHT")
		if h then
			h:Destroy()
		end
	end

end
