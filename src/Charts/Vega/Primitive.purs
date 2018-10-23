module Charts.Vega.Primitive
  ( module Charts.Vega.Primitive
  , module ForReExport
  ) where

import Prelude

import Data.Argonaut.Core (Json)
import Data.These (These(..))
import Effect (Effect)
import Foreign (unsafeToForeign)
import Foreign.Object (Object)

import Charts.Vega.Primitive.Internal (View) as ForReExport
import Charts.Vega.Primitive.Internal (View, insertAndRemoveData, insertData, removeData)

type Chart = Json
type ChartOpts = Json
type Selector = String

foreign import embed ::
     Selector
  -> Chart
  -> ChartOpts
  -> (View -> Effect Unit)
  -> Effect Unit

data Remove
  = ByPredicate (Object Json -> Boolean)
  | ByPoints (Array (Object Json))

type ChangeSet = These { remove :: Remove } { insert :: Array (Object Json) }

changeData :: String -> ChangeSet -> View -> Effect Unit
changeData dataName (This { remove }) view =
  case remove of
    ByPredicate pred -> removeData dataName (unsafeToForeign pred) view
    ByPoints points -> removeData dataName (unsafeToForeign points) view
changeData dataName (That { insert }) view = insertData dataName (unsafeToForeign insert) view
changeData dataName (Both { remove } { insert }) view =
  case remove of
    ByPredicate pred -> insertAndRemoveData dataName (unsafeToForeign insert) (unsafeToForeign pred) view
    ByPoints points -> insertAndRemoveData dataName (unsafeToForeign insert) (unsafeToForeign points) view
