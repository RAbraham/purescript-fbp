module Test.Main where

import Prelude
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE)
import Control.Monad.Aff          (later')
import Test.Spec                  (describe, it)
import Test.Spec.Runner           (run)
import Test.Spec.Assertions       (shouldEqual)
import Test.Spec.Reporter.Console (consoleReporter)
import Node.Process (PROCESS)

data Component a = Component
  { name :: String
  , function :: a -> a
  , inputPorts :: Array String
  , outputPorts :: Array String
  }

data Application a = Application (Component a)

data Packet = Packet

sqr :: Int -> Int
sqr x = x * x

sqrComponent :: Component Int
sqrComponent = Component
  { name: "Squarer"
  , function: sqr
  , inputPorts: ["in"]
  , outputPorts: ["out"]
  }

createApplication :: forall a. Component a  -> Application a
createApplication component = Application component

eval :: forall a. Packet -> Application a -> Application a
eval packet application = application

main :: forall t1. Eff ( process :: PROCESS , console :: CONSOLE | t1) Unit
main = run [consoleReporter] do
  describe "Thampy" do
    describe "Basic" do
      it "runs a single stateless component" do
        let app = createApplication sqrComponent

        let isAwesome = true
        isAwesome `shouldEqual` true
    describe "Features" do
      it "runs in NodeJS" $ pure unit
      it "runs in the browser" $ pure unit
      it "supports async specs" do
        res <- later' 100 $ pure "Alligator"
        res `shouldEqual` "Alligator"
      it "is PureScript 0.10.1 compatible" $ pure unit
