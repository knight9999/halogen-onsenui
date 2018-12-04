module Query where

import Prelude
import Effect.Aff
import Effect.Aff.Compat
import Halogen as H
import Halogen.HTML as HH
import Halogen.Component
import Halogen.HTML.Core (ElemName(..), PropName(..), AttrName(..), HTML(..), Namespace, Prop)


-- general settings
data PageQueryGen t a = PageQuery t a
-- type PageSlotGen m s q pq = HTML (ComponentSlot HTML pq m s (q Unit)) (q Unit)
data NavEventGen s = NavEventPush s | NavEventPop



-- application settings
newtype SlotId = SlotId String
derive newtype instance eqSlotId :: Eq SlotId
derive newtype instance ordSlotId :: Ord SlotId

type PageQuery = PageQueryGen String

type PageArgs = { pageId :: String }

type PageComponent = H.Component HH.HTML PageQuery PageArgs NavMessage Aff
type PageRecord = { id :: SlotId, pageId :: String, component :: PageComponent }
type PageStack = Array PageRecord
type NavEvent = NavEventGen PageRecord
newtype NavMessage = NavMessage NavEvent


