-- TOGGLE
getgenv().NPC_HIGHLIGHT = not getgenv().NPC_HIGHLIGHT
if not getgenv().NPC_HIGHLIGHT then
	for _,v in pairs(workspace:GetDescendants()) do
		if v.Name == "ESP_HIGHLIGHT" then
			v:Destroy()
		end
	end
	return
end

repeat task.wait() until game:IsLoaded()

local Enemies = workspace:WaitForChild("Enemies")

local function getColor(name)
	name = string.lower(name)

	if string.find(name, "buffemployee") then
		return Color3.fromRGB(255,140,0)
	elseif string.find(name, "employee") then
		return Color3.fromRGB(255,0,0)
	elseif string.find(name, "manager") then
		return Color3.fromRGB(0,0,0)
	elseif string.find(name, "ceo") then
		return Color3.fromRGB(0,0,0)
	elseif string.find(name, "roach") then
		return Color3.fromRGB(139,69,19)
	else
		return Color3.fromRGB(255,0,0)
	end
end

local function create(npc)
	if not getgenv().NPC_HIGHLIGHT then return end
	if npc:FindFirstChild("ESP_HIGHLIGHT") then return end

	local h = Instance.new("Highlight")
	h.Name = "ESP_HIGHLIGHT"
	h.FillColor = getColor(npc.Name)
	h.OutlineColor = h.FillColor
	h.FillTransparency = 0.5
	h.OutlineTransparency = 0
	h.Adornee = npc
	h.Parent = npc
end

for _,v in ipairs(Enemies:GetChildren()) do
	create(v)
end

Enemies.ChildAdded:Connect(function(v)
	task.wait(0.2)
	create(v)
end)
