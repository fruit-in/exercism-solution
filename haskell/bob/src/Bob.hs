module Bob
  ( responseFor
  ) where

import           Data.Char                      ( isLower
                                                , isSpace
                                                , isUpper
                                                )
import           Data.String.Utils              ( endswith
                                                , rstrip
                                                )

responseFor :: String -> String
responseFor xs | isQuestion && not isYell = "Sure."
               | not isQuestion && isYell = "Whoa, chill out!"
               | isQuestion && isYell     = "Calm down, I know what I'm doing!"
               | isSayNothing             = "Fine. Be that way!"
               | otherwise                = "Whatever."
 where
  isQuestion   = endswith "?" (rstrip xs)
  isYell       = any isUpper xs && not (any isLower xs)
  isSayNothing = all isSpace xs
