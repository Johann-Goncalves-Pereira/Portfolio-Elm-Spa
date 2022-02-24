module Pages.Components.Mouse exposing
    ( EventPeekOffsetPosition
    , EventPeekScreenPosition
    , Mouse
    , MsgMouse
    , init
    , onChangeOffsetPosition
    , update
    , xOffsetPos
    , yOffsetPos
    )

import Html exposing (Attribute)
import Html.Events exposing (custom)
import Html.Events.Extra.Mouse as EMouse exposing (onMove)
import Json.Decode as Decode exposing (Decoder)


type alias EventPeekOffsetPosition =
    { mouseEvent : EMouse.Event
    , movement : ( Float, Float )
    }


type alias EventPeekScreenPosition =
    { mouseEvent : EMouse.Event
    , movement : ( Float, Float )
    }


type alias Mouse =
    { mouseOffsetPosition : ( Float, Float )
    , mouseScreenPosition : ( Float, Float )
    }


init : Mouse
init =
    Mouse ( 1920, 1920 ) ( 0, 0 )


type MsgMouse
    = OffsetPosition ( Float, Float )
    | ScreenPosition ( Float, Float )


update : MsgMouse -> Mouse -> Mouse
update msg mouse =
    case msg of
        OffsetPosition ( x, y ) ->
            { mouse | mouseOffsetPosition = ( x, y ) }

        ScreenPosition ( x, y ) ->
            { mouse | mouseScreenPosition = ( x, y ) }



-- Decode Offset


decodeChangeOffsetPosition : Decoder EventPeekOffsetPosition
decodeChangeOffsetPosition =
    Decode.map2 EventPeekOffsetPosition
        EMouse.eventDecoder
        changeOffsetPositionDecoder


changeOffsetPositionDecoder : Decoder ( Float, Float )
changeOffsetPositionDecoder =
    Decode.map2 (\a b -> ( a, b ))
        (Decode.field "offsetX" Decode.float)
        (Decode.field "offsetY" Decode.float)


onChangeOffsetPosition : (MsgMouse -> msg) -> Attribute msg
onChangeOffsetPosition extMsg =
    let
        decoder =
            decodeChangeOffsetPosition
                |> Decode.map (.movement >> OffsetPosition >> extMsg)
                |> Decode.map options

        options message =
            { message = message
            , stopPropagation = False
            , preventDefault = True
            }
    in
    custom "mousemove" decoder


xOffsetPos : Mouse -> Float
xOffsetPos model =
    Tuple.first model.mouseOffsetPosition


yOffsetPos : Mouse -> Float
yOffsetPos model =
    Tuple.second model.mouseOffsetPosition


mouseScreenPos : EMouse.Event -> ( Float, Float )
mouseScreenPos mouseEvent =
    mouseEvent.screenPos



-- xScreenPos : Float
-- xScreenPos =
--     Tuple.first <| mouseScreenPos onMove
