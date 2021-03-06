{-# LANGUAGE TemplateHaskell #-}

module Application where

import Control.Lens
import Snap.Snaplet
import Snap.Snaplet.Heist


-- | The application types
data App = App
           { _heist :: Snaplet (Heist App) }

makeLenses ''App

instance HasHeist App where
  heistLens = subSnaplet heist

type AppHandler = Handler App App
