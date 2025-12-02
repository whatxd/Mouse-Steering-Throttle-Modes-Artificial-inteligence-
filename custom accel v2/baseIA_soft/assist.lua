-- Mouse Steering + throttle & brake modes + FULL smoothing

local steeringFinal = 0
local gasFinal = 0
local brakeFinal = 0

-- Smooth factor (entre más alto, más rápido)
local smoothSpeed = 5

-- Modes
local throttleModes = {0.40, 0.70, 1.00}
local throttleIndex = 1
local throttleUpLock = false
local throttleDownLock = false

local brakeModes = {0.20, 0.40, 0.70, 1.00}
local brakeIndex = 1
local brakeUpLock = false
local brakeDownLock = false


----------------------------------------------------------------
-- UPDATE
----------------------------------------------------------------
function script.update(dt, deltaX, deltaY, useMouseButtons)

  ----------------------------------------------------------------
  -- ACELERADOR: R (sube) / F (baja)
  ----------------------------------------------------------------
  local keyR = ac.isKeyDown(ui.KeyIndex.F)
  if keyR and not throttleUpLock then
    throttleIndex = throttleIndex + 1
    if throttleIndex > #throttleModes then throttleIndex = #throttleModes end
  end
  throttleUpLock = keyR

  local keyF = ac.isKeyDown(ui.KeyIndex.F)
  if keyF and not throttleDownLock then
    throttleIndex = throttleIndex - 1
    if throttleIndex < 1 then throttleIndex = 1 end
  end
  throttleDownLock = keyF


  ----------------------------------------------------------------
  -- FRENO: Shift (sube) / Ctrl (baja)
  ----------------------------------------------------------------
  local keyShift = ac.isKeyDown(ui.KeyIndex.LeftShift)
  if keyShift and not brakeUpLock then
    brakeIndex = brakeIndex + 1
    if brakeIndex > #brakeModes then brakeIndex = #brakeModes end
  end
  brakeUpLock = keyShift

  local keyCtrl = ac.isKeyDown(ui.KeyIndex.LeftControl)
  if keyCtrl and not brakeDownLock then
    brakeIndex = brakeIndex - 1
    if brakeIndex < 1 then brakeIndex = 1 end
  end
  brakeDownLock = keyCtrl


  ----------------------------------------------------------------
  -- TARGET VALUES for smoothing
  ----------------------------------------------------------------
  local targetGas = 0
  local targetBrake = 0

  if useMouseButtons and ac.isKeyDown(ui.KeyIndex.LeftButton) then
    targetGas = throttleModes[throttleIndex]
  end

  if useMouseButtons and ac.isKeyDown(ui.KeyIndex.RightButton) then
    targetBrake = brakeModes[brakeIndex]
  end


  ----------------------------------------------------------------
  -- APPLY SMOOTHING (lerp)
  ----------------------------------------------------------------
  gasFinal = gasFinal + (targetGas - gasFinal) * dt * smoothSpeed
  brakeFinal = brakeFinal + (targetBrake - brakeFinal) * dt * smoothSpeed


  ----------------------------------------------------------------
  -- STEERING
  ----------------------------------------------------------------
  steeringFinal = steeringFinal + deltaX * 0.40
  steeringFinal = math.clamp(steeringFinal, -1, 1)


  ----------------------------------------------------------------
  -- SEND TO GAME
  ----------------------------------------------------------------
  local state = ac.getJoypadState()
  state.steer = steeringFinal
  state.gas = gasFinal
  state.brake = brakeFinal
end
