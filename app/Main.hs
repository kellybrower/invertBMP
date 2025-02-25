module Main (main) where

import qualified Data.ByteString as B
import System.Environment (getArgs)
import System.FilePath (takeExtension)
import Control.Monad (forM_)
import System.Exit (exitFailure)

type ImgPath = String
type BMPBytes = B.ByteString

-- | Check if the file has a .bmp extension.
isBMP :: ImgPath -> Bool
isBMP path = takeExtension path == ".bmp"

-- | Check if the BMP image is 24 bits per pixel.
is24BBP :: BMPBytes -> Bool
is24BBP bytes = B.index bytes 28 == 24

-- | Retrieve the pixel offset from the BMP header.
pixelOffset :: BMPBytes -> Int
pixelOffset bytes = fromIntegral $ B.index bytes 10

-- | Invert a BMP image assuming it is 24 bits per pixel.
invertBMP :: ImgPath -> IO (Either String ())
invertBMP path
  | not (isBMP path) = return $ Left "File is not a BMP image."
  | otherwise = do
      bytes <- B.readFile path
      if not (is24BBP bytes)
        then return $ Left "Image is not 24 bbp."
        else do
          let offset = pixelOffset bytes
              -- Use B.splitAt to separate header and pixel data in one go.
              (header, pixels) = B.splitAt offset bytes
              invertedPixels = B.map (255 -) pixels
              invertedBMP = header <> invertedPixels
          B.writeFile ("Inverted_" ++ path) invertedBMP
          return $ Right ()

-- | Process a list of image paths.
processImages :: [ImgPath] -> IO ()
processImages [] = putStrLn "No images provided."
processImages paths = forM_ paths $ \path -> do
  result <- invertBMP path
  case result of
    Left err -> putStrLn $ "Error processing " ++ path ++ ": " ++ err
    Right () -> putStrLn $ "Inverted image saved for: " ++ path

main :: IO ()
main = do
  args <- getArgs
  if null args
    then do
      putStrLn "Usage: ./Main <image_file.bmp> [more images...]"
      exitFailure
    else processImages args

