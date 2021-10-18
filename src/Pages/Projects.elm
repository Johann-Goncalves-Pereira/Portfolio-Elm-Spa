module Pages.Projects exposing (page)

import Gen.Params.Projects exposing (Params)
import Html exposing (text)
import Page exposing (Page)
import Request
import Shared
import UI
import View exposing (View)


page : Shared.Model -> Request.With Params -> Page
page shared req =
    Page.static
        { view = view
        }


view : View msg
view =
    { title = "Project"
    , body = UI.layout [ text "Project" ]
    }
