module SelectTwo.Types exposing (..)

{-| SelectTwo Types


# Types

@docs SelectTwoMsg, Model, SelectTwoConfig, AjaxParams, GroupSelectTwoOption, SelectTwoOption, SelectTwo, SelectTwoDropdown, SelectTwoAjaxStuff, ScrollInfo

-}

import Dom
import Http
import Html exposing (Html)


{-| Command Messages for SelectTwo
-}
type SelectTwoMsg a
    = SelectTwoTrigger (List String) (SelectTwoDropdown a)
    | SelectTwoHovered (Maybe a)
    | SelectTwoSelected (Maybe a)
    | SetSelectTwoSearch String
    | DelayedSelectTwoAjax String
    | SelectTwoAjax (SelectTwoAjaxStuff a) (Result Http.Error String)
    | STRes (Result Dom.Error ())
    | STMsg a
    | STNull
    | ResultScroll ScrollInfo


{-| Model structure needed for selectTwo
-}
type alias Model b a =
    { b | selectTwo : Maybe (SelectTwo a) }


{-| Config for SelectTwo
-}
type alias SelectTwoConfig a =
    { defaults : List (SelectTwoOption a)
    , id_ : String
    , list : List (GroupSelectTwoOption a)
    , parents : List String
    , url : Maybe String
    , data : ( String, AjaxParams ) -> String
    , processResults : ( String, AjaxParams ) -> ( List (GroupSelectTwoOption a), AjaxParams )
    , clearMsg : Maybe (Maybe a -> a)
    , showSearch : Bool
    , width : String
    , placeholder : String
    , disabled : Bool
    , multiSelect : Bool
    , delay : Float
    }


{-| Parameters used in ajax calls
-}
type alias AjaxParams =
    { page : Int
    , term : String
    , more : Bool
    , loading : Bool
    }


{-| Grouped SelectTwoOption
-}
type alias GroupSelectTwoOption a =
    ( String, List (SelectTwoOption a) )


{-| Rows in a select table
-}
type alias SelectTwoOption a =
    ( Maybe a, Html a, String )


{-| Structure created in users model when select2 is activated
-}
type alias SelectTwo a =
    { dropdown : SelectTwoDropdown a
    , hovered : Maybe a
    , search : Maybe String
    , parents : List String
    , list : Maybe (List (GroupSelectTwoOption a))
    , ajaxStuff : Maybe (SelectTwoAjaxStuff a)
    }


{-| Data to generate the dropdown
-}
type alias SelectTwoDropdown a =
    { id_ : String
    , sender : SelectTwoMsg a -> a
    , defaults : List (SelectTwoOption a)
    , list : List (GroupSelectTwoOption a)
    , showSearch : Bool
    , x : Float
    , y : Float
    , width : Float
    , ajaxStuff : Maybe (SelectTwoAjaxStuff a)
    , delay : Float
    }


{-| Things needed to make Ajax calls
-}
type alias SelectTwoAjaxStuff a =
    ( String, ( String, AjaxParams ) -> String, ( String, AjaxParams ) -> ( List (GroupSelectTwoOption a), AjaxParams ), AjaxParams )


{-| Information coming from scroll events
-}
type alias ScrollInfo =
    { scrollHeight : Int
    , scrollTop : Int
    }
