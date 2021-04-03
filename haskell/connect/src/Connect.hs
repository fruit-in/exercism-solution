module Connect
  ( Mark(..)
  , winner
  ) where

import           Data.Char                      ( isSpace )
import           Data.List                      ( transpose )
import qualified Data.Set                      as S

data Mark = Cross
          | Nought
  deriving (Eq, Show)

winner :: [String] -> Maybe Mark
winner board | leftToRight 'X' board'             = Just Cross
             | leftToRight 'O' (transpose board') = Just Nought
             | otherwise                          = Nothing
  where board' = map (filter (not . isSpace)) board

leftToRight :: Char -> [String] -> Bool
leftToRight _ []   = False
leftToRight _ [[]] = False
leftToRight x xss  = thd (until f g (positions, checked, False))
 where
  thd (_, _, c) = c
  rows      = length xss
  cols      = length (head xss)
  positions = [ (r, 0) | r <- [0 .. rows - 1], xss !! r !! 0 == x ]
  checked   = S.fromList positions
  f (ys, _, flag) = null ys || flag
  g ((r, c) : ys, zs, _) = (ys', zs', c == cols - 1)
   where
    (ys', zs') =
      foldr h (ys, zs) [(-1, 1), (-1, 0), (0, -1), (0, 1), (1, -1), (1, 0)]
    h (i, j) (ys'', zs'')
      | r'
        `elem`        [0 .. rows - 1]
        &&            c'
        `elem`        [0 .. cols - 1]
        &&            xss
        !!            r'
        !!            c'
        ==            x
        &&            (r', c')
        `S.notMember` zs''
      = ((r', c') : ys'', S.insert (r', c') zs'')
      | otherwise
      = (ys'', zs'')
     where
      r' = r + i
      c' = c + j
