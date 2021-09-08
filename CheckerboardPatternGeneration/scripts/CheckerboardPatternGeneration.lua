
--Start of Global Scope---------------------------------------------------------

print("AppEngine Version: ".. Engine.getVersion())

-- Creating viewer
local viewer = View.create("viewer2D1")

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
