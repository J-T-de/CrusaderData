# CrusaderData
Collection of Stronghold Crusader data.

## Idea
The idea of this repo is to collect useful data and code snippets to mod [Stronghold Crusader](http://www.strongholdcrusaderhd.com/game.html). The main aim is to accelerate development of new edits for the [UnofficalCrusaderPatch](https://github.com/Sh0wdown/UnofficialCrusaderPatch) (UCP), however, the data might also be useful for other Crusader projects.

## Data Collection
As [CheatEngine](https://www.cheatengine.org/downloads.php) is the tool of choice for most game reverse engineers, data is collected in [Lua](https://www.lua.org/start.html) files (*.lua), which can be imported in CheatEngine. Data contains

* base addresses / AOBs
* data structures (arrays)
* functions

If one has all this information, CheatEngine allows rapid prototyping of [mods](https://github.com/J-T-de/CrusaderData/tree/master/mods). With some adjustments, these mods can be incorporated in the UCP.

## Acknowledgements
I want to express my special thanks to

[Firefly Studios](https://fireflyworlds.com) for creating the games of my childhood, Stronghold and Stronghold Crusader

[Sh0wdown](https://github.com/Sh0wdown) for creating the amazing [UnofficalCrusaderPatch](https://github.com/Sh0wdown/UnofficialCrusaderPatch)

[ngc92](https://github.com/ngc92) for the first data ([UCP issue #271](https://github.com/Sh0wdown/UnofficialCrusaderPatch/issues/271)), the huge data dump ([PR #2](https://github.com/J-T-de/CrusaderData/pull/2)) and the inspiration to collect the data.
