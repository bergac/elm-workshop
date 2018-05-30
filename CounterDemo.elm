module Main exposing (..)

import Css exposing (..)
import Css.Foreign
import Html exposing (beginnerProgram)
import Html.Styled exposing (Attribute, Html, br, button, div, h2, img, styled, text, toUnstyled)
import Html.Styled.Attributes exposing (..)
import Html.Styled.Events exposing (onClick)


main =
    Html.beginnerProgram
        { model = model
        , view = view >> toUnstyled
        , update = update
        }



-- MODEL


type alias Model =
    Int


model : Model
model =
    0



-- UPDATE


type Msg
    = Increment
    | Decrement
    | Square
    | Reset


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            model + 1

        Decrement ->
            Basics.max (model - 1) 0

        Square ->
            model * model

        Reset ->
            0


increment : Int -> Int
increment a =
    a + 1



-- VIEW


view : Model -> Html Msg
view model =
    page []
        [ h2 [] [ text "Count of yawns in the room" ]
        , img [ src "https://media.giphy.com/media/j6Uls25PT5Q4g/giphy.gif" ] []
        , br [] []
        , div [] [ text ("Count: " ++ toString model) ]
        , button [ onClick Decrement ] [ text "-" ]
        , button [ onClick Increment ] [ text "+" ]
        , button [ onClick Square ] [ text "*" ]
        , br [] []
        , button [ onClick Reset ] [ text "reset" ]
        ]



-- CSS


page : List (Attribute msg) -> List (Html msg) -> Html msg
page attributes children =
    styled div
        [ padding (pct 2) ]
        attributes
        (style1 :: children)


style1 =
    Css.Foreign.global
        [ Css.Foreign.body
            [ Css.width (px 500)
            , margin2 (px 0) auto
            , fontFamilies [ "Arial", "Sans Sherif", "Helvetica" ]
            , fontSize (px 13)
            , color (hex "1C1C1C")
            , textAlign center
            ]
        , Css.Foreign.header
            [ marginBottom (Css.rem 1)
            ]
        , Css.Foreign.h2
            [ textAlign center
            , color (hex "000000")
            ]
        , Css.Foreign.input
            [ display inline
            , marginBottom (Css.rem 1)
            , padding (Css.rem 0.2)
            , Css.height (Css.rem 2)
            , border3 (Css.px 1) solid (hex "1C1C1C")
            , borderRadius (Css.px 5)
            , Css.width (pct 50)
            ]
        , Css.Foreign.button
            [ margin (Css.rem 1)
            , display inlineBlock
            , Css.height (Css.rem 2)
            , border3 (px 1) solid (hex "1C1C1C")
            , borderRadius (px 5)
            ]
        , Css.Foreign.class "buttonAdd"
            [ backgroundColor (hex "c8e782")
            ]
        , Css.Foreign.ul
            [ marginTop (Css.rem 1)
            , padding (px 0)
            ]
        , Css.Foreign.li
            [ marginBottom (Css.rem 1)
            , padding (Css.rem 1)
            , listStyleType none
            , border3 (px 1) solid (hex "000000")
            ]
        ]
