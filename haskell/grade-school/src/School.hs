module School
  ( School
  , add
  , empty
  , grade
  , sorted
  ) where

import           Data.Composition               ( (.:) )
import           Data.List                      ( sort )
import qualified Data.Map                      as M

type Grade = Int
type Student = String
type School = M.Map Grade [Student]

add :: Grade -> Student -> School -> School
add gradeNum student = M.insertWith (sort .: (++)) gradeNum [student]

empty :: School
empty = M.empty

grade :: Grade -> School -> [Student]
grade = M.findWithDefault []

sorted :: School -> [(Grade, [Student])]
sorted = M.toAscList
