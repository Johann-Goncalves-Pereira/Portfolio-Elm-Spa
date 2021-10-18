module Pages.Home_ exposing (page)

import Html exposing (Html, text)
import Page exposing (Page)
import Request exposing (Request)
import Shared
import UI
import View exposing (View)


page : Shared.Model -> Request -> Page
page shared req =
    Page.static
        { view = view
        }


view : View msg
view =
    { title = "Homepage"
    , body =
        UI.layout [ text "Homepage" ]
    }
