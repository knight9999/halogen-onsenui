module MainPage where

import Prelude
import Data.Maybe (Maybe(..), fromJust)
import Data.Const (Const)
import Data.Tuple (fst, snd)

import Halogen as H
import Halogen.Component
import Halogen.HTML as HH
import Halogen.HTML.Events as HE
import Halogen.HTML.Properties as HP
import Halogen.HTML.Core (ElemName(..), PropName(..), AttrName(..), HTML(..), Namespace, Prop)

import OnsPage as OP

import Data.Either (Either)
import Data.Functor.Coproduct (Coproduct)

import Effect.Aff
import Effect.Aff.Compat

import Effect.Class (class MonadEffect, liftEffect)
import Effect.Console (log)
import Effect (Effect)

import Data.Maybe (Maybe(..), maybe)

import Control.Monad.List.Trans (fromEffect)
import Data.Int (fromNumber)

import Data.Array as Array

import Query as Q
import Util as Util

import Data.Maybe (fromMaybe)


data Query a = HandleMessage Q.NavMessage a 

type State = 
  {
    pageStack :: Q.PageStack -- Array(HTML (ComponentSlot HTML Q.PageQuery Aff Q.Slot (Q.Query Unit)) (Q.Query Unit))
  }

foreign import pushPageImpl :: String -> String -> EffectFnAff Unit

pushPage :: String -> String -> Aff Unit
pushPage navId pageId = fromEffectFnAff $ pushPageImpl navId pageId

foreign import popPageImpl :: String -> EffectFnAff Unit

popPage :: String -> Aff Unit
popPage navId = fromEffectFnAff $ popPageImpl navId


navigatorId :: String
navigatorId = "myNavigator"


component :: H.Component HH.HTML Query Unit Void Aff
component =
  H.parentComponent 
    { initialState: const initialState
    , render
    , eval
    , receiver: const Nothing
    }
  where

  initialState :: State
  initialState = { pageStack: [ { id: Q.SlotId "1", pageId: "first-page", component: OP.component } ] }

  render :: State -> H.ParentHTML Query Q.PageQuery Q.SlotId Aff
  render state =
    HH.element (ElemName "ons-navigator") 
    [ HP.attr (AttrName "id") navigatorId ] 
    (map (\x -> HH.slot x.id x.component { pageId: x.pageId } (HE.input HandleMessage)) state.pageStack)

  eval :: Query ~> H.ParentDSL State Query Q.PageQuery Q.SlotId Void Aff
  eval = case _ of 
    HandleMessage (Q.NavMessage (Q.NavEventPush pg2)) next -> do
      z <- H.get
      let l = Array.last z.pageStack
      case l of
        Just l2 -> do
          let pageId = l2.pageId
          H.modify_ (\st -> st { pageStack = Array.snoc st.pageStack pg2} )
          _ <- H.liftAff $ pushPage ("#" <> navigatorId) pageId
          pure next
        Nothing -> do
          H.modify_ (\st -> st { pageStack = Array.snoc st.pageStack pg2} )
          pure next
    HandleMessage (Q.NavMessage Q.NavEventPop) next -> do
      _ <- H.liftAff $ popPage ("#" <> navigatorId)
      H.modify_ (\st -> st { pageStack = Util.deleteLast st.pageStack } )
      pure next
    HandleMessage _ next -> do
      pure next
