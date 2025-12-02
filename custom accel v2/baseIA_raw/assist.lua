-- Mouse Steering + throttle & brake modes (simple & stable)

local steeringFinal = 0
local gasFinal = 0
local brakeFinal = 0

-- Throttle modes (ACELERADOR)
local throttleModes = {0.40, 0.70, 1.00}
local throttleIndex = 1
local throttleUpLock = false
local throttleDownLock = false

-- Brake modes (FRENO)
local brakeModes = {0.20, 0.40, 0.70, 1.00}
local brakeIndex = 1
local shiftLock = false
local ctrlLock = false

----------------------------------------------------------------
-- UPDATE
----------------------------------------------------------------
function script.update(dt, deltaX, deltaY, useMouseButtons)

  --------------------------------------------------------------
  -- 1. R → SUBIR acelerador
  --------------------------------------------------------------
  local keyR = ac.isKeyDown(ui.KeyIndex.R)
  if keyR and not throttleUpLock then
    throttleIndex = throttleIndex + 1
    if throttleIndex > #throttleModes then
      throttleIndex = #throttleModes
    end
  end
  throttleUpLock = keyR


  --------------------------------------------------------------
  -- 2. F → BAJAR acelerador
  --------------------------------------------------------------
  local keyF = ac.isKeyDown(ui.KeyIndex.F)
  if keyF and not throttleDownLock then
    throttleIndex = throttleIndex - 1
    if throttleIndex < 1 then
      throttleIndex = 1
    end
  end
  throttleDownLock = keyF


  --------------------------------------------------------------
  -- 3. Shift Izquierdo → SUBIR freno
  --------------------------------------------------------------
  local shift = ac.isKeyDown(ui.KeyIndex.LeftShift)
  if shift and not shiftLock then
    brakeIndex = brakeIndex + 1
    if brakeIndex > #brakeModes then brakeIndex = #brakeModes end
  end
  shiftLock = shift


  --------------------------------------------------------------
  -- 4. Ctrl Izquierdo → BAJAR freno
  --------------------------------------------------------------
  local ctrl = ac.isKeyDown(ui.KeyIndex.LeftControl)
  if ctrl and not ctrlLock then
    brakeIndex = brakeIndex - 1
    if brakeIndex < 1 then brakeIndex = 1 end
  end
  ctrlLock = ctrl


  --------------------------------------------------------------
  -- 5. Acelerador (click izquierdo)
  --------------------------------------------------------------
  if useMouseButtons and ac.isKeyDown(ui.KeyIndex.LeftButton) then
    gasFinal = throttleModes[throttleIndex]
  else
    gasFinal = 0
  end


  --------------------------------------------------------------
  -- 6. Freno (click derecho)
  --------------------------------------------------------------
  if useMouseButtons and ac.isKeyDown(ui.KeyIndex.RightButton) then
    brakeFinal = brakeModes[brakeIndex]
  else
    brakeFinal = 0
  end


  --------------------------------------------------------------
  -- 7. Steering
  --------------------------------------------------------------
  steeringFinal = steeringFinal + deltaX * 0.40
  steeringFinal = math.clamp(steeringFinal, -1, 1)


  --------------------------------------------------------------
  -- 8. Enviar inputs
  --------------------------------------------------------------
  local state = ac.getJoypadState()
  state.steer = steeringFinal
  state.gas = gasFinal
  state.brake = brakeFinal
end
