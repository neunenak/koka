-----------------------------------------------------------------------------
-- Copyright 2012 Microsoft Corporation.
--
-- This is free software; you can redistribute it and/or modify it under the
-- terms of the Apache License, Version 2.0. A copy of the License can be
-- found in the file "license.txt" at the root of this distribution.
-----------------------------------------------------------------------------
{-
    Common syntactical constructs (for Syntax.Syntax and Core.Core)
-}
-----------------------------------------------------------------------------
module Common.Syntax( Visibility(..)
                    , Assoc(..)
                    , Fixity(..)
                    , DataKind(..)
                    , DefSort(..), isDefFun, defFun
                    , DefInline(..)
                    , Target(..)
                    , Host(..)
                    , isPublic, isPrivate
                    , DataDef(..)
                    , dataDefIsRec, dataDefIsOpen
                    , HandlerSort(..)
                    , isHandlerResource, isHandlerNormal
                    ) where

{--------------------------------------------------------------------------
  Backend targets
--------------------------------------------------------------------------}
data Target = CS | JS | Default deriving (Eq,Ord)

instance Show Target where
  show CS = "cs"
  show JS = "js"
  show Default = ""

data Host = Node | Browser deriving (Eq,Ord)

instance Show Host where
  show Node = "node"
  show Browser = "browser"


{--------------------------------------------------------------------------
  Visibility
--------------------------------------------------------------------------}
data Visibility = Public | Private
                deriving (Eq,Ord,Show)

isPublic Public = True
isPublic _      = False

isPrivate Private = True
isPrivate _       = False


data HandlerSort e
  = HandlerNormal | HandlerResource (Maybe e)
  deriving (Eq)

instance Show (HandlerSort e) where
  show hsort = case hsort of
                 HandlerNormal -> "Normal"
                 HandlerResource Nothing -> "FreshResource"
                 HandlerResource _       -> "Resource"

isHandlerResource (HandlerResource _) = True
isHandlerResource _ = False

isHandlerNormal (HandlerNormal) = True
isHandlerNormal _ = False


{--------------------------------------------------------------------------
  DataKind
--------------------------------------------------------------------------}
data DataKind = Inductive | CoInductive | Retractive
              deriving (Eq)

instance Show DataKind where
  show Inductive = "type"
  show CoInductive = "cotype"
  show Retractive = "rectype"

data DataDef = DataDefNormal | DataDefRec | DataDefOpen
             deriving Eq


dataDefIsRec ddef
  = case ddef of
      DataDefNormal -> False
      _  -> True

dataDefIsOpen ddef
  = case ddef of
      DataDefOpen -> True
      _ -> False


{--------------------------------------------------------------------------
  Definition kind
--------------------------------------------------------------------------}

data DefSort
  = DefFun | DefVal | DefVar
  deriving (Eq,Ord)

isDefFun (DefFun )  = True
isDefFun _          = False

defFun :: DefSort
defFun = DefFun

instance Show DefSort where
  show ds = case ds of
              DefFun -> "fun"
              DefVal -> "val"
              DefVar -> "var"


data DefInline
  = InlineNever | InlineAlways | InlineAuto
  deriving (Eq,Ord)

instance Show DefInline where
  show di = case di of
              InlineNever  -> "noinline"
              InlineAlways -> "inline"
              InlineAuto   -> "autoinline"

{--------------------------------------------------------------------------
  Fixities
--------------------------------------------------------------------------}

-- | Operator fixity
data Fixity = FixInfix  Int Assoc -- ^ precedence and associativity
            | FixPrefix
            | FixPostfix
            deriving (Eq,Show)

-- | Operator associativity
data Assoc  = AssocNone
            | AssocRight
            | AssocLeft
            deriving (Eq,Show)
