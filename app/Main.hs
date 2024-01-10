module Main (main) where

import qualified Data.ByteString as B
import System.Environment (getArgs)
import System.FilePath.Posix (takeExtension)

type ImgPath = String

type BMPBytes = B.ByteString

-- Helper Functions --
imgIsBMP :: ImgPath -> Bool
imgIsBMP s = takeExtension s == ".bmp"

bbpIs24 :: BMPBytes -> Bool
bbpIs24 b = B.index b 28 == 24

pixeloffset :: BMPBytes -> Int
pixeloffset b = fromIntegral $ B.index b 10

-- Assumes that the image provided is BMP and 24 bits per pixel
invert :: ImgPath -> IO ()
invert imgPath = do
  imgBytes <- B.readFile imgPath
  if imgIsBMP imgPath && bbpIs24 imgBytes
    then do
      let po = pixeloffset imgBytes
      let bmpHeaders = B.take po imgBytes
      let pixels = B.drop po imgBytes
      let invertedPixels = B.map (255 -) pixels
      let invertedBMP = bmpHeaders <> invertedPixels
      B.writeFile ("Inverted_" ++ imgPath) invertedBMP
    else error "This is not a 24 bbp BMP file."

processImages :: [String] -> IO ()
processImages [] = return () -- If there are no images, do nothing.
processImages (x : xs) = do
  invert x
  putStrLn $ "Inverted image saved for: " ++ x
  processImages xs

main :: IO ()
main = do
  args <- getArgs
  if null args
    then do
      putStrLn "No image file specified."
      putStrLn "Usage: ./Main <image_file.bmp>"
    else processImages args
