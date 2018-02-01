module Main exposing (..)

import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)


main =
    Html.beginnerProgram { model = model, view = view, update = update }



-- MODEL


type alias Model =
    Int


model : Model
model =
    0



-- UPDATE
{-
   TODO 1: Add a new Reset Msg option
-}


type Msg
    = Increment
    | Decrement
    | Square
    | Reset



{-
   TODO 2: Add a new Reset case
   TODO 4: Prevent Decrement from going below 0
   TODO 5: Build new cases or add new functionality for a counter (e.g. +2 or -10)
-}


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            model + 1

        Decrement ->
            max (model - 1) 0

        Square ->
            model * model

        Reset ->
            0



-- VIEW
{-
   TODO 3: Add a new button which will trigger the reset action on click
-}


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick Decrement ] [ text "-" ]
        , div [] [ text (toString model) ]
        , button [ onClick Increment ] [ text "+" ]
        , button [ onClick Square ] [ text "*" ]
        , Html.br [] []
        , button [ onClick Reset ] [ text "reset" ]
        ]
