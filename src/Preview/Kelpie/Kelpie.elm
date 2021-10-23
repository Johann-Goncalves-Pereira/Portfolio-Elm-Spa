module Preview.Kelpie.Kelpie exposing (view)

import Array
import Html
    exposing
        ( Html
        , button
        , div
        , form
        , header
        , img
        , input
        , li
        , nav
        , p
        , section
        , span
        , strong
        , text
        , ul
        )
import Html.Attributes
    exposing
        ( alt
        , class
        , href
        , id
        , placeholder
        , src
        , type_
        )
import Preview.Kelpie.Svg
    exposing
        ( svgKelpieBell
        , svgKelpieDots
        , svgKelpieLogo
        , svgKelpieScan
        , svgKelpieSearch
        )


view : List (Html msg)
view =
    [ kelpieHeaderPage
    , kelpieMainContent
    , viewKelpiePictures
    ]



-- header


kelpieHeaderPage : Html msg
kelpieHeaderPage =
    header []
        [ nav [ class "header-objects" ]
            [ div [ class "left-header" ]
                [ p [ href "/" ] [ svgKelpieLogo ]
                , form []
                    [ button
                        [ type_ "submit"
                        , alt "Search"
                        ]
                        [ svgKelpieSearch ]
                    , input [ placeholder "Search Photos" ] []
                    , button [ class "visual-search" ]
                        [ svgKelpieScan ]
                    , div [] []
                    ]
                ]
            , div [ class "center-header" ]
                [ ul []
                    [ div []
                        [ li [ class "current-page" ]
                            [ p []
                                [ strong []
                                    [ text "Home" ]
                                ]
                            ]
                        , li [ class "brands" ]
                            [ p [ href "/brands" ]
                                [ text "Brands"
                                , span [] [ text "New" ]
                                ]
                            ]
                        ]
                    , li [ class "options-list" ]
                        [ button
                            []
                            [ svgKelpieDots ]
                        ]
                    ]
                ]
            , div [ class "right-header" ]
                [ div [ class "user-status" ]
                    [ button
                        [ class "submit-photo"
                        ]
                        [ text "Submit Photo" ]
                    , div [ class "separator" ] []
                    , p [ class "status-profile" ]
                        [ svgKelpieBell ]
                    , div [ class "photo-ctr-rds" ]
                        [ img [ src "https://avatars.githubusercontent.com/u/62612685?v=4" ] [] ]
                    ]
                ]
            ]
        , div [ class "tags" ]
            [ div []
                [ strong [] [ text "Tags" ]
                , div [ class "separator" ] []
                ]
            , div [ class "left-shadow" ] []
            , nav []
                [ ul [] <|
                    List.map tagsBody tagsNumbersList
                ]
            , div [ class "right-shadow" ] []
            ]
        ]


tagsNumbersList : List Int
tagsNumbersList =
    List.repeat
        (listTagsWords
            |> Array.fromList
            |> Array.length
        )
        1
        |> List.indexedMap (\idx _ -> idx)


tagsBody : Int -> Html msg
tagsBody id =
    li []
        [ p [ href <| "*/t/" ++ tagsWords id ]
            [ text <| tagsWords id ]
        ]


tagsWords : Int -> String
tagsWords idw =
    listTagsWords
        |> Array.fromList
        |> Array.get idw
        |> Maybe.withDefault "Error"


listTagsWords : List String
listTagsWords =
    [ "Wallpaper"
    , "People"
    , "Film"
    , "Movie"
    , "Nature"
    , "Dance"
    , "Happy"
    , "Food"
    , "Romance"
    , "History"
    , "Culture"
    , "Animals"
    , "LGBTQ"
    , "Family"
    , "Meme"
    , "Country"
    , "Offices"
    , "Materialize"
    , "Art"
    , "Draw"
    , "Farm"
    ]



-- main


kelpieMainContent : Html msg
kelpieMainContent =
    section [ id "kelpie-main-id" ]
        [ div [ class "main-image" ]
            [ img
                [ src <|
                    "https://images.unsplash.com/"
                        ++ "photo-1602330041000-4b8119482edf?ixid="
                        ++ "MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib="
                        ++ "rb-1.2.1&auto=format&fit=crop&w=1900&q=80"
                , alt "Day Image"
                ]
                []
            , div [ class "main-image-content" ]
                [ strong [] [ text "Kelpie" ]
                , div [ id "cool-info" ]
                    [ p []
                        [ text "The internet’s source of"
                        , p [] [ text "freely-usable images" ]
                        , text "."
                        ]
                    ]
                , p [] [ text "Powered by creators everywhere." ]
                , form []
                    [ button
                        [ type_ "submit"
                        , alt "Search"
                        ]
                        [{- svgKelpieSearch -}]
                    , input
                        [ placeholder "Search"
                        ]
                        []
                    , button []
                        [ svgKelpieScan ]
                    ]
                ]
            , footerImage
            ]
        ]


footerImage : Html msg
footerImage =
    div [ class "footer-of-image" ]
        [ div []
            [ p [] [ text "Photo of the Day" ]
            , text "by"
            , p [] [ text "Nathali Motoca" ]
            ]
        , div []
            [ p [] [ text "Read more about the" ]
            , p [] [ text "Unsplash License" ]
            ]
        , div []
            [ img [] []
            , p [] [ text "Start your website with Johann today." ]
            ]
        ]



-- profile


viewKelpiePictures : Html msg
viewKelpiePictures =
    div [ class "viewKelpiePictures" ]
        [ div []
            [ img
                [ src <| getKelpiePicture 0
                ]
                []
            , img
                [ src <| getKelpiePicture 1
                ]
                []
            , img
                [ src <| getKelpiePicture 2
                ]
                []
            ]
        , div []
            [ img
                [ src <| getKelpiePicture 3
                ]
                []
            , img
                [ src <| getKelpiePicture 4
                ]
                []
            , img
                [ src <| getKelpiePicture 5
                ]
                []
            ]
        ]


kelpiePictures : List String
kelpiePictures =
    [ "https://images.unsplash.com/"
        ++ "photo-1628881910804-53cfebaf5a75?ixid="
        ++ "MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib="
        ++ "rb-1.2.1&auto=format&fit=crop&w=634&q=80"
    , "https://images.unsplash.com/"
        ++ "photo-1580498137839-a3aa044dd1d4?ixlib="
        ++ "rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto="
        ++ "format&fit=crop&w=675&q=80"
    , "https://images.unsplash.com/"
        ++ "photo-1628626664260-314613531d26?ixid="
        ++ "MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib="
        ++ "rb-1.2.1&auto=format&fit=crop&w=1349&q=80"
    , "https://images.unsplash.com/"
        ++ "photo-1585569881280-a003419e4073?ixlib="
        ++ "rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit="
        ++ "crop&w=1355&q=80"
    , "https://images.unsplash.com/"
        ++ "photo-1628680816357-bedf9c480aa1?ixid="
        ++ "MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib="
        ++ "rb-1.2.1&auto=format&fit=crop&w=676&q=80"
    , "https://images.unsplash.com/"
        ++ "photo-1628845200647-059020cebf72?ixid="
        ++ "MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib="
        ++ "rb-1.2.1&auto=format&fit=crop&w=634&q=80"
    ]


getKelpiePicture : Int -> String
getKelpiePicture idx =
    Array.fromList kelpiePictures
        |> Array.get idx
        |> Maybe.withDefault ""
