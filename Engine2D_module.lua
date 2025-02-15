local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local Engine2D = {}

function Engine2D.new()
	local Ins = {
		Frame = nil,
		Holders = nil,
		GravityStrong = 300,
		YSpeed = -130,
		XSpeed = 6,
		MaxYSpeed = 500,
		OnGround = false,
		IsJumping = true,
		CurrentYSpeed = 0,
		Movement = {Left = false, Right = false},
		PlayerData = {
			CurrentPlatform = ""
		}
	}

	function Ins:StartEngine()
		----------------------- 좌우 움직임 ----------------------------
		UserInputService.InputBegan:Connect(function(input)
			if input.KeyCode == Enum.KeyCode.Right then
				self.Movement.Right = true
			elseif input.KeyCode == Enum.KeyCode.Left then
				self.Movement.Left = true
			end
		end)

		UserInputService.InputEnded:Connect(function(input)
			if input.KeyCode == Enum.KeyCode.Right then
				self.Movement.Right = false
			elseif input.KeyCode == Enum.KeyCode.Left then
				self.Movement.Left = false
			end
		end)

		game:GetService("RunService").Heartbeat:Connect(function()
			-- 현재 발판 가져오기
			local CurrentPlatformName = self.PlayerData.CurrentPlatform
			local PlatformPosition, PlatformWidth

			if CurrentPlatformName and CurrentPlatformName ~= "" then
				local CurrentPlatform = self.Holders:FindFirstChild(CurrentPlatformName)
				if CurrentPlatform then
					PlatformPosition = CurrentPlatform.Position
					PlatformWidth = CurrentPlatform.Size.X.Offset
				end
			end

			-- X축 이동 처리
			local PlayerX = self.Frame.Position.X.Offset
			local PlayerWidth = self.Frame.Size.X.Offset

			if self.Movement.Right then
				self.Frame.Position = UDim2.new(0, PlayerX + self.XSpeed, 0, self.Frame.Position.Y.Offset)
			end

			if self.Movement.Left then
				self.Frame.Position = UDim2.new(0, PlayerX - self.XSpeed, 0, self.Frame.Position.Y.Offset)
			end
		end)
		--------------------- 좌우 움직임 --------------------------------
		--------------------- 중력 및 발판 -------------------------------
		RunService.Heartbeat:Connect(function(deltaTime)
			if not self.OnGround then
				self.CurrentYSpeed = self.CurrentYSpeed + self.GravityStrong * deltaTime

				if self.CurrentYSpeed > self.MaxYSpeed then
					self.CurrentYSpeed = self.MaxYSpeed
				end

				local CollidedWithPlatform = false
				for _, Platform in ipairs(self.Holders:GetChildren()) do
					local PlatformTop = Platform.Position.Y.Offset
					local CharacterBottom = self.Frame.Position.Y.Offset + self.Frame.Size.Y.Offset
					local CharacterNextBottom = CharacterBottom + self.CurrentYSpeed * deltaTime

					if PlatformTop > CharacterBottom and PlatformTop < CharacterNextBottom and
						Platform.Position.X.Offset < self.Frame.Position.X.Offset + self.Frame.Size.X.Offset / 2 and
						Platform.Position.X.Offset + Platform.Size.X.Offset > self.Frame.Position.X.Offset + self.Frame.Size.X.Offset / 2 then

						self.Frame.Position = UDim2.new(
							0,
							self.Frame.Position.X.Offset,
							0,
							Platform.Position.Y.Offset - self.Frame.Size.Y.Offset
						)
						self.PlayerData.CurrentPlatform = Platform.Name

						self.OnGround = true
						self.IsJumping = false
						self.CurrentYSpeed = 0
						CollidedWithPlatform = true
						break
					end
				end

				if not CollidedWithPlatform then
					self.Frame.Position = UDim2.new(
						0,
						self.Frame.Position.X.Offset,
						0,
						self.Frame.Position.Y.Offset + self.CurrentYSpeed * deltaTime
					)
				end
			else
				if self.PlayerData.CurrentPlatform ~= nil then
					local Platform = self.Holders:FindFirstChild(self.PlayerData.CurrentPlatform)
					local PlatformTop = Platform.Position.Y.Offset
					local CharacterBottom = self.Frame.Position.Y.Offset + self.Frame.Size.Y.Offset
					local CharacterNextBottom = CharacterBottom + self.CurrentYSpeed * deltaTime

					if Platform.Position.X.Offset <= self.Frame.Position.X.Offset + self.Frame.Size.X.Offset / 2 and
						Platform.Position.X.Offset + Platform.Size.X.Offset >= self.Frame.Position.X.Offset + self.Frame.Size.X.Offset / 2 then
						self.OnGround = true
					else
						self.OnGround = false
					end
				end
			end
		end)

		UserInputService.InputBegan:Connect(function(input)
			if input.KeyCode == Enum.KeyCode.Space then
				if not self.IsJumping and self.OnGround then
					self.PlayerData.CurrentPlatform = nil
					self.IsJumping = true
					self.CurrentYSpeed = self.YSpeed
					self.OnGround = false
				end
			end
		end)
		--------------------- 중력 및 발판 -------------------------------
	end

	return Ins
end

return Engine2D
