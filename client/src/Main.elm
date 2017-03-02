module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }


type alias Model =
    { name : Name
    , messages : List Message
    , activeMessage : String
    }


init : ( Model, Cmd Msg )
init =
    ( Model Anonymous [ Message Anonymous "Send me a message!" ] ""
    , Cmd.none
    )


type Msg
    = UpdateName String
    | UpdateActiveMessage String
    | SendMessage


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateName name ->
            ( { model | name = Given name }, Cmd.none )

        UpdateActiveMessage activeMessage ->
            ( { model | activeMessage = activeMessage }, Cmd.none )

        SendMessage ->
            if String.isEmpty model.activeMessage then
                ( model, Cmd.none )
            else
                ( { model | messages = List.append model.messages [ Message model.name model.activeMessage ], activeMessage = "" }
                , Cmd.none
                )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Elm Chat" ]
        , div []
            [ div [] [ b [] [ text "Name:" ] ]
            , input [ type_ "text", onInput UpdateName ] []
            ]
        , div [] (List.map messages model.messages)
        , div [] [ input [ type_ "text", value model.activeMessage, onInput UpdateActiveMessage ] [] ]
        , div [] [ button [ onClick SendMessage ] [ text "Send message" ] ]
        ]


type Name
    = Anonymous
    | Given String


type alias Message =
    { name : Name
    , text : String
    }


messages : Message -> Html Msg
messages message =
    div []
        [ div [] [ b [] [ text (displayName message.name) ] ]
        , div [] [ text message.text ]
        ]


displayName : Name -> String
displayName name =
    case name of
        Anonymous ->
            "Anonymous:"

        Given actualName ->
            String.concat [ actualName, ":" ]
