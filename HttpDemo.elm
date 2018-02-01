module HttpDemo exposing (main)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode as Decode


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { gifUrl : String
    }


init : ( Model, Cmd Msg )
init =
    ( Model ""
    , getRandomGif
    )



-- UPDATE


type Msg
    = OtherGif
    | NewGif (Result Http.Error String)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OtherGif ->
            ( model, getRandomGif )

        NewGif (Ok newUrl) ->
            ( Model newUrl, Cmd.none )

        NewGif (Err _) ->
            ( model, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick OtherGif ] [ text "Boring, another one please!" ]
        , br [] []
        , img [ src model.gifUrl ] []
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


getRandomGif : Cmd Msg
getRandomGif =
    Http.send NewGif
        (Http.get "https://api.giphy.com/v1/gifs/random?api_key=eIzOZ4lOP99QNtjfdCghYgwV3rjfgYuG" decodeGifUrl)


decodeGifUrl : Decode.Decoder String
decodeGifUrl =
    Decode.at [ "data", "image_url" ] Decode.string
