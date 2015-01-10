--
-- Alexandre's xmonad config file.
--
-- See vicfryzel/xmonad-config for more.
--
-- A template showing all available configuration hooks,
-- and how to override the defaults in your own xmonad.hs conf file.
--
-- Normally, you'd only override those defaults you care about.
--

import XMonad
--import XMonad.Actions.CycleWS
import XMonad.Actions.GridSelect
import XMonad.Hooks.DynamicLog
--import XMonad.Hooks.ManageDocks
--import XMonad.Hooks.Script -- Simple interface to run ~/.xmonad/hooks script.
import XMonad.Layout.LayoutModifier
import XMonad.Layout.Spacing
--import XMonad.Util.EZConfig -- Easier keybinding names
--import XMonad.Util.Run
import Graphics.X11.ExtraTypes.XF86 -- Special keybindings
import Data.Monoid
import System.Exit

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

-- The preferred terminal program
-- Make sure systemd entry is set up, or that urxvtd -q -o -f is in .xinitrc
myTerminal :: String
myTerminal = "urxvtc"

-- Preferred browser
myBrowser :: String
myBrowser = "chromium"

-- Preferred status bar
myBar :: String
myBar = "xmobar" --"/home/alexandre/bar/conky_bar.sh"

-- Custom PP, describes what is being written to the bar
myPP :: PP
myPP = xmobarPP --defaultPP

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = False

-- Width of the window border in pixels.
myBorderWidth :: Dimension
myBorderWidth = 1

-- Use Windows Key (Super) as mod.
myModMask :: KeyMask
myModMask = mod4Mask

-- Workspaces organised in a grid-like fashion like a number pad
-- zipWith ( (++) . (++":") . show) [1..] ["Gen", "Web"]
myWorkspaces :: [String]
myWorkspaces = [ "Gen"
               , "Web"
               , "Dev"
               , "Docs"
               , "Steam"
               , "Media"
               , "News"
               , "Emu"
               , "Chat"
               ]

-- Border colors for unfocused and focused windows, respectively.
myNormalBorderColor :: String
myNormalBorderColor  = "#202030"
myFocusedBorderColor :: String
myFocusedBorderColor = "#A0A0D0"

-- Key bindings. Add, modify or remove key bindings here.
myKeys :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal
    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)

    -- launch dmenu
    , ((modm,               xK_p     ), spawn "dmenu_run")

    -- launch gmrun
    , ((modm .|. shiftMask, xK_p     ), spawn "gmrun")

    -- launch web browser
    , ((modm,               xK_i     ), spawn myBrowser)

    -- close focused window
    , ((modm .|. shiftMask, xK_c     ), kill)

    -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)

    -- Move focus to the next window
    , ((modm,               xK_Tab   ), windows W.focusDown)

    -- Move focus to the next window
    , ((modm,               xK_j     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modm,               xK_k     ), windows W.focusUp  )

    -- Move focus to the master window
    , ((modm,               xK_m     ), windows W.focusMaster  )

    -- Swap the focused window and the master window
    , ((modm,               xK_Return), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )

    -- Shrink the master area
    , ((modm,               xK_h     ), sendMessage Shrink)

    -- Expand the master area
    , ((modm,               xK_l     ), sendMessage Expand)

    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))

    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
    -- , ((modm              , xK_b     ), sendMessage ToggleStruts)

    -- Quit xmonad
    -- Modify it to use the logout based on the session.
    , ((modm .|. shiftMask, xK_q     ), io exitSuccess)

    -- Restart xmonad
    , ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")

    -- Run xmessage with a summary of the default keybindings (useful for beginners)
    , ((modm .|. shiftMask, xK_slash ), spawn ("echo \"" ++ help ++ "\" | xmessage -file -"))
    ]
    ++

    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    [ ((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    [ ((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
    ++

    -- Switch to different workspace via a nice grid.
    [ ((modm              , xK_g    ), gridselectWorkspace defaultGSConfig W.greedyView)

    -- Shift window to a different workspace.
    , ((modm .|. shiftMask, xK_g    ), gridselectWorkspace defaultGSConfig (\ws -> W.greedyView ws . W.shift ws))


    -- Enable laptop volume controls
    , ((0, xF86XK_AudioRaiseVolume ), spawn "amixer -q set Master 5%+ unmute")
    -- Don't want to unmute when we turn down volume.
    , ((0, xF86XK_AudioLowerVolume ), spawn "amixer -q set Master 5%-")
    , ((0, xF86XK_AudioMute        ), spawn "amixer sset Master toggle")

    -- Enable brightness
    , ((0, xF86XK_MonBrightnessUp  ), spawn "xbacklight -inc 10" )
    , ((0, xF86XK_MonBrightnessDown), spawn "xbacklight -dec 10" )
    ]


------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings :: XConfig t -> M.Map (KeyMask, Button) (Window -> X ())
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), \w -> focus w >> mouseMoveWindow w
                                      >> windows W.shiftMaster)

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), \w -> focus w >> windows W.shiftMaster)

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), \w -> focus w >> mouseResizeWindow w
                                      >> windows W.shiftMaster)

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.

spaceBetweenWindows :: Int
spaceBetweenWindows = 3

