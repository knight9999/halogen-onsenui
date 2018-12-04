module OnsPage2 where

import Prelude
import Data.Maybe (Maybe(..))
import Halogen as H
import Halogen.HTML as HH
import Halogen.HTML.Events as HE
import Halogen.HTML.Properties as HP
import Halogen.HTML.Core (ElemName(..), PropName(..), AttrName(..), HTML(..), Namespace, Prop)
import Effect.Console (log)

import Query as Q

type State = {
  title :: String,
  pageId :: String
}

component :: forall m. H.Component HH.HTML Q.PageQuery Q.PageArgs Q.NavMessage m
component =
  H.component 
    { initialState: \x -> { title: "入力", pageId: x.pageId }
    , render
    , eval
    , receiver: const Nothing
    }
  where

  render :: State -> H.ComponentHTML Q.PageQuery
  render status = HH.element (ElemName "ons-page") [ HP.attr (AttrName "id") status.pageId ] 
    [ HH.element (ElemName "ons-toolbar") [] 
      [ HH.div [HP.attr (AttrName "class") "left"]
          [ HH.text ""],
        HH.div [HP.attr (AttrName "class") "center"] 
          [ HH.text status.title],
        HH.div [HP.attr (AttrName "class") "right"] 
          [ HH.element (ElemName "ons-toolbar-button") 
            [ HP.attr (AttrName "component") "button/new-task",
              HE.onClick (HE.input_ (Q.PageQuery "btnClicked2")) ] 
            [ HH.text "+"]
          ]
      ] 
    , HH.div [HP.attr (AttrName "class") "page__background", HP.attr (AttrName "style") ""]
      [ HH.text "" ]
    , HH.div [HP.attr (AttrName "class") "page__content", HP.attr (AttrName "style") ""]
      [ HH.div [HP.attr (AttrName "style") "text-align: center"] 
        [ HH.p [] [ HH.text "This is a second page" ]
        , HH.element (ElemName "ons-button") [ HE.onClick (HE.input_ (Q.PageQuery "btnClicked3")) ] [ HH.text "Pop page"] 
        ]
      ]
    ]
  eval :: Q.PageQuery ~> H.ComponentDSL State Q.PageQuery Q.NavMessage m
  eval (Q.PageQuery "btnClicked2" next) = do
      H.modify_ (_ { title = "完了" })
      pure next
  eval (Q.PageQuery "btnClicked3" next) = do
      H.raise $ Q.NavMessage Q.NavEventPop 
      pure next
  eval (Q.PageQuery _ next) = pure next
