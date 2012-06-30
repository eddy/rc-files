--
-- xmonad config file.
--
 
-- -- import XMonad.Layout
--  
-- import XMonad.Layout.LayoutModifier
-- import XMonad.Layout.Named
-- import XMonad.Layout.Reflect
-- import XMonad.Layout.TwoPane
-- import XMonad.Layout.WindowNavigation
-- import XMonad.Util.WindowProperties
-- import Control.Monad

import XMonad
import System.Exit
 
import qualified XMonad.StackSet as W
import qualified Data.Map        as M
 
-- GHC hierarchical libraries
import XMonad.Operations
import XMonad.Config
import XMonad.Util.Run
import System.IO
import Data.Ratio ((%))
 
--Contribs
import XMonad.Actions.CycleWS
import XMonad.Actions.NoBorders
 
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.FadeInactive
import XMonad.Util.EZConfig
 
-- import XMonad.Layout
import qualified XMonad.StackSet as S
import XMonad.Layout.Combo
import XMonad.Layout.Accordion
import XMonad.Layout.Grid
import XMonad.Layout.IM
import XMonad.Layout.NoBorders
import XMonad.Layout.PerWorkspace
import XMonad.Layout.SimpleFloat
import Graphics.X11.Xlib

 
-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal      = "xterm"
 
-- Width of the window border in pixels.
--
myBorderWidth   = 3
 
-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask       = mod4Mask
altMask         = mod1Mask 
myNumlockMask   = mod2Mask
 

-- The default number of workspaces (virtual screens) and their names.
--
myWorkspaces    = ["local/1","local/2","local/3","im/4","dev/5","prod/6","prod/7","net/8","web/9"]

-- Border colors for unfocused and focused windows, respectively.
--
myNormalBorderColor  = "#aaaaaa"
myFocusedBorderColor = "#729fcf"


