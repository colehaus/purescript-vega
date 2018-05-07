module Charts.Vega.Primitive
  ( module Charts.Vega.Primitive
  , module ForReExport
  ) where

import Prelude

import Control.Monad.Eff (Eff)
import DOM (DOM)
import Data.Argonaut.Core (Json, JObject)
import Data.Foreign (toForeign)
import Data.These (These(..))
import Charts.Vega.Primitive.Internal (View) as ForReExport
import Charts.Vega.Primitive.Internal (View, insertAndRemoveData, insertData, removeData)

type Chart = Json
type ChartOpts = Json
type Selector = String

foreign import embed ::
  forall e.
     Selector
  -> Chart
  -> ChartOpts
  -> (View -> Eff (dom :: DOM | e) Unit)
  -> Eff (dom :: DOM | e) Unit

data Remove
  = ByPredicate (JObject -> Boolean)
  | ByPoints (Array JObject)

type ChangeSet = These { remove :: Remove } { insert :: Array JObject }

changeData :: forall e. String -> ChangeSet -> View -> Eff (dom :: DOM | e) Unit
changeData dataName (This { remove }) view =
  case remove of
    ByPredicate pred -> removeData dataName (toForeign pred) view
    ByPoints points -> removeData dataName (toForeign points) view
changeData dataName (That { insert }) view = insertData dataName (toForeign insert) view
changeData dataName (Both { remove } { insert }) view =
  case remove of
    ByPredicate pred -> insertAndRemoveData dataName (toForeign insert) (toForeign pred) view
    ByPoints points -> insertAndRemoveData dataName (toForeign insert) (toForeign points) view
