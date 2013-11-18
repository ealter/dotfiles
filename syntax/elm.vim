" Vim syntax file
" Language: Elm (http://elm-lang.org/)
" Maintainer: Alexander Noriega
" Latest Revision: 16 March 2013
" Source: https://github.com/lambdatoast/elm.vim

if exists("b:current_syntax")
  finish
endif

" Keywords
syn keyword elmKeyword as case class data default deriving do else export foreign
syn keyword elmKeyword hiding jsevent if import in infix infixl infixr instance let
syn keyword elmKeyword module newtype of then type where _

" Builtin operators
syn match elmBuiltinOp "\.\."
syn match elmBuiltinOp "|\{,2\}"
syn match elmBuiltinOp ":"
syn match elmBuiltinOp "::"
syn match elmBuiltinOp "="
syn match elmBuiltinOp "\\"
syn match elmBuiltinOp "\""
syn match elmBuiltinOp "->"
syn match elmBuiltinOp "<-"
syn match elmBuiltinOp "\u2192" " right arrow
syn match elmBuiltinOp "\u03BB" " lambda
syn match elmBuiltinOp "\$"
syn match elmBuiltinOp "&&"
syn match elmBuiltinOp "+"
syn match elmBuiltinOp "++"
syn match elmBuiltinOp "-"
syn match elmBuiltinOp "\."
syn match elmBuiltinOp "/"
syn match elmBuiltinOp "/="
syn match elmBuiltinOp "<"
syn match elmBuiltinOp "<="
syn match elmBuiltinOp "=="
syn match elmBuiltinOp ">"
syn match elmBuiltinOp ">="
syn match elmBuiltinOp "\^"
syn match elmBuiltinOp "\*"
syn match elmBuiltinOp "<\~"
syn match elmBuiltinOp "\~"

" Builtin types
syn keyword elmBuiltinType Bool Char False Float GT Int Just LT Maybe Nothing String True
syn keyword elmBuiltinType Time Date Text Order Element List Signal Tuple Either

" Libraries
syn keyword elmCoreLibrary List Time Collage Form Prelude Random Signal Http Set Color Keyboard Text WebSocket Automaton Mouse Dict Char Maybe Json Window Experimental JavaScript Either Date Matrix2D Element Touch Input

" Library functions

