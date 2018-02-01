module Main exposing (..)

{-
   TODO 1: Import the onBlur event listener
-}

import Html exposing (Attribute, Html, div, input, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onBlur, onInput)


main =
    Html.beginnerProgram { model = model, view = view, update = update }



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


model : Model
model =
    { content = ""
    , stack = []
    }



-- UPDATE
{-
   TODO 4: Add a new action for updating the stored lines.
-}


type Msg
    = Change String
    | Store



{-
   TODO 5: Add a new case to the model for storing the lines
-}


update : Msg -> Model -> Model
update msg model =
    case msg of
        Change newContent ->
            { model | content = newContent }

        Store ->
            { model
                | stack = String.reverse model.content :: model.stack
                , content = ""
            }



-- VIEW
{-
   TODO 6: Add the onBlur handler to the input which should fire the created action in TODO 4.
   TODO 7: Add the new html to display the new value from the model created in TODO 1.
-}


view : Model -> Html Msg
view model =
    div []
        [ input [ placeholder "Text to reverse", onBlur Store, onInput Change ] []
        , div [] [ text (String.reverse model.content) ]
        , Html.br [] []
        , div [] [ text "Stack:" ]
        , div [] [ text (toString model.stack) ]
        ]
