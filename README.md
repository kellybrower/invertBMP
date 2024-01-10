# invertBMP

## Stack

To run: use `stack build`.

After the program has been built, you can execute the program with
```stack exec inverBMP-exe <image.bmp>```
where  `<image.bmp>` is the 24 bpp bmp image of your choice.  `blackbuck.bmp` is provided as an example to demonstrate.

## Demo
```
stack build
stack exec invertBMP-exe blackbuck.bmp
```
Then check your current directory: you should see an inverted black buck!

Moved https://github.com/kellybrower/invertBMPHaskell here using Stack
