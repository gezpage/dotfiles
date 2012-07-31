-------------------------------------------------------------------------------
-- xmonad.hs for xmonad-darcs
-- Author: Øyvind 'Mr.Elendig' Heggstad <mrelendig AT har-ikkje DOT net>
-------------------------------------------------------------------------------
-- Compiler flags --
{-# LANGUAGE NoMonomorphismRestriction #-}

-- Imports --
-- stuff
import XMonad
import qualified XMonad.StackSet as W
import qualified Data.Map as M
import System.Exit

-- actions
import XMonad.Actions.GridSelect

-- hooks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.InsertPosition

-- layouts
import XMonad.Layout.NoBorders
import XMonad.Layout.ResizableTile
import XMonad.Layout.Named
import XMonad.Layout.Tabbed

-------------------------------------------------------------------------------
-- Main --
main :: IO ()
main = xmonad =<< statusBar cmd pp kb conf
  where 
    uhook = withUrgencyHookC NoUrgencyHook urgentConfig
    cmd = "bash -c \"tee >(xmobar -x0) | xmobar -x1\""
    pp = customPP
    kb = toggleStrutsKey
    conf = uhook myConfig

-------------------------------------------------------------------------------
-- Configs --
myConfig = defaultConfig { workspaces = workspaces'
                         , modMask = modMask'
                         , borderWidth = borderWidth'
                         , normalBorderColor = normalBorderColor'
                         , focusedBorderColor = focusedBorderColor'
                         , terminal = terminal'
                         , keys = keys'
                         , layoutHook = layoutHook'
                         , manageHook = manageHook'
                         }

-------------------------------------------------------------------------------
-- Window Management --
manageHook' = composeAll [ isFullscreen             --> doFullFloat
                         , className =? "Chromium"  --> doShift "2:web"
                         , className =? "Google-chrome"    --> doShift "2:web"
                         , className =? "Mysql-workbench-bin"    --> doShift "3:sql"
                         , className =? "Vmplayer"    --> doShift "4:vm"
                         , className =? "MPlayer"   --> doFloat
                         , className =? "Gimp"      --> doFloat
                         , className =? "Vlc"       --> doFloat
			 , insertPosition Below Newer
			 , transience'
                         ]
-------------------------------------------------------------------------------
-- Looks --
-- bar
customPP = defaultPP { ppCurrent = xmobarColor "#429942" "" . wrap "<" ">"
                     , ppHidden = xmobarColor "#C98F0A" ""
                     , ppHiddenNoWindows = xmobarColor "#C9A34E" ""
                     , ppUrgent = xmobarColor "#FFFFAF" "" . wrap "[" "]" 
                     , ppLayout = xmobarColor "#C9A34E" ""
                     , ppTitle =  xmobarColor "#C9A34E" "" . shorten 80
                     , ppSep = xmobarColor "#429942" "" " | "
                     }
-- GridSelect
myGSConfig = defaultGSConfig { gs_cellwidth = 160 }

-- urgent notification
urgentConfig = UrgencyConfig { suppressWhen = Focused, remindWhen = Dont }

-- borders
borderWidth' = 1
normalBorderColor'  = "#111111"
focusedBorderColor' = "#AFAF87"

-- tabs
tabTheme1 = defaultTheme { decoHeight = 16
                         , activeColor = "#a6c292"
                         , activeBorderColor = "#a6c292"
                         , activeTextColor = "#000000"
                         , inactiveBorderColor = "#000000"
                         }

-- workspaces
workspaces' = ["1:term", "2:web", "3:sql", "4:vm", "5", "6", "7", "8", "9"]

-- layouts
layoutHook' = tile ||| mtile ||| tab ||| full
  where
    rt = ResizableTall 1 (2/100) (1/2) []
    tile = named "[]=" $ smartBorders rt
    mtile = named "M[]=" $ smartBorders $ Mirror rt
    tab = named "T" $ noBorders $ tabbed shrinkText tabTheme1
    full = named "[]" $ noBorders Full 

