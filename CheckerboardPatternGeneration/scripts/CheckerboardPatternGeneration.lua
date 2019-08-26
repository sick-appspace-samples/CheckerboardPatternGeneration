--[[----------------------------------------------------------------------------

  Application Name:
  CheckerboardPatternGeneration

  Summary:
  Generating checkerboard pattern

  Description:
  Creating a checkerboard pattern to be saved to file, printed and used as 2D
  calibration target.

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

print("AppEngine Version: ".. Engine.getVersion())

-- Creating viewer
local viewer = View.create()

-- Delay for visualization purposes
local DELAY = 1000

--End of Global Scope-----------------------------------------------------------

--Start of Function and Event Scope---------------------------------------------

local function main()
  local patterns = {'PLAIN', 'THREE_DOT', 'COORDINATE_CODE'}
  for index, patternType in ipairs(patterns) do
    -- Select the approximate square size to generate
    local desiredSquareSize = 16.0 -- mm

    -- Generating an A4 with a 10 mm padding (most printers can't print all the way out in the corners)
    local actualSquareSize, patternImage = Image.Calibration.Pattern.getCheckerboardDPI(
                                                                                        297 - 10,
                                                                                        210 - 10,
                                                                                        desiredSquareSize,
                                                                                        patternType
                                                                                       )
    print('Pattern generated with square size: ' .. string.format('%.3f', actualSquareSize) .. ' mm')
    viewer:clear()
    viewer:addImage(patternImage)
    viewer:present()

    -- Saving image with actual square size in file name
    Image.save(patternImage, string.format('private/A4_%s_%.0fum.png', patternType, 1000 * actualSquareSize))
    print('Finished generating image ' .. index .. ' of ' .. #patterns)
    Script.sleep(DELAY)
  end
  print('App finished.')
end
--The following registration is part of the global scope which runs once after startup
--Registration of the 'main' function to the 'Engine.OnStarted' event
Script.register('Engine.OnStarted', main)

--End of Function and Event Scope--------------------------------------------------
