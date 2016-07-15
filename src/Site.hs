module Site (
         app
       ) where

import           Snap.Core
import           Snap.Snaplet
import           Snap.Util.FileServe
import           Data.ByteString                             (ByteString)
import           Control.Applicative
import qualified Data.Configurator                           as C
import           Snap.Snaplet.Heist
import           Heist
import qualified Heist.Interpreted                           as I
import           Control.Monad.Trans
import           Snap.Snaplet.Auth
import           Snap.Snaplet.Auth.Backends.JsonFile
import           Snap.Snaplet.Session.Backends.CookieSession
import           Snap.Extras


import Application


testH :: AppHandler ()
testH = writeBS "Hello"

-- | The application's routes
routes :: [(ByteString, Handler App App ())]
routes = [("/test", serveDirectory "static")]


app :: SnapletInit App App
app = makeSnaplet "app" "Android docs application snaplet." Nothing $ do
    conf <- getSnapletUserConfig
    stpth <- liftIO (C.require conf "staticPath")
    h <- nestSnaplet "" heist $ heistInit "templates"
    s <- nestSnaplet "sess" sess $
               initCookieSessionManager (stpth ++ "/site_key.txt") "sess" (Just 3600)
    a <- nestSnaplet "auth" auth $
               initJsonFileAuthManager defAuthSettings sess (stpth ++ "/users.json")
    addRoutes routes
    addAuthSplices h auth
    return $ App h s a

