module Main exposing (..)

{-
   TODO 1: Import the onBlur event listener
-}

import Browser
import Html exposing (Html, div, input, li, text, ul)
import Html.Attributes exposing (placeholder)
import Html.Events exposing (onInput)


main =
    Browser.sandbox { init = init, update = update, view = view }



-- MODEL
{-
   TODO 2: Add a type to the model to store the line to print
   Hint: Elm has generics. A list containing string is written as: List String
-}


type alias Model =
    { content : String
    , stack : List String
    }



{-
   The model already contains the content, which is the actual content of the input field.
   TODO 3: Add the initial value for the line to print
-}


init : Model
init =
    { content = ""
    , stack = []
    }



-- UPDATE
{-
   TODO 4: Add a new action for updating the stored lines.
-}


type Msg
    = Change String



{-
   TODO 5: Add a new case to the model for storing the lines
-}


update : Msg -> Model -> Model
update msg model =
    case msg of
        Change newContent ->
            { model | content = newContent }



-- VIEW
{-
   TODO 6: Add the onBlur handler to the input which should fire the created action in TODO 4.
   TODO 7: Add the new html below Html.br to display the new value from the model created in TODO 1.
-}


view : Model -> Html Msg
view model =
    div []
        [ input [ placeholder "Text to reverse", onInput Change ] []
        , div [] [ text (String.reverse model.content) ]
        , Html.br [] []
        , div [] [ text "list of strings go down here:" ]
        , div [] []
        ]



{--functions you could use to show your --}


toHtmlList : List String -> Html msg
toHtmlList strings =
    ul [] (List.map toLi strings)


toLi : String -> Html msg
toLi s =
    li [] [ text s ]
