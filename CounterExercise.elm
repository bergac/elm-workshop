module Main exposing (..)

import Browser
import Html exposing (Html, button, div, span, text)
import Html.Events exposing (onClick)


main =
    Browser.sandbox { init = 0, update = update, view = view }



-- UPDATE
{-
   TODO 1: Add a new Reset Msg option
-}


type Msg
    = Increment
    | Decrement



{-
   TODO 2: Add a new Reset case
   TODO 4: Prevent Decrement from going below 0
   TODO 5: Build new cases or add new functionality for a counter (e.g. +2 or -10)
-}


update : Msg -> Int -> Int
update msg model =
    case msg of
        Increment ->
            model + 1

        Decrement ->
            model - 1



-- VIEW
{-
   TODO 3: Add a new button which will trigger the reset action on click
-}


view : Int -> Html Msg
view model =
    div []
        [ div []
            [ button [ onClick Decrement ] [ text "-1" ]
            , button [ onClick Increment ] [ text "+1" ]
            ]
        , div []
            [ span [] [ text "Counter: " ]
            , span [] [ text (String.fromInt model) ]
            ]
        ]
