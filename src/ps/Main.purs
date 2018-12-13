module Main where
  
import Prelude
import Effect (Effect)
import Effect.Console (log)

import Effect.Class (liftEffect)

import Effect.Aff
import Effect.Aff.Compat

import Halogen.Aff as HA
import Halogen.VDom.Driver (runUI)

import MainPage as MP

foreign import onsReadyImpl :: EffectFnAff Unit

onsReady :: Aff Unit
onsReady = fromEffectFnAff onsReadyImpl


main :: Effect Unit
main = do
  launchAff_ do
    _<- onsReady
    liftEffect do
      HA.runHalogenAff do
        body <- HA.awaitBody
        runUI MP.component unit body
