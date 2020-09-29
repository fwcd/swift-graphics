# Swift Graphics

Cross-platform 2D drawing library for Swift based on Cairo.

## System Dependencies

### Linux
* `sudo apt-get install libcairo2-dev`
    * If Swift cannot find the Freetype headers despite `libfreetype6-dev` being installed, you may need to add symlinks:
        * `mkdir /usr/include/freetype2/freetype`
        * `ln -s /usr/include/freetype2/freetype.h /usr/include/freetype2/freetype/freetype.h`
        * `ln -s /usr/include/freetype2/tttables.h /usr/include/freetype2/freetype/tttables.h`
    * Note that you might need to `apt-get install clang` separately on a Raspberry Pi

### macOS
* `brew install cairo`


