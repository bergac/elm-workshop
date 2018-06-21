module Main exposing (..)

import Char exposing (isDigit, isLower, isUpper)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)


-- https://ellie-app.com/z2vtH4dZ8wa1


main =
    Html.beginnerProgram { model = model, view = view, update = update }



-- MODEL


type alias ValidationMessage =
    { color : String
    , message : String
    }


type alias Model =
    { name : String
    , password : String
    , passwordAgain : String
    , validation : ValidationMessage
    }


model : Model
model =
    Model "" "" "" (ValidationMessage "black" "")


setValidation : ValidationMessage -> Model -> Model
setValidation newValidation model =
    { model | validation = newValidation }



-- UPDATE


type Msg
    = Name String
    | Password String
    | PasswordAgain String
    | Validate


update : Msg -> Model -> Model
update msg model =
    case msg of
        Name name ->
            { model | name = name }

        Password password ->
            { model | password = password }

        PasswordAgain password ->
            { model | passwordAgain = password }

        Validate ->
            doValidation model


doValidation : Model -> Model
doValidation model =
    if String.isEmpty model.name then
        setValidation { color = "red", message = "Name should not be empty" } model
    else if String.isEmpty model.password then
        setValidation { color = "red", message = "Password should not be empty" } model
    else if String.isEmpty model.passwordAgain then
        setValidation { color = "red", message = "Password Again should not be empty" } model
    else if String.length model.password < 8 then
        setValidation { color = "red", message = "Password should consist of 8 characters or more" } model
    else if not (String.any isDigit model.password) then
        setValidation { color = "red", message = "Password should contain digits" } model
    else if not (String.any isUpper model.password) then
        setValidation { color = "red", message = "Password should contain upper characters" } model
    else if not (String.any isLower model.password) then
        setValidation { color = "red", message = "Password should contain lower characters" } model
    else if model.password /= model.passwordAgain then
        setValidation { color = "red", message = "Passwords should match" } model
    else
        setValidation { color = "green", message = "OK" } model



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ input [ type_ "text", placeholder "Name", onInput Name ] []
        , input [ type_ "password", placeholder "Password", onInput Password ] []
        , input [ type_ "password", placeholder "Re-enter Password", onInput PasswordAgain ] []
        , viewValidation model
        , button [ onClick Validate ] [ text "Validate" ]
        , div [ style [ ( "color", model.validation.color ) ] ] [ text ("Validated via button click: " ++ model.validation.message) ]
        ]


viewValidation : Model -> Html Msg
viewValidation model =
    let
        ( color, message ) =
            if not (String.isEmpty model.name) && not (String.isEmpty model.password) && not (String.isEmpty model.passwordAgain) then
                if String.length model.password < 8 then
                    ( "red", "Password should consist of 8 characters or more" )
                else if not (String.any isDigit model.password) then
                    ( "red", "Password should contain digits" )
                else if not (String.any isUpper model.password) then
                    ( "red", "Password should contain upper characters" )
                else if not (String.any isLower model.password) then
                    ( "red", "Password should contain lower characters" )
                else if model.password /= model.passwordAgain then
                    ( "red", "Passwords should match" )
                else
                    ( "green", "OK" )
            else
                ( "black", "" )
    in
    div [ style [ ( "color", color ) ] ] [ text ("Validated onInput: " ++ message) ]
