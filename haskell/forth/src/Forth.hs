module Forth
  ( ForthError(..)
  , ForthState
  , evalText
  , toList
  , emptyState
  ) where

import           Data.Char                      ( isDigit
                                                , toLower
                                                )
import           Data.List                      ( find )
import qualified Data.Map                      as M
import           Data.Maybe                     ( fromJust
                                                , isNothing
                                                )

data ForthError = DivisionByZero
                | StackUnderflow
                | InvalidWord
                | UnknownWord String
                deriving (Show, Eq)

data ForthState = FS [Int] (M.Map String String)
  deriving (Show, Eq)

emptyState :: ForthState
emptyState = FS [] M.empty

evalText :: String -> ForthState -> Either ForthError ForthState
evalText = eval . words . map toLower

eval :: [String] -> ForthState -> Either ForthError ForthState
eval (op : ops) fs@(FS _ defs)
  | op `M.member` defs = eval (words (defs M.! op)) fs >>= eval ops
  | op == "+"          = add fs >>= eval ops
  | op == "-"          = sub fs >>= eval ops
  | op == "*"          = mul fs >>= eval ops
  | op == "/"          = div' fs >>= eval ops
  | op == "dup"        = dup fs >>= eval ops
  | op == "drop"       = drop' fs >>= eval ops
  | op == "swap"       = swap fs >>= eval ops
  | op == "over"       = over fs >>= eval ops
  | all isDigit op     = push (read op) fs >>= eval ops
  | op == ":" = define (definition ++ take 1 remain) fs >>= eval (drop 1 remain)
  | otherwise          = Left (UnknownWord op)
  where (definition, remain) = break (`elem` [";", ":"]) ops
eval _ fs = Right fs

toList :: ForthState -> [Int]
toList (FS xs _) = reverse xs

define :: [String] -> ForthState -> Either ForthError ForthState
define (op : ops) (FS xs defs)
  | all isDigit op || null ops' || last ops /= ";" = Left InvalidWord
  | isNothing unknown = Right (FS xs (M.insert op definition defs))
  | otherwise         = Left (UnknownWord (fromJust unknown))
 where
  operations = ["+", "-", "*", "/", "dup", "drop", "swap", "over"]
  ops'       = init ops
  f x = x `notElem` operations ++ M.keys defs && any (not . isDigit) x
  g x = M.findWithDefault x x defs
  unknown    = find f ops'
  definition = unwords (map g ops')
define _ _ = Left InvalidWord

dup :: ForthState -> Either ForthError ForthState
dup (FS xs@(x : _) defs) = Right (FS (x : xs) defs)
dup _                    = Left StackUnderflow

drop' :: ForthState -> Either ForthError ForthState
drop' (FS (_ : xs) defs) = Right (FS xs defs)
drop' _                  = Left StackUnderflow

swap :: ForthState -> Either ForthError ForthState
swap (FS (x : y : xs) defs) = Right (FS (y : x : xs) defs)
swap _                      = Left StackUnderflow

over :: ForthState -> Either ForthError ForthState
over (FS xs@(_ : x : _) defs) = Right (FS (x : xs) defs)
over _                        = Left StackUnderflow

add :: ForthState -> Either ForthError ForthState
add (FS (x : y : xs) defs) = Right (FS (y + x : xs) defs)
add _                      = Left StackUnderflow

sub :: ForthState -> Either ForthError ForthState
sub (FS (x : y : xs) defs) = Right (FS (y - x : xs) defs)
sub _                      = Left StackUnderflow

mul :: ForthState -> Either ForthError ForthState
mul (FS (x : y : xs) defs) = Right (FS (y * x : xs) defs)
mul _                      = Left StackUnderflow

div' :: ForthState -> Either ForthError ForthState
div' (FS (x : y : xs) defs) | x /= 0    = Right (FS (y `div` x : xs) defs)
                            | otherwise = Left DivisionByZero
div' _ = Left StackUnderflow

push :: Int -> ForthState -> Either ForthError ForthState
push x (FS xs defs) = Right (FS (x : xs) defs)
