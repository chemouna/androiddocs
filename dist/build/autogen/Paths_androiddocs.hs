module Paths_androiddocs (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
catchIO = Exception.catch

version :: Version
version = Version [0,1] []
bindir, libdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/Users/m.cheikhna/.cabal/bin"
libdir     = "/Users/m.cheikhna/.cabal/lib/x86_64-osx-ghc-7.10.3/androiddocs-0.1-9PX3CTfQ8vvA2MxeJ4d45Q"
datadir    = "/Users/m.cheikhna/.cabal/share/x86_64-osx-ghc-7.10.3/androiddocs-0.1"
libexecdir = "/Users/m.cheikhna/.cabal/libexec"
sysconfdir = "/Users/m.cheikhna/.cabal/etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "androiddocs_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "androiddocs_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "androiddocs_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "androiddocs_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "androiddocs_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
