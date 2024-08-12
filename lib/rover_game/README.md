## Notes

- Create a CLI that prompts for commands and moves a rover around a 2d plane
- Should point in a direction
- Should turn to face different directions
- Moves in the direction that it's facing

- There can be a bounding box, or not
- Moving in a direction moves one "unit", 1 distance
- What's the UI look like? Prompt with controls, reports back in a reasonable way (position/facing/distance)
- ncurses ascii map is all fine, but not necessary
- Starts at 0,0

Prompt:
Position (x, y), Direction (NEWS)
Turn left (a), Go forward (w), Turn right (d)

InfinitePlane
  - instance of Rover
Rover
  - direction
  - position (relative to origin at 0,0)

Next step

- Add stationary objects
- If it moves into an occupied space, it gets cranky
-