------------------------------------------------------------------------
-- Key bindings
--
myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
 
    -- launch a terminal
    [ ((modMask,                xK_space), spawn $ XMonad.terminal conf)
 
    -- launch thunar
    , ((modMask .|. altMask,    xK_a    ), spawn "thunar")
 
    -- launch alsamixer
    , ((modMask .|. altMask,    xK_f    ), spawn "firefox about:blank")
 
    -- launch web-browser
    , ((modMask .|. altMask,    xK_space ), spawn "firefox")
 
    -- launch dmenu
    , ((modMask,                xK_p     ), spawn "exe=`dmenu_path | dmenu -b -nb '#2a2b2f' -nf '#e1e0e5' -fn '-misc-fixed-*-*-*-*-15-*-*-*-*-*-*-*' -p '$'` && eval \"exec $exe\"")

    -- launch mutt
    , ((modMask .|. altMask,    xK_u    ), spawn "urxvt")
 
    -- launch pidgin
    , ((modMask .|. altMask,    xK_p    ), spawn "pidgin")
 
    -- status bar
    , ((modMask,                xK_s    ), spawn $ myConkyBar)

    -- close focused window
    , ((modMask,        xK_x     ), kill)
 
     -- Rotate through the available layout algorithms
    , ((modMask,                xK_Return ), sendMessage NextLayout)
 
    --  Reset the layouts on the current workspace to default
    -- , ((modMask .|. shiftMask,  xK_space ), setLayout $ XMonad.layoutHook conf)
 
    -- Resize viewed windows to the correct size
    -- , ((modMask,             xK_n     ), refresh)
 
    -- Move focus to the next window
    , ((modMask,                xK_Tab   ), windows W.focusDown)
 
    -- Move focus to the next window
    , ((modMask,                xK_j     ), windows W.focusDown)
 
    -- Move focus to the previous window
    , ((modMask,                xK_k     ), windows W.focusUp  )
 
    -- Move focus to the master window
    , ((modMask,             xK_m     ), windows W.focusMaster  )
 
    -- Swap the focused window and the master window
    --, ((modMask,              xK_Return), windows W.swapMaster)
 
    -- Swap the focused window with the next window
    , ((modMask .|. shiftMask,  xK_j     ), windows W.swapDown  )
 
    -- Swap the focused window with the previous window
    , ((modMask .|. shiftMask,  xK_k     ), windows W.swapUp    )
 
    -- Shrink the master area
    , ((modMask,                xK_h     ), sendMessage Shrink)
 
    -- Expand the master area
    , ((modMask,                xK_l     ), sendMessage Expand)
 
    -- Push window back into tiling
    , ((modMask,                xK_t     ), withFocused $ windows . W.sink)
 
    -- Increment the number of windows in the master area
    , ((modMask,                xK_comma ), sendMessage (IncMasterN 1))
 
    -- Deincrement the number of windows in the master area
    , ((modMask,                xK_period), sendMessage (IncMasterN (-1)))
 
    -- toggle the status bar gap
    , ((modMask,                xK_b     ), sendMessage ToggleStruts)
 
    -- Quit xmonad (Default)
    -- , ((modMask .|. shiftMask, xK_q     ), spawn "xfce4-session-logout")
    -- , ((modMask .|. shiftMask,  xK_q     ), io (exitWith ExitSuccess))
    , ((modMask .|. shiftMask,  xK_q     ), spawn "sudo shutdown -h now" )

 
    -- Restart xmonad
    , ((modMask,                xK_r     ),
          broadcastMessage ReleaseResources >> restart "xmonad" True)

    -- ctrl alt left/right to switch workspace
    , ((altMask .|. controlMask, xK_Left  ), prevWS)
    , ((altMask .|. controlMask, xK_Right ), nextWS)

    ]
    ++
 
    -- Alt+F1..F10 switches to workspace
    [ ((altMask, k), windows $ S.greedyView i)
        | (i, k) <- zip myWorkspaces workspaceKeys
    ] ++

    -- mod+F1..F10 moves window to workspace
    [ ((myModMask, k), (windows $ S.shift i))
        | (i, k) <- zip myWorkspaces workspaceKeys
    ] ++

    -- mod+alt+F1..F10 moves window to workspace and switches to that workspace
    [ ((myModMask .|. altMask, k), (windows $ S.shift i) >> (windows $ S.greedyView i))
        | (i, k) <- zip myWorkspaces workspaceKeys
    ]
    where workspaceKeys = [xK_F1 .. xK_F10]

 
 
------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modMask}) = M.fromList $
 
    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modMask, button1), (\w -> focus w >> mouseMoveWindow w))

    -- mod-button2, Raise the window to the top of the stack
    , ((modMask, button2), (\w -> focus w >> windows W.swapMaster))
 
    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modMask, button3), (\w -> focus w >> mouseResizeWindow w))
 
    -- alt + left click, move to prev ws
    , ((altMask, button1), const (prevWS))
    
    -- alt + right click, move to next ws
    , ((altMask, button3), const (nextWS))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]
 

------------------------------------------------------------------------
-- Layouts:
-- 
imLayout = smartBorders $ IM (1%5) 
              (Or (Title "Buddy List") 
              (And (Resource "main") (ClassName "psi")))
 
genericLayout = avoidStruts (tiled ||| Mirror tiled ||| Grid ||| Accordion ||| simpleFloat ||| imLayout ||| Full) ||| Full
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio
 
     -- The default number of windows in the master pane
     nmaster = 1
 
     -- Default proportion of screen occupied by master pane
     ratio   = 1/2
 
     -- Percent of screen to increment by when resizing panes
     delta   = 3/100
 
 
myLayout =  onWorkspace "4" imLayout 
        $   genericLayout
 
------------------------------------------------------------------------
-- Window rules:
--
myManageHook = composeAll
    [ className                =? "Xpdf"                   --> doFloat
    , className                =? "Firefox"                --> doF (W.shift "web/9")
    , className                =? "Pidgin"                 --> doF (W.shift "net/8")
    , className                =? "Tomboy"                 --> doFloat
    , className                =? "Gimp"                   --> doFloat
    , className                =? "MPlayer"                --> doFloat
    , resource                 =? "desktop_window"         --> doIgnore
    , resource                 =? "kdesktop"               --> doIgnore
    , stringProperty "WM_NAME" =? "Downloads"              --> doFloat
    , title                    =? "Xfce Settings Manager"  --> doF (W.shift "net/8")
    ]
 
 
