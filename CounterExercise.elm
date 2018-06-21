module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


-- https://ellie-app.com/z2qFJn5bZ8a1


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
    = AddFastTrackSession
    | RemoveFastTrackSession



{-
   TODO 2: Add a new Reset case
   TODO 4: Prevent RemoveFastTrackSession from going below 0
   TODO 5: Build new cases or add new functionality for a counter (e.g. +2 or -10)
-}


update : Msg -> Model -> Model
update msg model =
    case msg of
        AddFastTrackSession ->
            model + 1

        RemoveFastTrackSession ->
            model - 1



-- VIEW
{-
   TODO 3: Add a new button which will trigger the reset action on click
-}


view : Model -> Html Msg
view model =
    div [ class "container" ]
        [ div [ class "button-container" ]
            [ button [ class "button-remove", onClick RemoveFastTrackSession ] [ text "Remove Fast Track Session" ]
            , button [ class "button-add", onClick AddFastTrackSession ] [ text "Add Fast Track Session" ]
            ]
        , div [ class "counter-container" ]
            [ span [ class "fast-track-counter" ] [ text (toString model) ]
            , span [ class "fast-track-counter-label" ] [ text " Fast Track Sessions Planned" ]
            ]
        ]
