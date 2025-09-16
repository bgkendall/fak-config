let { tap, hold, td, combo, macro, MO, LT, .. } = import "fak/keycode.ncl" in
let mc = import "private/macros.ncl" in

# Common aliases
let kc  = tap.reg.kc in
let ks  = tap.reg.ks in
# let kh  = hold.reg.kc in
let md  = tap.reg.mod in
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

let CommandHold = fun key => macro.make [
                                          macro.press md.lgui,
                                          macro.press key,
                                          macro.pause_for_release,
                                          macro.release key,
                                          macro.release md.lgui
                                        ] in

# Layer Names
let LBase = 0 in
let LShft = 1 in
let LAlt  = 2 in
let LCtrl = 3 in
let LSymb = 4 in
let LNumb = 5 in
let LMeta = 6 in

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
  ShiftCapsWord2 = td.make 200 [LT {} LShft md.lsft & mh.lsft, fa.CWTG],
  ShiftCapsWord3 = td.make 200 [LT {} LShft tap.sticky.mod.lsft & mh.lsft, fa.CWTG],
  W-DoubleQuote  = td.make 160 [kc.W,     ks.DQUO],
} in

# Special key abbreviations
let AltH   = MT keyRepeatOnDoubleTap mh.ralt kc.H in
let AltLT  = MT keyRepeatOnDoubleTap mh.ralt ks.LABK in
let AltX   = LM keyRepeatOnDoubleTap LAlt mh.lalt kc.X in # MT keyRepeatOnDoubleTap mh.lalt kc.X in
let AppBck = CommandHold kc.GRV in
let AppFwd = CommandHold kc.TAB in
let Cmd0   = MT keyRepeatOnDoubleTap mh.lgui kc.N0 in
let CmdK   = MT keyRepeatOnDoubleTap mh.rgui kc.K in
let CmdTab = MT keyRepeatOnDoubleTap mh.lgui kc.TAB in
let ComScl = dances.Comma-SemiCln in
let CtlF   = MT keyRepeatOnDoubleTap mh.rctl kc.F in
let CtlGT  = MT keyRepeatOnDoubleTap mh.rctl ks.RABK in
let CtlZ   = LM keyRepeatOnDoubleTap LCtrl mh.lctl kc.Z in # MT keyRepeatOnDoubleTap mh.lctl kc.Z in
let DelWrd = md.lalt & kc.BSPC in
let DotCln = dances.Dot-Colon in
let MinSft = MT keyRepeatOnDoubleTap mh.rsft kc.MINS in
let NumEnt = LT keyRepeatOnDoubleTap LNumb kc.ENT in
let QQuote = dances.Q-Quote in
let SftCap = dances.ShiftCapsWord3 in
let SftSla = MT keyRepeatOnDoubleTap mh.rsft kc.SLSH in
let SymSpc = LT keyRepeatOnDoubleTap LSymb kc.SPC in
let UnAGt  = LiftMod_Tap md.lalt ks.RABK in
let UnALt  = LiftMod_Tap md.lalt ks.LABK in
let UnCLBr = LiftMod_Tap md.lctl kc.LBRC in
let UnCRBr = LiftMod_Tap md.lctl kc.RBRC in
let UnSDel = LiftMod_Tap md.lsft kc.DEL in
let WDQuot = dances.W-DoubleQuote in

# Keymap definition
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
    [ # Base Layer
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
    mc.PD,
  ],
  [ # Shifted Layer (for key overrides)
            TTT,    TTT,    TTT,    TTT,                        TTT,    TTT,    TTT,    UnSDel,
    TTT,                                    TTT,        TTT,                                    TTT,
            TTT,    TTT,    TTT,    TTT,                        TTT,    TTT,    TTT,    TTT,
    TTT,                                    TTT,        TTT,                                    TTT,
            TTT,    TTT,    TTT,    TTT,                        TTT,    TTT,    kc.N9,  kc.N0,
                                    TTT,    TTT,        TTT,    TTT,
                                                            TTT,TTT,TTT,
                                                                TTT,
    # Combos
    TTT,
    TTT,
    TTT,
    TTT,
    TTT,
    TTT,
    TTT,
    TTT,
    TTT,
  ],
  [ # Alt-ed Layer (for key overrides)
            TTT,    TTT,    TTT,    TTT,                        TTT,    TTT,    TTT,    TTT,
    TTT,                                    TTT,        TTT,                                    TTT,
            TTT,    TTT,    TTT,    TTT,                        TTT,    TTT,    TTT,    TTT,
    md.lsft,                                TTT,        TTT,                                    TTT,
            TTT,    TTT,    TTT,    TTT,                        TTT,    TTT,    UnALt,  UnAGt,
                                    TTT,    TTT,        TTT,    TTT,
                                                            TTT,TTT,TTT,
                                                                TTT,
    # Combos
    TTT,
    TTT,
    TTT,
    TTT,
    TTT,
    TTT,
    XXX,
    XXX,
    XXX,
  ],
  [ # Controled Layer (for key overrides)
            TTT,    TTT,    TTT,    TTT,                        TTT,    TTT,    TTT,    TTT,
    TTT,                                    TTT,        TTT,                                    TTT,
            TTT,    TTT,    TTT,    TTT,                        TTT,    TTT,    TTT,    TTT,
    md.lsft,                                TTT,        TTT,                                    TTT,
            TTT,    TTT,    TTT,    TTT,                        TTT,    TTT,    UnCLBr, UnCRBr,
                                    TTT,    TTT,        TTT,    TTT,
                                                            TTT,TTT,TTT,
                                                                TTT,
    # Combos
    TTT,
    TTT,
    TTT,
    TTT,
    TTT,
    TTT,
    XXX,
    XXX,
    XXX,
  ],
  [ # Symbol Layer
              AppBck,AppFwd,kc.UP,  kc.F3,                      ks.TILD,ks.ASTR,ra.LBRC,DelWrd,
      TTT,                                    ks.AT,      Ra.MINS,                                ra.RBRC,
              Ra.RBRC,kc.LEFT,kc.DOWN,kc.RGHT,                    ra.MINS,ra.SCLN,ks.PIPE,ks.DLR,
      kc.CAPS,                                mc.BK,      kc.GRV,                                 Ra.RBRC,
              ks.PERC,ks.AMPR,ks.CIRC,TTT,                        ks.HASH,TTT,    kc.BSLS,kc.SLSH,
                                      TTT,    TTT,       MO LMeta,kc.PGUP,
                                                            kc.HOME,XXX,kc.END,
                                                                  kc.PGDN,
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
    [ # Number Layer
              kc.PAST,  kc.N7,  kc.N8,  kc.N9,                    ks.LCBR,ks.RCBR,kc.Y,   kc.BSPC,
      kc.ESC,                                 kc.PPLS,    kc.PMNS,                                kc.EQL,
              kc.PSLS,  kc.N4,  kc.N5,  kc.N6,                    kc.LBRC,kc.RBRC,kc.I,   kc.U,
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
    [ # Meta Layer
              kc.F2,  kc.F3,  kc.F4,  kc.F5,                      kc.F7,  kc.F8,  kc.F9,  kc.F10,
        kc.F1,                                  Lg.N4,      kc.F6,                                  kc.F11,
              XXX,    XXX,    XXX,    XXX,                        XXX,    XXX,    XXX,    XXX,
      XXX,                                    XXX,        XXX,                                    XXX,
              md.lctl,md.lalt,XXX,    XXX,                        ms.BTN1,ms.BTN2,XXX,    XXX,
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