-------------------------------------------------------------------------------
-- Terminal --
terminal' = "urxvt"

-------------------------------------------------------------------------------
-- Keys/Button bindings --
-- modmask
modMask' = mod4Mask

-- keys
toggleStrutsKey :: XConfig Layout -> (KeyMask, KeySym)
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

keys' :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
keys' conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
    -- launching and killing programs
    -- [ ((modMask,               xK_Return), spawn $ XMonad.terminal conf) 
    [ ((modMask,               xK_Return), spawn "gnome-terminal") 
    , ((modMask,               xK_p     ), spawn "gmrun") 
    , ((modMask .|. shiftMask, xK_p     ), spawn "dmenu_run")
    , ((modMask .|. shiftMask, xK_m     ), spawn "claws-mail")
    , ((modMask .|. shiftMask, xK_c     ), kill)

    , ((modMask,               xK_i     ), spawn "google-chrome") 
    , ((modMask,               xK_v     ), spawn "vmplayer") 
    , ((modMask,               xK_s     ), spawn "mysql-workbench") 
    , ((modMask,               xK_t     ), spawn "thunar") 

    -- volume controls
    , ((modMask,               xK_minus ), spawn "amixer -q set Master 3- unmute")
    , ((modMask,               xK_equal ), spawn "amixer -q set Master 3+ unmute")

    -- mpd controls
    , ((modMask,               xK_bracketright ), spawn "mpc seek +10")
    , ((modMask,               xK_bracketleft  ), spawn "mpc seek -10")
    , ((modMask .|. shiftMask, xK_bracketright ), spawn "mpc next")
    , ((modMask .|. shiftMask, xK_bracketleft  ), spawn "mpc prev")
    , ((modMask,               xK_numbersign   ), spawn "mpc random")
    , ((modMask,               xK_apostrophe   ), spawn "mpc toggle")

    -- grid
    , ((modMask,               xK_g     ), goToSelected myGSConfig)

    -- layouts
    , ((modMask,               xK_space ), sendMessage NextLayout)
    , ((modMask .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- floating layer stuff
    , ((modMask,               xK_t     ), withFocused $ windows . W.sink)

    -- refresh
    , ((modMask,               xK_n     ), refresh)

    -- focus
    , ((modMask,               xK_Tab   ), windows W.focusDown)
    , ((modMask,               xK_j     ), windows W.focusDown)
    , ((modMask,               xK_k     ), windows W.focusUp)
    , ((modMask,               xK_m     ), windows W.focusMaster)

    -- swapping
    , ((modMask .|. shiftMask, xK_Return), windows W.swapMaster)
    , ((modMask .|. shiftMask, xK_j     ), windows W.swapDown  )
    , ((modMask .|. shiftMask, xK_k     ), windows W.swapUp    )

    -- increase or decrease number of windows in the master area
    , ((modMask              , xK_comma ), sendMessage (IncMasterN 1))
    , ((modMask              , xK_period), sendMessage (IncMasterN (-1)))

    -- resizing
    , ((modMask,               xK_h     ), sendMessage Shrink)
    , ((modMask,               xK_l     ), sendMessage Expand)
    , ((modMask .|. shiftMask, xK_h     ), sendMessage MirrorShrink)
    , ((modMask .|. shiftMask, xK_l     ), sendMessage MirrorExpand)

    -- quit, or restart
    , ((modMask .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))
    , ((modMask              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")
    ]
    ++
    -- mod-[1..9] %! Switch to workspace N
    -- mod-shift-[1..9] %! Move client to workspace N
    [((m .|. modMask, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++
    -- mod-[w,e] %! switch to twinview screen 1/2
    -- mod-shift-[w,e] %! move window to screen 1/2
    [((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

-------------------------------------------------------------------------------

