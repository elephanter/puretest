module Main where

import Prelude

import Control.Promise (Promise, fromAff)
import Data.Generic.Rep (class Generic)
import Data.Generic.Rep.Show (genericShow)
import Data.Interval (second)
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Aff (Aff(..), Canceler(..), Fiber, Milliseconds(..), delay, launchAff, launchAff_, makeAff, parallel, runAff, runAff_)
import Effect.Class (liftEffect)
import Effect.Console (log)
-- Call purescript from native
------
-- simple function with multiple args
-- async function with promise return
-- return ADT type

-- simple function with multiple arguments
simpleFunc:: String -> Int -> String
simpleFunc s i = s <> show i

data Sex = Male | Female | Unknown
-- instance showSex :: Show Sex where
--     show Male = "Male"
--     show Female = "Female"

-- Below we create show instance using Generics
derive instance genericSex :: Generic Sex _
instance showSex :: Show Sex where
    show a = genericShow a

--Showing adt type
showMeSex:: Sex -> String
showMeSex a = show a

-- using Type with arguments
printMaybe:: Maybe Sex -> String
printMaybe (Just a) = show a
printMaybe Nothing = show Unknown

-- returning adt type
retSex:: String -> Maybe Sex
retSex "vasya" = Just Male
retSex "masha" = Just Female
retSex _ = Nothing

-- call callback
doCallback:: (Int->String) -> String
doCallback cb = cb 5

-- call async callback
doAsync :: (Int -> String) -> Effect String
doAsync cb = do
  _ <- launchAff do
    delay (Milliseconds 10000.0)
    let x = cb 5
    pure 10
  pure "Launched"

-- Run async task on this method call. Without any control.
asyncTask :: Number -> Effect Unit
asyncTask n = launchAff_ do
  liftEffect $ log $ "asyncTask started with delay " <> show n
  delay (Milliseconds n)
  liftEffect $ log "asyncTask work done"
  pure "Done"

--Return promise to native js. Fires async task on call and attach it to promise
doPromise:: Effect (Promise (String))
doPromise = fromAff $ do
    delay (Milliseconds 20.0)
    pure "Done inline Aff"

testEff :: Effect String
testEff = do
  log "Test Effect"
  pure "Done"

main :: Effect Unit
main = do
  log "Hello sailor!"
