-- ModuleScript: CustomUILibrary
local CustomUI = {}

function CustomUI:CreateWindow(config)
	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = config.Name or "CustomUI"
	ScreenGui.ResetOnSpawn = false
	ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

	local MainFrame = Instance.new("Frame")
	MainFrame.Size = UDim2.new(0, 500, 0, 300)
	MainFrame.Position = UDim2.new(0.5, -250, 0.5, -150)
	MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	MainFrame.BorderSizePixel = 0
	MainFrame.Parent = ScreenGui

	local Title = Instance.new("TextLabel")
	Title.Text = config.Title or "My UI"
	Title.Size = UDim2.new(1, 0, 0, 40)
	Title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	Title.TextColor3 = Color3.new(1, 1, 1)
	Title.Font = Enum.Font.SourceSansBold
	Title.TextSize = 22
	Title.Parent = MainFrame

	local TabsHolder = Instance.new("Frame")
	TabsHolder.Position = UDim2.new(0, 0, 0, 40)
	TabsHolder.Size = UDim2.new(1, 0, 1, -40)
	TabsHolder.BackgroundTransparency = 1
	TabsHolder.Parent = MainFrame

	local Window = {}
	Window.Tabs = {}

	function Window:CreateTab(tabName)
		local Tab = {}

		local TabButton = Instance.new("TextButton")
		TabButton.Size = UDim2.new(0, 100, 0, 30)
		TabButton.Position = UDim2.new(0, #Window.Tabs * 105, 1, -35)
		TabButton.Text = tabName
		TabButton.Parent = MainFrame

		local TabFrame = Instance.new("ScrollingFrame")
		TabFrame.Size = UDim2.new(1, 0, 1, -40)
		TabFrame.Position = UDim2.new(0, 0, 0, 40)
		TabFrame.Visible = #Window.Tabs == 0
		TabFrame.BackgroundTransparency = 1
		TabFrame.CanvasSize = UDim2.new(0, 0, 0, 500)
		TabFrame.ScrollBarThickness = 6
		TabFrame.Parent = TabsHolder

		local Layout = Instance.new("UIListLayout")
		Layout.Padding = UDim.new(0, 5)
		Layout.Parent = TabFrame

		function Tab:CreateButton(config)
			local Btn = Instance.new("TextButton")
			Btn.Text = config.Text or "Button"
			Btn.Size = UDim2.new(1, -10, 0, 30)
			Btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
			Btn.TextColor3 = Color3.new(1, 1, 1)
			Btn.Font = Enum.Font.SourceSans
			Btn.TextSize = 18
			Btn.Parent = TabFrame

			Btn.MouseButton1Click:Connect(function()
				if config.Callback then
					config.Callback()
				end
			end)
		end

		function Tab:CreateToggle(config)
			local Toggle = Instance.new("TextButton")
			Toggle.Text = "[ OFF ] " .. (config.Text or "Toggle")
			Toggle.Size = UDim2.new(1, -10, 0, 30)
			Toggle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
			Toggle.TextColor3 = Color3.new(1, 1, 1)
			Toggle.Font = Enum.Font.SourceSans
			Toggle.TextSize = 18
			Toggle.Parent = TabFrame

			local state = false
			Toggle.MouseButton1Click:Connect(function()
				state = not state
				Toggle.Text = state and "[ ON ] " .. config.Text or "[ OFF ] " .. config.Text
				if config.Callback then
					config.Callback(state)
				end
			end)
		end

		table.insert(Window.Tabs, Tab)

		TabButton.MouseButton1Click:Connect(function()
			for _, tab in pairs(Window.Tabs) do
				tab.Frame.Visible = false
			end
			TabFrame.Visible = true
		end)

		Tab.Frame = TabFrame
		return Tab
	end

	return Window
end

return CustomUI
