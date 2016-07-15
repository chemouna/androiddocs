{-# LANGUAGE CPP #-}
{-# LANGUAGE TemplateHaskell #-}

module Main where

import           Snap.Core
import           Snap.Http.Server
import           Snap.Snaplet.Config
import           Snap.Snaplet
import           System.IO
import           Control.Exception (SomeException, try)
import qualified Data.Text as T

import Site

#ifdef DEVELOPMENT
import           Snap.Loader.Dynamic
#else
import           Snap.Loader.Static
#endif

main :: IO ()
main = do
  (conf, site, cleanup) <- $(loadSnapTH [| getConf |]
                                          'getActions
                                          ["snaplets/heist/templates"])
  _ <- try $ httpServe conf site :: IO (Either SomeException ())
  cleanup

getConf :: IO (Config Snap AppConfig)
getConf = commandLineAppConfig defaultConfig

getActions :: Config Snap AppConfig -> IO (Snap (), IO ())
getActions conf = do
  (msgs, site, cleanup) <- runSnaplet
    (appEnvironment =<< getOther conf) app
  hPutStrLn stderr $ T.unpack msgs
  return (site, cleanup)
