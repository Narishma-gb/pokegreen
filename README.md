# Japanese Pokémon Red and Green

This is a disassembly of ポケットモンスター　赤・緑.

This branch aims to recreate a debug build close to the original one, with a few edits. A decent amount of space was gained by optimizing the SGB border tilemap, similar to what is done in Gold & Silver, and moving some data in the unused header area in Home bank. As a result, both Mew *and* the debug tools can fit on the ROM.
It builds all 4 retail ROMs, stripped of the garbage bytes, and a Green debug version.

## Credits

The whole repository structure, most ASM files, tools and build scripts originate from pret [**pokered**][pokered].

[pokered]: https://github.com/pret/pokered
