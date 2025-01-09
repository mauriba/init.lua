-- cd build && ghc -o test.exe -outputdir . ../test.hs && test
import Prelude hiding (abs)

eveno :: Int -> Bool
eveno n = n `mod` 2 == 0

noto :: Bool -> String
noto True = "Number is even"
noto False = "Number is odd"

main = do
  print ((noto.eveno) 2)
