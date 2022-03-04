module Pages.Projects exposing (Model, Msg, page)

import Gen.Params.Projects exposing (Params)
import Gen.Route as Route exposing (Route)
import Page
import Request
import Shared
import UI exposing (defaultConfig)
import View exposing (View)


page : Shared.Model -> Request.With Params -> Page.With Model Msg
page shared req =
    Page.sandbox
        { init = init
        , update = update
        , view = view
        }



-- INIT


type alias Model =
    { route : Route
    }


init : Model
init =
    { route = Route.Projects
    }



-- UPDATE


type Msg
    = ReplaceMe


update : Msg -> Model -> Model
update msg model =
    case msg of
        ReplaceMe ->
            model



-- VIEW


view : Model -> View Msg
view model =
    { title = "Johann - Projects"
    , body =
        UI.layout
            { defaultConfig
                | route = Route.Home_
            }
    }
