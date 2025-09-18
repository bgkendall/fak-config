let { tap, hold, td, combo, macro, MO, LT, .. } = import "fak/keycode.ncl" in
let mc = import "private/macros.ncl" in

# Common aliases
let kc  = tap.reg.kc in
let ks  = tap.reg.ks in
# let kh  = hold.reg.kc in
let md  = tap.reg.mod in
let me  = tap.custom.media in
let mh  = hold.reg.mod in
let ms  = tap.custom.mouse in
let fa  = tap.custom.fak in
let la  = std.record.map_values ((&) md.lalt) kc in
let La  = std.record.map_values ((&) (md.lalt & md.lsft)) kc in
let ra  = std.record.map_values ((&) md.ralt) kc in
let Ra  = std.record.map_values ((&) (md.ralt & md.rsft)) kc in
let lg  = std.record.map_values ((&) md.lgui) kc in
let Lg  = std.record.map_values ((&) (md.lgui & md.lsft)) kc in
let rg  = std.record.map_values ((&) md.rgui) kc in
let Rg  = std.record.map_values ((&) (md.rgui & md.rsft)) kc in
let XXX = tap.none & hold.none in
let TTT = tap.trans & hold.trans in

# Other Helpers
let keyRepeatOnDoubleTap = { quick_tap_ms = 150, } in
let MT = fun behaviour modifier tap => hold.reg.behavior behaviour & modifier & tap in

# Because the LM in keycode.ncl is broken
let LM = fun behaviour layer mod tap => LT behaviour layer tap & mod in

# For modified layers (that emulate key overrides), cancel the modifier before pressing the key and
# reinstate the modifier when done. (This can result in a stuck modifier in some cases, which is
# why we have Reset on the Meta layer!)
let LiftMod_Tap = fun modifier key => macro.make [
                                                  macro.release modifier,
                                                  macro.press key,
                                                  macro.pause_for_release,
                                                  macro.release key,
                                                  macro.press modifier
                                                ] in

let ModHold = fun mod key => macro.make [
                                      macro.press mod,
                                      macro.press key,
                                      macro.pause_for_release,
                                      macro.release key,
                                      macro.release mod
                                    ] in
let MacroTap = fun keys => macro.make (std.array.map (fun key => macro.tap key) keys) in
let CopyLayerWithOverrides = fun origin overrides =>
  std.array.map_with_index
    (fun index keycode => std.record.get_or (std.string.from_number index) keycode overrides)
    origin
in

# Named Layers
let layers = [
  "Base",
  "Sft",
  "Ctl",
  "Sym",
  "Num",
  "Fn",
] in
let L = std.record.from_array
          (std.array.map_with_index (fun index layer => { field = layer, value = index }) layers) in

# Tap-dances
let dances = {
#  CS = td.make 160 [kc.COMMA & mh.lsft & kh.SLSH, # tap = ,      hold = ?
#                    kc.SCLN  & kh.COMMA],         # tap-tap = ;  tap-hold = ,
#  DC = td.make 160 [kc.DOT   & mh.lsft & kh.N1,   # tap = .      hold = !
#                    ks.COLN  & macros.PD],        # tap-tap = :  tap-hold = ../

  Comma-SemiCln  = td.make 160 [kc.COMM,  kc.SCLN],
  Dot-Colon      = td.make 160 [kc.DOT,   ks.COLN],
  Q-Quote        = td.make 160 [kc.Q,     kc.QUOT],
  ShiftCapsWord1 = td.make 200 [md.lsft,  fa.CWTG],
  ShiftCapsWord2 = td.make 200 [LT {} L.Sft md.lsft & mh.lsft, fa.CWTG],
  ShiftCapsWord3 = td.make 200 [LT {} L.Sft tap.sticky.mod.lsft & mh.lsft, fa.CWTG],
  W-DoubleQuote  = td.make 160 [kc.W,     ks.DQUO],
} in

