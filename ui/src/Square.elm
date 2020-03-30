module Square exposing (Category(..), Square, centerSquare, checked, genericSquare, squaresByCategory, toggleSquareInList)

import Dot exposing (Dot, dot)
import Random exposing (Seed)


type alias Square =
    { text : String, category : Category, dots : List Dot }


type Category
    = Generic
    | Fordism
    | Center


genericSquare : String -> Square
genericSquare text =
    Square text Generic []


fordismSquare : String -> Square
fordismSquare text =
    Square text Fordism []


centerSquare : Square
centerSquare =
    Square "Free ⭐️ Space" Center []


genericSquares : List Square
genericSquares =
    [ genericSquare "\"Mute your phone please\""
    , genericSquare "5 seconds awkward silence"
    , genericSquare "Sound of telephone ringing"
    , genericSquare "(sigh)"
    , genericSquare "\"Ok, let's get started\""
    , genericSquare "(coughing)"
    , genericSquare "Child or animal noise"
    , genericSquare "People talking at the same time"
    , genericSquare "\"This was shared ahead of time\""
    , genericSquare "Echo noise or feedback"
    , genericSquare "Sound of someone typing"
    , genericSquare "\"Can you repeat that?\""
    , genericSquare "\"Can you share that by email?\""
    , genericSquare "Sound of background conversation"
    , genericSquare "\"...technical difficulties.\""
    , genericSquare "5th \"Thank you\""
    , genericSquare "\"Time is just about up\""
    , genericSquare "Powerpoint malfunction"
    , genericSquare "\"I was on mute\""
    , genericSquare "\"Can you see my screen?\""
    , genericSquare "Unintended interruption"
    , genericSquare "\"__, can you comment?\""
    , genericSquare "\"I need to step out\""
    , genericSquare "\"Can you share?\""
    , genericSquare "\"You're not sharing\""
    , genericSquare "Any acronym"
    , genericSquare "Roundtable introductions"
    , genericSquare "5 or more Webex beeps"
    , genericSquare "Pet or child on webcam"
    , genericSquare "University logo on webcam"
    , genericSquare "\"What team are you from?\""
    , genericSquare "\"double mute\""
    , genericSquare "Reference to people as resources"
    , genericSquare "\"I'll send out the deck\""
    , genericSquare "(eating sounds)"
    , genericSquare "\"Bingo!\""
    , genericSquare "\"I think ____ stepped away\""
    , genericSquare "\"Can you hear me?\""
    ]


fordisms : List Square
fordisms =
    [ fordismSquare "\"VIN number\""
    , fordismSquare "\"MVP\""
    , fordismSquare "Any vehicle program number"
    , fordismSquare "\"Go further\""
    , fordismSquare "\"LL_ approval needed\""
    , fordismSquare "Any _aaS acronym"
    , fordismSquare "A well known acronym repurposed by Ford"
    ]


allCategorySquares =
    fordisms


squaresByCategory : List Category -> List Square
squaresByCategory categories =
    genericSquares ++ (allCategorySquares |> List.filter (\square -> List.member square.category categories))


toggleSquareInList : Seed -> Dot.Color -> Square -> List Square -> ( List Square, Seed )
toggleSquareInList seed color squareToToggle squares =
    let
        ( newSquare, nextSeed ) =
            if (squareToToggle.dots |> List.length) == 3 then
                unToggleSquare seed squareToToggle

            else
                toggleSquare seed color squareToToggle
    in
    ( List.map
        (\square ->
            if square == squareToToggle then
                newSquare

            else
                square
        )
        squares
    , nextSeed
    )


unToggleSquare seed square =
    ( { square | dots = [] }, seed )


toggleSquare : Seed -> Dot.Color -> Square -> ( Square, Seed )
toggleSquare seed color square =
    let
        ( randomDot, nextSeed ) =
            dot seed color
    in
    ( { square | dots = randomDot :: square.dots }, nextSeed )


checked : Square -> Bool
checked square =
    (square.dots |> List.isEmpty |> not) || square.category == Center
