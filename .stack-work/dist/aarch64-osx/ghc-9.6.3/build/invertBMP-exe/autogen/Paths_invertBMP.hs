{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
#if __GLASGOW_HASKELL__ >= 810
{-# OPTIONS_GHC -Wno-prepositive-qualified-module #-}
#endif
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module Paths_invertBMP (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where


import qualified Control.Exception as Exception
import qualified Data.List as List
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude


#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir `joinFileName` name)

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath




bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath
bindir     = "/Users/kellybrower/mystuff/Haskell/playground/Invert/invertBMP/.stack-work/install/aarch64-osx/9adefc73cdad644e5413123464c29b99959efec374ea058e55999a2edcada72e/9.6.3/bin"
libdir     = "/Users/kellybrower/mystuff/Haskell/playground/Invert/invertBMP/.stack-work/install/aarch64-osx/9adefc73cdad644e5413123464c29b99959efec374ea058e55999a2edcada72e/9.6.3/lib/aarch64-osx-ghc-9.6.3/invertBMP-0.1.0.0-64YpQgllvkB1ofPxkGH4vW-invertBMP-exe"
dynlibdir  = "/Users/kellybrower/mystuff/Haskell/playground/Invert/invertBMP/.stack-work/install/aarch64-osx/9adefc73cdad644e5413123464c29b99959efec374ea058e55999a2edcada72e/9.6.3/lib/aarch64-osx-ghc-9.6.3"
datadir    = "/Users/kellybrower/mystuff/Haskell/playground/Invert/invertBMP/.stack-work/install/aarch64-osx/9adefc73cdad644e5413123464c29b99959efec374ea058e55999a2edcada72e/9.6.3/share/aarch64-osx-ghc-9.6.3/invertBMP-0.1.0.0"
libexecdir = "/Users/kellybrower/mystuff/Haskell/playground/Invert/invertBMP/.stack-work/install/aarch64-osx/9adefc73cdad644e5413123464c29b99959efec374ea058e55999a2edcada72e/9.6.3/libexec/aarch64-osx-ghc-9.6.3/invertBMP-0.1.0.0"
sysconfdir = "/Users/kellybrower/mystuff/Haskell/playground/Invert/invertBMP/.stack-work/install/aarch64-osx/9adefc73cdad644e5413123464c29b99959efec374ea058e55999a2edcada72e/9.6.3/etc"

getBinDir     = catchIO (getEnv "invertBMP_bindir")     (\_ -> return bindir)
getLibDir     = catchIO (getEnv "invertBMP_libdir")     (\_ -> return libdir)
getDynLibDir  = catchIO (getEnv "invertBMP_dynlibdir")  (\_ -> return dynlibdir)
getDataDir    = catchIO (getEnv "invertBMP_datadir")    (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "invertBMP_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "invertBMP_sysconfdir") (\_ -> return sysconfdir)



joinFileName :: String -> String -> FilePath
joinFileName ""  fname = fname
joinFileName "." fname = fname
joinFileName dir ""    = dir
joinFileName dir fname
  | isPathSeparator (List.last dir) = dir ++ fname
  | otherwise                       = dir ++ pathSeparator : fname

pathSeparator :: Char
pathSeparator = '/'

isPathSeparator :: Char -> Bool
isPathSeparator c = c == '/'