" Automaton
syn keyword elmBuiltinFunction run step (>>>) (<<<) combine pure state hiddenState count average
" Char
syn keyword elmBuiltinFunction isUpper isLower isDigit isOctDigit isHexDigit toUpper toLower toLocaleUpper toLocaleLower toCode fromCode
" Color
syn keyword elmBuiltinFunction rgb rgba hsv hsva grayscale greyscale complement linear radial red orange yellow green blue purple brown lightRed lightOrange lightYellow lightGreen lightBlue lightPurple lightBrown darkRed darkOrange darkYellow darkGreen darkBlue darkPurple darkBrown white lightGrey grey darkGrey lightCharcoal charcoal darkCharcoal black
" Date
syn keyword elmBuiltinFunction read toTime year month day dayOfWeek hour minute second
" Dict
syn keyword elmBuiltinFunction empty min lookup findWithDefault member rotateLeft rotateRight rotateLeftIfNeeded rotateRightIfNeeded color_flip color_flipIfNeeded ensureBlackRoot insert singleton isRed isRedLeft isRedLeftLeft isRedRight isRedRightLeft moveRedLeft moveRedRight moveRedLeftIfNeeded moveRedRightIfNeeded deleteMin remove map foldl foldr union intersect diff keys values toList fromList
" Either
syn keyword elmBuiltinFunction either isLeft isRight lefts rights partition
" Graphics.Collage
syn keyword elmBuiltinFunction defaultLine solid dashed dotted form filled textured gradient outlined traced sprite toForm group groupTransform rotate scale move moveX moveY opacity collage path segment polygon rect square oval circle ngon
" Graphics.Element
syn keyword elmBuiltinFunction widthOf heightOf sizeOf width height size opacity color tag link image fittedImage croppedImage tiledImage container spacer flow above below beside layers absolute relative middle topLeft topRight bottomLeft bottomRight midLeft midRight midTop midBottom middleAt topLeftAt topRightAt bottomLeftAt bottomRightAt midLeftAt midRightAt midTopAt midBottomAt up down left right inward outward
" Graphics.Input
syn keyword elmBuiltinFunction buttons button customButtons customButton checkboxes checkbox hoverables hoverable fields emptyFieldState field password email dropDown stringDropDown
" Http
syn keyword elmBuiltinFunction request get post send sendGet
" JavaScript
syn keyword elmBuiltinFunction toList toInt toFloat toBool toString fromList fromInt fromFloat fromBool fromString fromElement toElement
" JavaScript.Experimental
syn keyword elmBuiltinFunction toRecord fromRecord
" Json
syn keyword elmBuiltinFunction toString toJSString fromString fromJSString fromJSObject toJSObject
" Keyboard
syn keyword elmBuiltinFunction arrows wasd directions isDown shift ctrl space enter keysDown lastPressed
" List
syn keyword elmBuiltinFunction (::) (++) head tail last isEmpty map foldl foldr foldl1 foldr1 scanl scanl1 filter length reverse all any and or concat concatMap sum product maximum minimum partition zip zipWith unzip split join intersperse take drop
" Matrix2D
syn keyword elmBuiltinFunction identity matrix rotation multiply
" Maybe
syn keyword elmBuiltinFunction maybe isJust isNothing cons justs
" Mouse
syn keyword elmBuiltinFunction position x y isDown isClicked clicks
" Prelude
syn keyword elmBuiltinFunction radians degrees turns fromPolar toPolar (+) (-) (*) (/) div rem mod (^) cos sin tan acos asin atan atan2 sqrt abs logBase min max clamp pi e (<) (>) compare (&&) (||) xor not otherwise round truncate floor ceiling toFloat show readInt readFloat (.) (|>) (<|) id fst snd flip curry uncurry
" Random
syn keyword elmBuiltinFunction range float
" Set
syn keyword elmBuiltinFunction empty singleton insert remove member union intersect diff toList fromList foldl foldr map
" Signal
syn keyword elmBuiltinFunction constant lift lift2 lift3 lift4 lift5 lift6 lift7 lift8 foldp merge merges combine count countIf keepIf dropIf keepWhen dropWhen dropRepeats sampleOn (<~) (~)
" Text
syn keyword elmBuiltinFunction toText typeface monospace header link height color bold italic overline underline strikeThrough justified centered righted text plainText asText
" Time
syn keyword elmBuiltinFunction millisecond second minute hour inMilliseconds inSeconds inMinutes inHours fps fpsWhen every since timestamp delay
" Touch
syn keyword elmBuiltinFunction touches taps
" WebSocket
syn keyword elmBuiltinFunction connect
" Window
syn keyword elmBuiltinFunction dimensions width height

" Comments
syn match elmTodo "[tT][oO][dD][oO]" contained
syn match elmLineComment "--.*"
syn region elmComment start="{-" end="-}" contains=elmTodo,elmComment

" String literals
syn region elmString start="\"[^"]" skip="\\\"" end="\"" contains=elmStringEscape
syn match elmStringEscape "\\u[0-9a-fA-F]\{4}" contained
syn match elmStringEscape "\\[nrfvb\\\"]" contained

" Number literals
syn match elmNumber "\(\<\d\+\>\)"
syn match elmNumber "\(\<\d\+\.\d\+\>\)"

let b:current_syntax = "elm"

hi def link elmKeyword            Keyword
hi def link elmBuiltinOp          Special
hi def link elmBuiltinType        Type
hi def link elmBuiltinFunction    Function
hi def link elmCoreLibrary        Type
hi def link elmTodo               Todo
hi def link elmLineComment        Comment
hi def link elmComment            Comment
hi def link elmString             String
hi def link elmNumber             Number
