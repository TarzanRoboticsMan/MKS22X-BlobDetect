## MKS22X-BlobDetect
# BlobDetect
### Final Project, June 2019 APCS
### By Coby Sontag

Welcome to BlobDetect, the scrappy underdog to computer vision. The controls are simple - press keys '0' and '1' to assign the BlobInputs to the objects currently in the center of the screen.
Debugging and visual controls:
|Control|Use                                   |
|------:|--------------------------------------|
|      h|Sets Hue to be adjusted, increment=1  |
|      s|Sets Saturation to be adjusted, inc=.1|
|      b|Sets Brightness to be adjusted, inc=.1|
|      [|Adjusts target value by 0.1           |
|      ]|Adjusts target value by -0.1          |
|      a|Enter black and white isTarget mode   |
---
### Dev Log
May 20th:
  Established video capabilities on my MacBook and discovered bounds of sizing the video
May 21st:
  Discovered PImage is compatible with Capture. loadImage() and updateImage() unnecessary, but pixels[] field exists. Began to write function for comparing color to target color
May 22nd:
  Learn to use get(x,y) function for color. Also, switched to HSV because it’s a much less complicated scheme for what I’m doing. Continued writing the color compare function
May 23rd:
  Discovering my initial target acquisition sucks because my camera goes from black and then adjusts for lighting
May 24-26th:
  Spent time in catskill mountains with limited computer access. Heavily updated prototype with past changes and new optimizations for Monday when I got back. This is when I fixed / planned fixes to my "CV Mode" visualizer
May 27th:
  Target acquired method gets added behavior of showing its new color for debugging and visuals.
May 28th:
  Continued beautifying class structure, separating out the new BlobInput class
May 29th:
  Fixed target acquired behavior to show the acquired target. Also shows full brightness halo
May 30th:
  Fixed camera mirroring issue using matrix. Enhanced isTarget code to use Saturation, Brightness. Worked on a recursive method to determine blob size. Began coding the hockey game
May 31st:
  Heavy modifications to allow changing H,S,B tolerances while running program. Changed isTarget to account for the fact that H0 and H360 are the same color. Spent time with Joseph Lee discussing and planning out hockey data structure.
June 1st:
  Updated prototype with class structure for hockey game, began to implement in code.
June 2nd:
  Just research.
June 3rd:
  Overhauled finding x and y coordinates by using my isTarget method and not iterating from a single point. Basically, I made the isTarget method good enough to just take the average of those pixels without worrying about recursively checking if they're in a single "blob" of the screen
June 4th:
  Began overhaul of adding a second input, by changing all my methods to pull inputs out of an array list.
June 5th:
  Added automatic color updating based on x,y coordinates to the BlobInput. Each BlobInput also has its own hockey pucker now. Added in movement constraints for the hockey puck "ball"
