module BankAccount
  ( BankAccount
  , closeAccount
  , getBalance
  , incrementBalance
  , openAccount
  ) where

import           GHC.Conc                       ( TVar
                                                , atomically
                                                , newTVarIO
                                                , readTVar
                                                , readTVarIO
                                                , writeTVar
                                                )

type BankAccount = TVar (Maybe Integer)

closeAccount :: BankAccount -> IO ()
closeAccount = atomically . flip writeTVar Nothing

getBalance :: BankAccount -> IO (Maybe Integer)
getBalance = readTVarIO

incrementBalance :: BankAccount -> Integer -> IO (Maybe Integer)
incrementBalance account amount = atomically $ do
  balance <- fmap (amount +) <$> readTVar account
  writeTVar account balance
  return balance

openAccount :: IO BankAccount
openAccount = newTVarIO (Just 0)
