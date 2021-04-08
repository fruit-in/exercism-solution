module Sgf
  ( parseSgf
  ) where

import           Control.Monad                  ( liftM2 )
import           Data.List                      ( foldl' )
import           Data.Map                       ( Map
                                                , fromList
                                                )
import           Data.Maybe                     ( fromJust
                                                , isJust
                                                )
import           Data.Tree                      ( Tree(Node) )
import           Text.Parsec                    ( (<|>)
                                                , Parsec
                                                , anyChar
                                                , char
                                                , many
                                                , many1
                                                , oneOf
                                                , optionMaybe
                                                , parse
                                                , satisfy
                                                , upper
                                                )

type SgfTree = Tree SgfNode
type SgfNode = Map String [String]

parseSgf :: String -> Maybe SgfTree
parseSgf = eitherToMaybe . parse parser ""
 where
  eitherToMaybe (Left  _) = Nothing
  eitherToMaybe (Right x) = Just x

parser :: Parsec String () SgfTree
parser = do
  _        <- char '('
  (x : xs) <- many1 properties
  children <- optionMaybe (many parser)
  _        <- char ')'
  let tree = foldl' insert (toTree x) xs
  if isJust children
    then return (insertChildren tree (fromJust children))
    else return tree
 where
  toTree = flip Node []
  insert (Node label sub) node = Node label (toTree node : sub)
  insertChildren (Node label sub) trees = Node label (trees ++ sub)

properties :: Parsec String () SgfNode
properties = char ';' >> (fromList <$> many property)

property :: Parsec String () (String, [String])
property = liftM2 (\a b -> (a, b)) (many1 upper) (many1 value)

value :: Parsec String () String
value = do
  _ <- char '['
  v <- many (escape <|> satisfy (/= ']'))
  _ <- char ']'
  return (filter (/= '\n') v)

escape :: Parsec String () Char
escape = (char '\\' >> anyChar) <|> (oneOf "\n\t" >> return ' ')
