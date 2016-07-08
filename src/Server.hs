module Server where


import Snap.App
import Snap.Http.Server

runServer :: () -> IO ()
runServer = do
  httpServe server (serve ())
  where server = setPort 10001 defaultConfig
