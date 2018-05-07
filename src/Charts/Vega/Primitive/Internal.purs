module Charts.Vega.Primitive.Internal where

import Prelude

import Control.Monad.Eff (Eff)
import DOM (DOM)
import Data.Foreign (Foreign)

foreign import data View :: Type

foreign import removeData :: forall e. String -> Foreign -> View -> Eff (dom :: DOM | e) Unit
foreign import insertData :: forall e. String -> Foreign -> View -> Eff (dom :: DOM | e) Unit
foreign import insertAndRemoveData :: forall e. String -> Foreign -> Foreign -> View -> Eff (dom :: DOM | e) Unit
