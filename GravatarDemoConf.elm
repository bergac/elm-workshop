module GravatarDemo exposing (main)

import Css exposing (..)
import Css.Foreign
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)
import Html.Styled.Events exposing (..)
import Http
import Json.Decode exposing (Decoder, at, field, int, map4, string)
import Json.Decode.Pipeline exposing (..)
import MD5


-- https://ellie-app.com/mhQ5h5wZZsa1


main =
    Html.program
        { init = init
        , view = view >> toUnstyled
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias SpeakerRecord =
    { displayName : String
    , aboutMe : String
    , currentLocation : String
    , thumbnailUrl : String
    }


type alias Model =
    { newSpeakerEmail : String
    , speakers : List SpeakerRecord
    }


init : ( Model, Cmd Msg )
init =
    ( Model "" [], Cmd.none )



-- UPDATE


type Msg
    = SpeakerEmail String
    | AddSpeaker
    | GravatarSpeaker (Result Http.Error SpeakerRecord)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SpeakerEmail newEmail ->
            ( { model | newSpeakerEmail = newEmail }, Cmd.none )

        AddSpeaker ->
            ( model, getGravatarSpeaker model.newSpeakerEmail )

        GravatarSpeaker (Ok addedSpeaker) ->
            ( { model | speakers = addedSpeaker :: model.speakers }
            , Cmd.none
            )

        GravatarSpeaker (Err _) ->
            ( model, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    page []
        [ h2 [] [ text "Add speaker for conference" ]
        , input [ placeholder "Email address speaker", onInput SpeakerEmail ] []
        , button [ class "buttonAdd", onClick AddSpeaker ] [ text "Add Speaker" ]
        , br [] []
        , img [ src (createIconUrl model.newSpeakerEmail) ] []
        , div [] [ toHtmlImgList model.speakers ]
        ]


toHtmlImgList : List SpeakerRecord -> Html Msg
toHtmlImgList speakers =
    ul [] (List.map toLiImg speakers)


toLiImg : SpeakerRecord -> Html Msg
toLiImg speaker =
    li []
        [ img [ src speaker.thumbnailUrl ] []
        , p [] [ text ("Username: " ++ speaker.displayName) ]
        , p [] [ text ("About: " ++ speaker.aboutMe) ]
        , p [] [ text ("Current location: " ++ speaker.currentLocation) ]
        ]



-- SUBSCRIPTIONS
{--subscriptions can be used to listen to external input.
    The code below doesn't listen to anything however.
    We need it for this program, since we need the `init` function,
    which comes with Html.program.
--}


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- HTTP


getGravatarSpeaker : String -> Cmd Msg
getGravatarSpeaker newSpeakerEmail =
    Http.send GravatarSpeaker
        (Http.get (createProfileUrl newSpeakerEmail) decodeGravatarResponse)


createProfileUrl : String -> String
createProfileUrl email =
    "https://cors-anywhere.herokuapp.com/https://en.gravatar.com/" ++ MD5.hex email ++ ".json"



--    "https://crossorigin.me/https://en.gravatar.com/" ++ MD5.hex email ++ ".json"


createIconUrl : String -> String
createIconUrl email =
    "https://www.gravatar.com/avatar/" ++ MD5.hex email


decodeGravatarResponse : Decoder SpeakerRecord
decodeGravatarResponse =
    let
        speakerDecoder =
            Json.Decode.Pipeline.decode SpeakerRecord
                |> Json.Decode.Pipeline.required "displayName" string
                |> Json.Decode.Pipeline.optional "aboutMe" string "unknown"
                |> Json.Decode.Pipeline.optional "currentLocation" string "unknown"
                |> Json.Decode.Pipeline.required "thumbnailUrl" string
    in
    at [ "entry", "0" ] speakerDecoder



-- styling


page : List (Attribute msg) -> List (Html msg) -> Html msg
page attributes children =
    styled div
        [ padding (pct 2) ]
        attributes
        (style1 :: children)


style1 =
    Css.Foreign.global
        [ Css.Foreign.body
            [ margin4 (Css.rem 3) (Css.rem 0) (Css.rem 0) (Css.rem 3)
            , fontFamilies [ "Arial", "Sans Sherif", "Helvetica" ]
            , fontSize (px 13)
            , color (hex "1C1C1C")
            ]
        , Css.Foreign.header
            [ marginBottom (Css.rem 1)
            ]
        , Css.Foreign.h2
            [ color (hex "000000")
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
            , display inline
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
