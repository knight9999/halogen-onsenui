module HelloWorld where

import Prelude
import Data.Maybe (Maybe(..))
import Halogen as H
import Halogen.HTML as HH

type State = Unit

data Query a = Query a
  
type Message = Unit

component :: forall m. H.Component HH.HTML Query Unit Message m
component = 
  H.component
    { initialState: const unit
    , render
    , eval
    , receiver: const Nothing
    }
  where

  render :: State -> H.ComponentHTML Query
  render state = HH.div [] [ HH.text "Hello World" ]

  eval :: Query ~> H.ComponentDSL State Query Message m
  eval (Query next) = pure next 