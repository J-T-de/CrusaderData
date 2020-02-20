# CrusaderData
Collection of Stronghold Crusader data.

## Idea
The idea of this repo is to collect useful data and code snippets to mod [Stronghold Crusader](http://www.strongholdcrusaderhd.com/game.html). The main aim is to accelerate development of new edits for the [UnofficalCrusaderPatch](https://github.com/Sh0wdown/UnofficialCrusaderPatch) (UCP), however, the data might also be useful for other Crusader projects.

## Data Collection
As [CheatEngine](https://www.cheatengine.org/downloads.php) is the tool of choice for most Crusader modders, data is collected in a CheatTable (.CT file). The programming languages used in CheatEngine are assembly and [Lua](https://www.lua.org/start.html). The data is collected in the CheatTable Lua section. It contains

* base addresses / AOBs
* data structures (arrays)
* functions

If one has all this information, CheatEngine allows rapid prototyping of [mods](https://github.com/J-T-de/CrusaderData/tree/master/mods). With some adjustments, these mods can be incorporated in the UCP.

*In the future, the data will be migrated to C-arrays and a Lua interface will be provided. This has the advantage, that C/C++ users can directly use this data, and for Lua users, almost nothing will change.*

It would also be nice to use a collaborative online disassambler, but as Crusader is copyrighted, this is no legal possibility.

## Acknowledgements
I want to express my special thanks to

[Firefly Studios](https://fireflyworlds.com) for creating the games of my childhood, Stronghold and Stronghold Crusader

[Sh0wdown](https://github.com/Sh0wdown) for creating the amazing [UnofficalCrusaderPatch](https://github.com/Sh0wdown/UnofficialCrusaderPatch)

[ngc92](https://github.com/ngc92) for the first data and the inspiration to collect it in a CheatTable ([UCP issue #271](https://github.com/Sh0wdown/UnofficialCrusaderPatch/issues/271))
