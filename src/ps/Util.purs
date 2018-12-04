module Util where

import Prelude
import Data.Maybe (fromMaybe)
import Data.Array as Array

deleteLast :: forall a. Array a -> Array a
deleteLast as = Array.reverse $ fromMaybe [] $ Array.deleteAt 0 $ Array.reverse as


