
This GA144 simulator has been pulled from
the rest of [these](https://github.com/mschuldt/ga144) GA144 tools
and modified for use as a standalone simulator
with [ga-tools](https://github.com/mschuldt/ga-tools).

The only dependency is a recent version of Emacs.
It has only been tested on Linux.

# Installation
`make` to byte compile - important for speed!

`make install` to install the `ga-sim` script
# Overview
The ga144 map in corner shows the active node as green
and colors other nodes shades of red to indicate
their ram usage when in 'usage view'.
when in 'activity view' the shade of red represents recent
activity in that node.

The stacks for the active node are listed on the bottom left
under the map. The data stack is on the left.

The registers for the active node are to the right of the stack.

A view of the active nodes disassembled RAM is to the right of the map.

# Usage
Run with: `ga FILE.ga --sim`
The `ga` script is installed from [ga-tools](https://github.com/mschuldt/ga-tools)
## Simulation control
### Selecting the active node
Use arrow keys to move the selected node visable on the map.

Additionally common Emacs movement keys are supported such as
C-n, C-p, C-b, C-f, C-e, C-a, M-b, M-f, M-m
### Running the simulation
 - `s` Step the selected node by the current step increment (default 1)
 - `S` Like 's' but steps all nodes
 - `c` Continue stepping until quit 'g' or all nodes are suspended
 - `n` Set the step increment used by 's'
 - `Q` Exit simulator
### Map view control
 - `u` usage view (default)
 - `a` activity view
 - `+` increase map size
 - `-` decrease map size
### RAM view control
 - `<` Move view up (towards lower addresses)
 - `>` Move view down
 - `0` Move view to start of RAM
 - `.` Center view on P

# TODO
- fix simulation of bootstream loading
- mouse support
