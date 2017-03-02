module Main exposing (..)

import Html exposing (..)


main : Program Never Model msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type alias Model =
    {}


init : ( Model, Cmd msg )
init =
    ( Model, Cmd.none )


update : msg -> Model -> ( Model, Cmd msg )
update msg model =
    ( model, Cmd.none )


view : Model -> Html msg
view model =
    div []
        [ h1 [] [ text "Elm Chat" ]
        ]


subscriptions : Model -> Sub msg
subscriptions model =
    Sub.none
