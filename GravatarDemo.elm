module GravatarDemo exposing (main)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode exposing (Decoder, at, field, int, map4, string)
import Json.Decode.Pipeline exposing (..)
import MD5


-- https://ellie-app.com/p6ywbwW2Wa1/1


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias MentorRecord =
    { displayName : String
    , aboutMe : String
    , currentLocation : String
    , thumbnailUrl : String
    }


type alias Model =
    { newMentorEmail : String
    , mentors : List MentorRecord
    }


init : ( Model, Cmd Msg )
init =
    ( Model "" [], Cmd.none )



-- UPDATE


type Msg
    = MentorEmail String
    | AddMentor
    | GravatarMentor (Result Http.Error MentorRecord)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MentorEmail newEmail ->
            ( { model | newMentorEmail = newEmail }, Cmd.none )

        AddMentor ->
            ( model, getGravatarMentor model.newMentorEmail )

        GravatarMentor (Ok addedMentor) ->
            ( { model | mentors = addedMentor :: model.mentors }
            , Cmd.none
            )

        GravatarMentor (Err _) ->
            ( model, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ h2 [] [ text "Add mentors to guide you through your JCore experience" ]
        , input [ placeholder "Email adress mentor", onInput MentorEmail ] []
        , button [ class "button-add", onClick AddMentor ] [ text "Add Mentor" ]
        , br [] []
        , img [ src (createIconUrl model.newMentorEmail) ] []
        , div [] [ toHtmlImgList model.mentors ]
        ]


toHtmlImgList : List MentorRecord -> Html Msg
toHtmlImgList mentors =
    ul [] (List.map toLiImg mentors)


toLiImg : MentorRecord -> Html Msg
toLiImg mentor =
    li []
        [ img [ src mentor.thumbnailUrl ] []
        , p [] [ text ("Gebruikersnaam: " ++ mentor.displayName) ]
        , p [] [ text ("Over mijzelf: " ++ mentor.aboutMe) ]
        , p [] [ text ("Huidige locatie: " ++ mentor.currentLocation) ]
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


getGravatarMentor : String -> Cmd Msg
getGravatarMentor newMentorEmail =
    Http.send GravatarMentor
        (Http.get (createProfileUrl newMentorEmail) decodeGravatarResponse)


createProfileUrl : String -> String
createProfileUrl email =
    "https://crossorigin.me/https://en.gravatar.com/" ++ MD5.hex email ++ ".json"


createIconUrl : String -> String
createIconUrl email =
    "https://www.gravatar.com/avatar/" ++ MD5.hex email


decodeGravatarResponse : Decoder MentorRecord
decodeGravatarResponse =
    let
        mentorDecoder =
            Json.Decode.Pipeline.decode MentorRecord
                |> Json.Decode.Pipeline.required "displayName" string
                |> Json.Decode.Pipeline.optional "aboutMe" string "onbekend"
                |> Json.Decode.Pipeline.optional "currentLocation" string "onbekend"
                |> Json.Decode.Pipeline.required "thumbnailUrl" string
    in
    at [ "entry", "0" ] mentorDecoder