# Special key abbreviations
let AltH   = MT keyRepeatOnDoubleTap mh.ralt kc.H in
let AltLT  = MT keyRepeatOnDoubleTap mh.ralt ks.LABK in
let AltX   = MT keyRepeatOnDoubleTap mh.lalt kc.X in # LM keyRepeatOnDoubleTap L.Alt mh.lalt kc.X in
let AppBck = ModHold md.lgui kc.GRV in
let AppFwd = ModHold md.lgui kc.TAB in
let AppBkW = ModHold md.lalt & md.lsft kc.TAB in
let AppFdW = ModHold md.lalt kc.TAB in
let Cmd0   = MT keyRepeatOnDoubleTap mh.lgui kc.N0 in
let Ctl0   = MT keyRepeatOnDoubleTap mh.lctl kc.N0 in
let CmdK   = MT keyRepeatOnDoubleTap mh.rgui kc.K in
let CtlK   = MT keyRepeatOnDoubleTap mh.rctl kc.K in
let CmdTab = MT keyRepeatOnDoubleTap mh.lgui kc.TAB in
let CtlTab = MT keyRepeatOnDoubleTap mh.lctl kc.TAB in
let ComScl = dances.Comma-SemiCln in
let CtlF   = MT keyRepeatOnDoubleTap mh.rctl kc.F in
let CmdF   = MT keyRepeatOnDoubleTap mh.rgui kc.F in
let CtlGT  = MT keyRepeatOnDoubleTap mh.rctl ks.RABK in
let CmdGT  = MT keyRepeatOnDoubleTap mh.rcmd ks.RABK in
let CtlZ   = LM keyRepeatOnDoubleTap L.Ctl mh.lctl kc.Z in # MT keyRepeatOnDoubleTap mh.lctl kc.Z in
let CmdZ   = LM keyRepeatOnDoubleTap L.Ctl mh.lgui kc.Z in # MT keyRepeatOnDoubleTap mh.lgui kc.Z in
let DelWrd = md.lalt & kc.BSPC in
let DotCln = dances.Dot-Colon in
let MinSft = MT keyRepeatOnDoubleTap mh.rsft kc.MINS in
let NumEnt = LT keyRepeatOnDoubleTap L.Num kc.ENT in
let PncSft = MT keyRepeatOnDoubleTap mh.rsft ks.EXLM in
let QQuote = dances.Q-Quote in
let SftCap = dances.ShiftCapsWord3 in
let SftSla = MT keyRepeatOnDoubleTap mh.rsft kc.SLSH in
let SymSpc = LT keyRepeatOnDoubleTap L.Sym kc.SPC in
let UnGLBr = LiftMod_Tap md.lgui kc.LBRC in
let UnGRBr = LiftMod_Tap md.lgui kc.RBRC in
let WDQuot = dances.W-DoubleQuote in

# Keymap definition

let baseLayer = [
          QQuote, WDQuot, kc.D,   kc.P,                       kc.L,   kc.O,   kc.Y,   kc.BSPC,
  kc.ESC,                                 kc.G,       kc.M,                                   kc.EQL,
          kc.A,   kc.R,   kc.S,   kc.T,                       kc.N,   kc.E,   kc.I,   kc.U,
  SftCap,                                 kc.B,       CmdK,                                   MinSft,
          CtlZ,   AltX,   kc.C,   kc.V,                       AltH,   CtlF,   ComScl, DotCln,
                                  CmdTab, SymSpc,     NumEnt, kc.UP,
                                                      kc.LEFT,XXX,kc.RGHT,
                                                            kc.DOWN,
  # Combos
  kc.N1,
  kc.N2,
  kc.N3,
  kc.N4,
  kc.N5,
  kc.F,
  kc.J,
  kc.N0,
  MacroTap [kc.DOT, kc.DOT, kc.SLSH],
] in

let transparentLayer = std.array.replicate (std.array.length baseLayer) TTT in

let shiftedLayerOverrides = {
   "7" = LiftMod_Tap md.lsft kc.DEL,
  "30" = kc.N9,
  "31" = kc.N0,
  "48" = MacroTap [kc.N9, kc.N0],
} in
let shiftedBaseLayer = CopyLayerWithOverrides transparentLayer shiftedLayerOverrides in

