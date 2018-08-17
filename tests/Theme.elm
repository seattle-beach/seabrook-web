module Theme exposing (..)

import Expect exposing (Expectation)
import Test exposing (..)
import Css exposing (..)
import Color as Mix
import Layout.Theme exposing (..)


suite : Test
suite =
    describe "Colors"
        [ test "toHsl" <|
            \_ ->
                let
                    color =
                        hsla 179 0.8 0.27 1
                in
                    toHsl color
                        |> Expect.all
                            [ \x -> x.hue |> Expect.within (Expect.Relative 0.05) 179
                            , \x -> x.saturation |> Expect.within (Expect.Relative 0.05) 0.8
                            , \x -> x.lightness |> Expect.within (Expect.Relative 0.05) 0.27
                            , \x -> x.alpha |> Expect.equal 1
                            ]

        {-
           , test "lighten_ by 1" <|
               \_ ->
                   let
                       color =
                           hsl 179 0.8 0.27

                       colorHsl =
                           toHsl color

                       lightened =
                           lighten_ color 1
                               |> toHsl
                   in
                       lightened
                           |> Expect.all
                               [ \x -> x.lightness |> Expect.within (Expect.Relative 0.05) 0.54
                               , \x -> x.hue |> Expect.within (Expect.Relative 0.05) 179
                               , \x -> x.saturation |> Expect.within (Expect.Relative 0.05) 0.8
                               , \x -> x.alpha |> Expect.equal 1
                               ]
           , test "lighten_ by 0.2" <|
               \_ ->
                   let
                       color =
                           hsl 179 0.8 0.27

                       colorHsl =
                           toHsl color

                       lightened =
                           lighten_ color 0.2
                               |> toHsl
                   in
                       lightened
                           |> Expect.all
                               [ \x -> x.lightness |> Expect.within (Expect.Relative 0.05) 0.324
                               , \x -> x.hue |> Expect.within (Expect.Relative 0.05) 179
                               , \x -> x.saturation |> Expect.within (Expect.Relative 0.05) 0.8
                               , \x -> x.alpha |> Expect.equal 1
                               ]
        -}
        ]
