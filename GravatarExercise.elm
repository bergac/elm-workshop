module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode exposing (Decoder, at, field, int, map4, string)
import Json.Decode.Pipeline exposing (..)
import MD5


main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }



-- MODEL
{--TODO 1: create a record to store the received user profile from gravatar.
    Save at least the thumbnailUrl and displayName from the response, these are
    required. Add 2 other fields that can be optional.
    See https://en.gravatar.com/5b539801779e61e89ae25afccf0069ff.json for how a
    response could look like.
    Click on compile to check if the code is correct.
--}
{--TODO 2: the user record created in TODO 1 should be saved in a list.
    Add this list to the model. Recall what a list looks like from assignment 2.
--}


type alias Model =
    { newUserEmail : String
    }



{--TODO 3: because you added a list in TODO 2, you need change the initial state
    of the Model too. Add an empty list to the Model: []
    Click on compile to check if the code is correct.
--}


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model "", Cmd.none )



-- UPDATE
{--TODO 4: create a Msg type for clicking on the 'Add user' button.
    Click on compile to check if the code is correct.

    TODO 5: create a Msg type for receiving a httpstatus=200 or httpstatus!=200
    response. It looks something like: GravatarUser (Result Http.Error UserRecord)
    where GravatarUser is the name of the union type and UserRecord is the type
    alias you created in TODO 1.
    A Result is used when something (i.e. HTTP request) could fail.
    See https://guide.elm-lang.org/error_handling/result.html
    Click on compile to check if the code is correct.
--}


type Msg
    = UserEmail String



{--
    TODO 9: add a case for the Msg you created in TODO 4. Remember, when clicking on
    the 'Add User' button, a HTTP GET request should be made to the Gravatar API.
    You already made the function that sends this HTTP request (getGravatarUser).

    TODO 10: create 2 cases for the Msg you created in TODO 5. Remember, either an OK response
    (status=2xx) or an error response are possible.
    An OK response should save the received user profile to the list in the model (see
    http://package.elm-lang.org/packages/elm-lang/core/5.1.1/List#::).
    En error reponse shouldn't have to do anything.
    See https://guide.elm-lang.org/architecture/effects/http.html
    Thereafter, click on compile to check if the code is correct.
--}


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UserEmail newEmail ->
            ( { model | newUserEmail = newEmail }, Cmd.none )



-- VIEW
{--
    TODO 11: add the onClick event to the 'Add User' button, and pass the corresponding
    Msg type as an argument.
    Click on compile to check if the code is correct.

    TODO 14: pass the list of user records to the toHtmlListOfProfiles function.
    Click on compile to check if the code is correct. If so, you're done!
    Fill in your email address.
--}


view : Model -> Html Msg
view model =
    div []
        [ h2 [] [ text "Add users" ]
        , input [ placeholder "Email address user", onInput UserEmail ] []
        , button [] [ text "Add User" ]
        , br [] []
        , img [ src (createIconUrl model.newUserEmail) ] []
        , div []
            [ h3 [] [ text "Users:" ]
            , toHtmlListOfProfiles [ "user1", "user2" ]
            ]
        ]



{--
    TODO 13: Currently, this method takes a List of Strings as argument. Change the
    function definition and implementation so that it takes a list of the record you
    created in TODO 1 (the record with the user profile).
    Click on compile to check if the code is correct.
--}


toHtmlListOfProfiles : List String -> Html Msg
toHtmlListOfProfiles users =
    ul [] (List.map toHtmlProfile users)



{--
    TODO 12: Currently, this method takes a String as argument. Change the
    function definition and implementation so that it takes a record you
    created in TODO 1 (the record with the user profile). Show it's icon first and the
    fields below with a label if you like.
    String concatenation is done by using the ++ operator.
--}


toHtmlProfile : String -> Html Msg
toHtmlProfile user =
    li []
        [ p [] [ text ("Username: " ++ user) ]
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
{--TODO 6: the getGravatarUser function returns Cmd Msg. Whenever Cmd is involved,
    side effects are involved. This is so because an HTTP request is sent here.
    Again, see http://package.elm-lang.org/packages/elm-lang/http/latest/Http
    functions 'send' and 'get'.
    * Http.send takes a Msg and a Request.
        * Msg: the Msg type you created in TODO 5
        * Request: use Http.get
    * Http.get takes a String and a (Json) Decoder and returns a Request
        * String: the url (call createProfileUrl with newUserEmail)
        * Decoder: decodeGravatarResponse, see TODO 7
    With this information, try to implement the getGravatarUser function.
--}


getGravatarUser : String -> Cmd Msg
getGravatarUser newUserEmail =
    Cmd.none



-- remove Cmd.none and implement this function


createProfileUrl : String -> String
createProfileUrl email =
    "https://crossorigin.me/https://en.gravatar.com/" ++ MD5.hex email ++ ".json"


createIconUrl : String -> String
createIconUrl email =
    "https://www.gravatar.com/avatar/" ++ MD5.hex email



{--
    TODO 7: to decode (or extract) fields from a response to a record, you need to
    write a decoder. The function definition of this function is wrong, it returns
    a Decoder of type String. But we would like to extract multiple fields from
    the Gravatar response. Therefore, change it the function signature so that it
    will return a Decoder of the type you created in TODO 1.
--}


decodeGravatarResponse : Json.Decode.Decoder String



{--TODO 8: the implementation currently only returns the displayName from the response
    as a String. We need to extract multiple fields and put it into the record created
    in TODO 1. Some fields are required (i.e. always have a value), and some are
    optional (i.e. not in the Gravatar response).
    Have a look at Examples at http://package.elm-lang.org/packages/NoRedInk/elm-decode-pipeline/latest
    and try to implement the function.
    For required fields use Json.Decode.Pipeline.required
    For optional fields use Json.Decode.Pipeline.optional

    Hint: you could create a local variable with let ... in, like:
    let userDecoder =
        -- Json.Decode.Pipeline.decode <TODO 1 RecordName>
        -- more pipeline stuff
    in
    -- the fields are nested in the first element of the array in "entry".
    -- the line below extracts the first ("0") element of "entry"
    at ["entry", "0"] userDecoder
--}


decodeGravatarResponse =
    -- remove line below and implement function.
    Json.Decode.at [ "entry", "0", "displayName" ] Json.Decode.string
