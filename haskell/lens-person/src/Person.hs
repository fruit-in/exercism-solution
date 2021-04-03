module Person
  ( Address(..)
  , Born(..)
  , Name(..)
  , Person(..)
  , bornStreet
  , renameStreets
  , setBirthMonth
  , setCurrentStreet
  ) where

import           Data.Time.Calendar             ( Day
                                                , fromGregorian
                                                , toGregorian
                                                )

data Person = Person
  { _name    :: Name
  , _born    :: Born
  , _address :: Address
  }

data Name = Name
  { _foreNames :: String
  , _surName   :: String
  }

data Born = Born
  { _bornAt :: Address
  , _bornOn :: Day
  }

data Address = Address
  { _street      :: String
  , _houseNumber :: Int
  , _place       :: String
  , _country     :: String
  }

bornStreet :: Born -> String
bornStreet = _street . _bornAt

setCurrentStreet :: String -> Person -> Person
setCurrentStreet street (Person name born address) = Person
  name
  born
  (setCurrentStreet' address)
 where
  setCurrentStreet' (Address street' houseNumber place country) =
    Address street houseNumber place country

setBirthMonth :: Int -> Person -> Person
setBirthMonth month (Person name born address) = Person name
                                                        (setBirthMonth' born)
                                                        address
 where
  (year, month', day) = toGregorian (_bornOn born)
  setBirthMonth' (Born bornAt bornOn) =
    Born bornAt (fromGregorian year month day)

renameStreets :: (String -> String) -> Person -> Person
renameStreets f (Person name (Born bornAt bornOn) address) = Person
  name
  (Born (renameStreets' bornAt) bornOn)
  (renameStreets' address)
 where
  renameStreets' (Address street houseNumber place country) =
    Address (f street) houseNumber place country