myLayout :: ModifiedLayout Spacing (Choose Tall (Choose (Mirror Tall) Full)) a
myLayout = spacing spaceBetweenWindows $ tiled ||| Mirror tiled ||| Full
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook :: ManageHook
myManageHook = composeAll . concat $
    [ [className    =? browser          --> doShift "Web"   |   browser     <- myBrowsers   ]
    , [className    =? emulator         --> doShift "Emu"   |   emulator    <- myEmulators  ]
    , [className    =? editor           --> doShift "Dev"   |   editor      <- myEditors    ]
    , [className    =? game             --> doShift "Steam" |   game        <- myGames      ]
    , [className    =? media            --> doShift "Media" |   media       <- myMedia      ]
    , [className    =? doc              --> doShift "Docs"  |   doc         <- myDocs       ]
    , [className    =? news             --> doShift "News"  |   news        <- myNews       ]
    , [className    =? chat             --> doShift "Chat"  |   chat        <- myChat       ]
    , [resource     =? ignore           --> doIgnore        |   ignore      <- myIgnores    ]
    ] where
        myBrowsers  = ["Chromium", "Midori"]
        myEmulators = ["Gvbam", "Desmume", "Dolphin-emu"]
        myEditors   = ["Gvim"]
        myGames     = ["Steam"]
        myMedia     = ["Pcmanfm", "Nautilus"
                      ,"Mcomix", "Calibre-gui"]
        myDocs      = ["Evince"]
        myNews      = ["Newsbeuter"]
        myChat      = ["Xchat", "Irssi"]
        myIgnores   = ["destkop_window", "kdesktop"]

------------------------------------------------------------------------
-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
myEventHook :: Event -> X All
myEventHook = mempty

------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
myLogHook :: X ()
myLogHook = return ()

------------------------------------------------------------------------
-- Programs launched on startup (or restart).

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
-- myStartupHook = return ()

--myStartUpScript :: String
--myStartUpScript = "startup"

myStartupHook :: X ()
myStartupHook = return ()
--myStartupHook = spawn "~/.xmonad/hooks/startup" --execScriptHook myStartUpScript
--myStartupHook = spawn "~/.xinitrc" --execScriptHook myStartUpScript

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with settings specified. Don't change.
main :: IO ()
main = xmonad =<< statusBar myBar myPP toggleStrutsKey myConfig
--main = do
--        h <- spawnPipe myTray
--        xmonad =<< statusBar myBar myPP toggleStrutsKey myConfig


-- Keybinding to toggle gap for the bar
toggleStrutsKey :: XConfig t -> (KeyMask, KeySym)
toggleStrutsKey XConfig {XMonad.modMask = modm} = ( modm, xK_b )

-- Structure containing config - don't change.
-- Defaults (xmonad/XMonad/Config.hs) will be used when settings aren't specified.
myConfig :: XConfig (ModifiedLayout Spacing (Choose Tall (Choose (Mirror Tall) Full)))
myConfig = defaultConfig {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         = myLayout,
        manageHook         = myManageHook,
        handleEventHook    = myEventHook,
        logHook            = myLogHook,
        startupHook        = myStartupHook
    }

-- Copy of the default bindings in simple text
help :: String
help = unlines ["The default modifier key is 'alt'. Default keybindings:",
    "",
    "-- launching and killing programs",
    "mod-Shift-Enter  Launch xterminal",
    "mod-p            Launch dmenu",
    "mod-Shift-p      Launch gmrun",
    "mod-Shift-c      Close/kill the focused window",
    "mod-Space        Rotate through the available layout algorithms",
    "mod-Shift-Space  Reset the layouts on the current workSpace to default",
    "mod-n            Resize/refresh viewed windows to the correct size",
    "",
    "-- move focus up or down the window stack",
    "mod-Tab        Move focus to the next window",
    "mod-Shift-Tab  Move focus to the previous window",
    "mod-j          Move focus to the next window",
    "mod-k          Move focus to the previous window",
    "mod-m          Move focus to the master window",
    "",
    "-- modifying the window order",
    "mod-Return   Swap the focused window and the master window",
    "mod-Shift-j  Swap the focused window with the next window",
    "mod-Shift-k  Swap the focused window with the previous window",
    "",
    "-- resizing the master/slave ratio",
    "mod-h  Shrink the master area",
    "mod-l  Expand the master area",
    "",
    "-- floating layer support",
    "mod-t  Push window back into tiling; unfloat and re-tile it",
    "",
    "-- increase or decrease number of windows in the master area",
    "mod-comma  (mod-,)   Increment the number of windows in the master area",
    "mod-period (mod-.)   Deincrement the number of windows in the master area",
    "",
    "-- quit, or restart",
    "mod-Shift-q  Quit xmonad",
    "mod-q        Restart xmonad",
    "mod-[1..9]   Switch to workSpace N",
    "",
    "-- Workspaces & screens",
    "mod-Shift-[1..9]   Move client to workspace N",
    "mod-{w,e,r}        Switch to physical/Xinerama screens 1, 2, or 3",
    "mod-Shift-{w,e,r}  Move client to screen 1, 2, or 3",
    "",
    "-- Mouse bindings: default actions bound to mouse events",
    "mod-button1  Set the window to floating mode and move by dragging",
    "mod-button2  Raise the window to the top of the stack",
    "mod-button3  Set the window to floating mode and resize by dragging"]
