--[[----------------------------------------------------------------------------

  Application Name:
  CheckerboardPatternGeneration

  Summary:
  Generating checkerboard pattern

  Description:
  Creating a checkerboard pattern to be saved to file, printed and used as 2D
  calibration target

  How to Run:
  Starting this sample is possible either by running the app (F5) or
  debugging (F7+F10). Setting breakpoint on the first row inside the 'main'
  function allows debugging step-by-step after 'Engine.OnStarted' event.
  Results can be seen in the image viewer on the DevicePage. The generated
  image is saved to the specified location.

  More Information:
  Tutorial "Algorithms - Calibration2D".

------------------------------------------------------------------------------]]
--Start of Global Scope---------------------------------------------------------

-- Creating viewer
local viewer = View.create()
viewer:setID('viewer2D')

--End of Global Scope-----------------------------------------------------------

--Start of Function and Event Scope---------------------------------------------

local function main()
  -- Select which pattern type to generate
  -- patternType = 'PLAIN'
  -- patternType = 'THREE_DOT'
  local patternType = 'COORDINATE_CODE'
  local desiredSquareSize = 16.0 -- mm

  -- Generating an A4 with a 10 mm padding (most printers can't print all the way out in the corners)
  local actualSquareSize, pattern = Image.Calibration.Pattern.getCheckerboardDPI(
                                                                                  297 - 10,
                                                                                  210 - 10,
                                                                                  desiredSquareSize,
                                                                                  patternType
                                                                                )
  print('Pattern generated with square size: ' .. string.format('%.3f', actualSquareSize) .. ' mm')
  viewer:view(pattern)

  -- Saving image with actual square size in file name
  Image.save(pattern, 'private/A4_' .. patternType .. '_' .. string.format('%.0f', 1000 * actualSquareSize) .. 'um.png')
  print('App finished.')
end
--The following registration is part of the global scope which runs once after startup
--Registration of the 'main' function to the 'Engine.OnStarted' event
Script.register('Engine.OnStarted', main)

--End of Function and Event Scope--------------------------------------------------
