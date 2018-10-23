module Charts.Vega.Primitive.Internal where

import Prelude

import Effect (Effect)
import Foreign (Foreign)

foreign import data View :: Type

foreign import removeData :: String -> Foreign -> View -> Effect Unit
foreign import insertData :: String -> Foreign -> View -> Effect Unit
foreign import insertAndRemoveData :: String -> Foreign -> Foreign -> View -> Effect Unit
