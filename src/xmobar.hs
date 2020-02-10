import Xmobar

config = defaultConfig { 
  font = "xft:Dejavu Sans:size=9:bold:antialias=true"
    -- , additionalFonts = ["xft:Symbola:size=9:bold:antialias=true"]
  , textOffset = 16
  , bgColor = "#f7f7f7"
  , fgColor = "black"
  , position = BottomSize C 100 24
  , border = TopB
  , borderColor = "#b0b0b0"

  , sepChar = "%"
  , alignSep = "}{"
  , template = " }{ %alsa:default:Master% | %battery% | %bright% | %date% "

  , lowerOnStart = False
  , hideOnStart = False
  , allDesktops = True
  , overrideRedirect = True
  , pickBroadest = False
  , persistent = True

  , commands = 
      [ Run $ Alsa "default" "Master"
        [ "-t", "<status> <volume>%"
        , "--"
          -- TODO change these to symbols when suitable font found
        , "-O", "[On]"
        , "-o", "[Off]"
        , "-c", "black"
        , "-C", "black"
        ]

      , Run $ Battery [ "--template" , "<acstatus><left>%"
                    , "--Low", "10"
                    , "--High", "80"
                    , "--low", "darkred"
                    , "--normal", "black"
                    , "--high", "black"
                    , "--"
                    , "-o" , "↓"
                    , "-O" , "↑"
                    , "-i" , "⚡"
                    ] 50

      , Run $ Brightness ["-t", "☀<percent>%"
                       , "--"
                       , "-D", "intel_backlight"
                       ] 10

      , Run $ Locks

      , Run $ Date "%Y-%m-%d %H:%M" "date" 10
      ]
  }

main :: IO ()
main = xmobar config
