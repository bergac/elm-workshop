module CounterDemo exposing (main)

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
    | Reset


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            model + 1

        Decrement ->
            Basics.max (model - 1) 0

        Reset ->
            0



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
        , Css.Foreign.h2
            [ textAlign center
            , color (hex "000000")
            ]
        , Css.Foreign.button
            [ margin (Css.rem 1)
            , display inlineBlock
            , Css.height (Css.rem 2)
            , border3 (px 1) solid (hex "1C1C1C")
            , borderRadius (px 5)
            ]
        ]