let controledLayerOverrides = {
  "20" = md.lsft,
  "30" = LiftMod_Tap md.lctl kc.LBRC,
  "31" = LiftMod_Tap md.lctl kc.RBRC,
  "47" = XXX,
  "48" = LiftMod_Tap md.lctl (MacroTap [kc.LBRC, kc.RBRC]),
} in
let controledBaseLayer = CopyLayerWithOverrides transparentLayer controledLayerOverrides in

{
  virtual_keys = [
    combo.make 30 [8, 0],
    combo.make 30 [0, 1],
    combo.make 30 [1, 2],
    combo.make 30 [2, 3],
    combo.make 30 [3, 9],
    combo.make 30 [9, 21],
    combo.make 30 [10, 22],
    combo.make 30 [24, 25],
    combo.make 30 [30, 31],
  ],
  layers = [
    baseLayer,
    shiftedBaseLayer,
    controledBaseLayer,
    [ # Symbol Layer (L.Sym)
              AppBck,AppFwd,kc.UP,  kc.F3,                      ks.TILD,ks.ASTR,ra.LBRC,DelWrd,
      TTT,                                    ks.AT,      Ra.MINS,                                ra.RBRC,
              Ra.RBRC,kc.LEFT,kc.DOWN,kc.RGHT,                    ra.MINS,ra.SCLN,ks.PIPE,ks.DLR,
      kc.CAPS,                                mc.BK,      kc.GRV,                                 Ra.RBRC,
              ks.PERC,ks.AMPR,ks.CIRC,TTT,                        ks.HASH,ra.RBRC,kc.BSLS,kc.SLSH,
                                      TTT,    TTT,        MO L.Fn,kc.PGUP,
                                                            kc.HOME,XXX,kc.END,
                                                                  kc.PGDN,
      # Combos
      XXX,
      XXX,
      XXX,
      XXX,
      XXX,
      ra.LBRC,
      Ra.LBRC,
      XXX,
      XXX,
    ],
    [ # Number Layer (L.Num)
              kc.PAST,  kc.N7,  kc.N8,  kc.N9,                    ks.LCBR,ks.RCBR,kc.Y,   kc.BSPC,
      kc.ESC,                                 kc.PPLS,    kc.PMNS,                                kc.EQL,
              kc.PSLS,  kc.N4,  kc.N5,  kc.N6,                    kc.LBRC,kc.RBRC,ks.PIPE,ks.DLR,
      md.lsft,                                kc.PDOT,    kc.GRV,                                 MinSft,
              kc.PEQL,  kc.N1,  kc.N2,  kc.N3,                    AltLT,  CtlGT,  ks.QUES,ks.EXLM,
                                      Cmd0,   kc.PENT,    TTT,      TTT,
                                                                TTT,TTT,TTT,
                                                                    TTT,
      # Combos
      XXX,
      XXX,
      XXX,
      XXX,
      XXX,
      XXX,
      XXX,
      XXX,
      XXX,
    ],
    [ # Function/Meta Layer (L.Fn)
              kc.F2,  kc.F3,  kc.F4,  kc.F5,                      kc.F7,  kc.F8,  kc.F9,  kc.F10,
      kc.F1,                                  Lg.N4,      kc.F6,                                  kc.F11,
              XXX,    XXX,    XXX,    XXX,                        XXX,    XXX,    XXX,    XXX,
      XXX,                                    XXX,        me.MUTE,                                kc.F12,
              mc.M1,  mc.M2,  XXX,    XXX,                        ms.BTN1,ms.BTN2,me.VOLD,me.VOLU,
                                      TTT,    TTT,        TTT,    ms.UP,
                                                           ms.LEFT,XXX,ms.RGHT,
                                                                 ms.DOWN,
      # Combos
      fa.BOOT,
      XXX,
      XXX,
      XXX,
      fa.REST,
      XXX,
      XXX,
      XXX,
      XXX,
    ],
  ]
}
