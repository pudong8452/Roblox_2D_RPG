# Roblox_2D_RPG
Roblox 2D Engine Create [**Movements**, **Gravity**, **Collision**]

로블록스에서 2D RPG 게임 구현을 위한 학습용 프로젝트입니다. \n

**Engine2D**는 2D 게임 개발을 위한 물리 엔진으로, 주로 좌우 이동, 중력, 점프 및 발판 충돌을 처리하는 시스템입니다. 이 엔진은 Roblox Studio에서 2D 플랫폼 게임을 구현하는 데 사용할 수 있습니다.

## Features

- **좌우 이동**: 오른쪽과 왼쪽 화살표 키를 사용하여 캐릭터를 좌우로 이동시킬 수 있습니다.
- **중력**: 플레이어가 공중에 있을 때 중력 효과를 적용하여 자연스러운 하강을 구현합니다.
- **점프**: 스페이스바를 눌러 점프를 할 수 있습니다. 발판 위에서만 점프가 가능하며, 점프 중에는 중력이 적용되지 않습니다.
- **발판**: 여러 개의 발판을 생성하여, 플레이어가 발판 위에 올라가거나 떨어질 수 있도록 구현합니다.
- **플랫폼 충돌 처리**: 발판과 플레이어의 충돌을 감지하고, 플레이어가 발판 위에 있을 때만 지면에 서 있는 상태로 유지됩니다.

## Installation

이 코드는 Roblox Studio에서 사용되며, `ModuleScript`로 구현되어 있습니다. 프로젝트에 추가하려면 다음 단계를 따르세요.

1. **Engine2D 모듈을 추가**:
   - `Engine2D` 모듈을 `StarterPlayer > StarterPlayerScripts` 폴더에 추가합니다.

2. **스크립트 예시**:
   - 다음 코드를 사용하여 엔진을 초기화하고 실행할 수 있습니다.

   ```lua
    local Engine2D = require(game.StarterPlayer.StarterPlayerScripts.Engine2D)

    -- TEST Instances
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = game.Players.LocalPlayer.PlayerGui

    local Frame = Instance.new("Frame")
    Frame.Position = UDim2.new(0, 1, 0, 1)
    Frame.Size = UDim2.new(0, 100, 0, 100)
    Frame.Parent = ScreenGui

    local Folder = Instance.new("Folder")
    Folder.Parent = ScreenGui

    for i = 1, 30 do
        local platform = Instance.new("Frame")
        platform.Name = "Frame" .. i
        platform.Parent = Folder
        platform.Size = UDim2.new(0, 70, 0, 1)
        platform.Position = UDim2.new(0, math.random(0, 900), 0, math.random(300, 400))
    end

    -- TEST CODE
    local engineInstance = Engine2D.new()
    engineInstance.Frame = Frame
    engineInstance.Holders = Folder

    --[[
    engineInstance.GravityStrong = 300
    engineInstance.YSpeed = -130
    engineInstance.MaxYSpeed = 500
    engineInstance.CurrentYSpeed = 0
    engineInstance.XSpeed = 6
    engineInstance.OnGround = false
    engineInstance.IsJumping = true
    engineInstance.Movement = {Left = false, Right = false}
    ]]--


   engineInstance:StartEngine()

## Engine2D 시스템 설명

**Engine2D 클래스**는 2D 플랫폼 게임에서의 기본적인 물리 시스템을 관리합니다. 주요 설정과 메서드는 다음과 같습니다:

- **GravityStrong**: 중력의 강도를 설정합니다. 기본 값은 300입니다.
- **YSpeed**: 플레이어의 Y축 이동 속도를 설정합니다. 음수 값은 위로 점프, 양수 값은 하강을 의미합니다.
- **MaxYSpeed**: 플레이어의 최대 Y축 속도를 설정합니다. 기본 값은 500입니다.
- **CurrentYSpeed**: 현재 플레이어의 Y축 속도입니다.
- **XSpeed**: X축 이동 속도입니다.
- **OnGround**: 플레이어가 지면에 있는지 확인합니다.
- **IsJumping**: 플레이어가 점프 중인지 여부를 나타냅니다.
- **Movement**: 좌우 이동 상태를 나타냅니다. `{Left = false, Right = false}` 형태로 설정됩니다.

### 예시 설명
위의 예시 코드에서는 엔진을 초기화한 후, `Frame`과 `Folder` 객체를 생성하여 테스트를 진행할 수 있습니다. 주석 처리된 변수들은 엔진의 물리적 특성을 조정하는 데 사용됩니다. 이 값들을 변경하여 게임의 물리 엔진 동작을 실험할 수 있습니다.

## Troubleshooting

- **플랫폼 충돌이 감지되지 않는 경우**: 발판의 크기와 위치를 확인하세요. 또한 `Engine2D` 클래스의 충돌 감지 메서드가 제대로 호출되고 있는지 확인합니다.
- **플레이어가 점프하지 않음**: `YSpeed`와 `GravityStrong` 값이 적절한지 확인하고, 플레이어가 발판 위에 있는지 확인하세요.

## 기능 확장 안내

- **이동하는 장애물 추가**: 플랫폼에 장애물이나 이동하는 물체를 추가하려면 `Engine2D`의 충돌 감지 시스템을 확장하거나 새로운 물리 규칙을 추가할 수 있습니다.
- **새로운 게임 모드**: 추가적인 게임 모드를 구현하려면 `Engine2D` 시스템을 확장하여 다양한 게임 룰을 추가할 수 있습니다.