-- Whether focus follows the mouse pointer.
--
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True
 
-- Dzen stuff
--
myStatusBar :: String
myStatusBar = "dzen2 -fn '-misc-fixed-*-*-*-*-14-*-*-*-*-*-*-*' -bg '#2a2b2f' -fg '#444444' -w 1250 -h 24 -sa c -x 0 -y 0 -e '' -ta l"
 
myConkyBar :: String
myConkyBar = "sleep 1 && if [ `pidof conky` ]; then kill `pidof conky`; fi; conky -c ~/.conkyrcdzen | dzen2 -fn '-*-arial-*-r-*-*-*-*-*-*-*-*-*-*' -bg '#2a2b2f' -w 600 -h 24 -x 1000 -y 0 -e '' -ta r"
 
myLogHook :: Handle -> X ()
myLogHook h = dynamicLogWithPP $ defaultPP
      {   ppCurrent         = wrapFgBg "white" "#62acce" . pad
        , ppVisible         = dzenColor "lightgreen" "" . pad
        , ppHidden          = dzenColor "#e1e0e5" ""      . pad
        , ppHiddenNoWindows = dzenColor "#444444"  ""   . pad
        , ppUrgent          = dzenColor "#e6ac32" ""
        , ppWsSep           = ""
        , ppSep             = "|"
        , ppLayout          = dzenColor "green" "" .
                                (\ x -> case x of
                                    "Maximize Tall"                   -> "[]="
                                    "Maximize Mirror Tall"            -> "TTT"
                                    "Maximize Full"                   -> "<M>"
                                    "Maximize Grid"                   -> "+++"
                                    "Maximize Spiral"                 -> "(@)"
                                    "Maximize Accordion"              -> "Acc"
                                    "Maximize Tabbed Simplest"        -> "Tab"
                                    "Maximize Tabbed Bottom Simplest" -> "TaB"
                                    "Maximize SimplestFloat"          -> "><>"
                                    "Maximize IM"                     -> "IM "
                                    "Maximize Dishes 2 (1%6)"         -> "Dsh"
                                    _                                 -> pad x
                                )
        , ppTitle          = (" " ++) . dzenColor "#62acce" "" . dzenEscape
        , ppOutput         = hPutStrLn h
      }
      where
        wrapFgBg fgColor bgColor content= wrap ("^fg(" ++ fgColor ++ ")^bg(" ++ bgColor ++ ")") "^fg()^bg()" content
 
------------------------------------------------------------------------
 
main :: IO ()
main = do 
       workspaceBarPipe <- spawnPipe myStatusBar
       -- conkyBarPipe <- spawnPipe myConkyBar
       spawn "xcompmgr"
       xmonad $ withUrgencyHook NoUrgencyHook defaultConfig {
 
      -- simple stuff
         terminal           = myTerminal,
         focusFollowsMouse  = myFocusFollowsMouse,
         borderWidth        = myBorderWidth,
         modMask            = myModMask,
         numlockMask        = myNumlockMask,
         workspaces         = myWorkspaces,
         normalBorderColor  = myNormalBorderColor,
         focusedBorderColor = myFocusedBorderColor,
 
      -- key bindings
         keys               = myKeys,
         mouseBindings      = myMouseBindings,
 
      -- hooks, layouts
         manageHook         = myManageHook <+> manageDocks,
         logHook            = myLogHook workspaceBarPipe >> fadeInactiveLogHook 0xdddddddd,
 
      -- For use with no panels or just dzen2
         -- layoutHook         = ewmhDesktopsLayout $ avoidStruts $ myLayout
         layoutHook         = avoidStruts $ myLayout
    }
