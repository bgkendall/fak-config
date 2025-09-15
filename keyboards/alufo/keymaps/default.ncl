let { tap, hold, combo, macro, td, LT, .. } = import "fak/keycode.ncl" in
let mc = import "private/macros.ncl" in

# Common aliases
let kc  = tap.reg.kc in
let ks  = tap.reg.ks in
# let kh  = hold.reg.kc in
let md  = tap.reg.mod in
let mh  = hold.reg.mod in
let mo  = fun layer => hold.reg.layer layer in
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
let ModTap     = fun modifier tap => hold.reg.behavior {} & modifier & tap in
let LayerTap   = fun layer tap => LT {} layer tap in
let LiftModTap = fun modifier key => macro.make [
                                                  macro.release modifier,
                                                  macro.press key,
                                                  macro.pause_for_release,
                                                  macro.release key,
                                                  macro.press modifier
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

  Comma-SemiCln  = td.make 160 [kc.COMM,                kc.SCLN],
  Dot-Colon      = td.make 160 [kc.DOT,                 ks.COLN],
  Shift-CapsWord = td.make 200 [md.lsft,                fa.CWTG],
  Shift_CapsWord = td.make 200 [md.lsft & mh.lsft & mo LShft & hold.reg.behavior {}, fa.CWTG],
  Alt-X          = td.make 160 [kc.X    & mh.lalt & mo LAlt  & hold.reg.behavior {}, kc.X],
  Control-Z      = td.make 160 [kc.Z    & mh.lctl & mo LCtrl & hold.reg.behavior {}, kc.Z],
  W-DoubleQuote  = td.make 160 [kc.W,                   ks.DQUO],
  Q-Quote        = td.make 160 [kc.Q,                   kc.QUOT],
  Shift-Minus    = td.make 160 [ModTap mh.rsft kc.MINS, kc.MINS],
  Space-Symbol   = td.make 160 [kc.SPC  &           mo LSymb & hold.reg.behavior {}, kc.SPC],
} in

# Special key abbreviations
let AltH   = ModTap mh.ralt kc.H in
let AltLT  = ModTap mh.ralt ks.LABK in
let AltX   = dances.Alt-X in # ModTap mh.lalt kc.X in
let Cmd0   = ModTap mh.lgui kc.N0 in
let CmdK   = ModTap mh.rgui kc.K in
let CmdTab = ModTap mh.lgui kc.TAB in
let ComScl = dances.Comma-SemiCln in
let CtlF   = ModTap mh.rctl kc.F in
let CtlGT  = ModTap mh.rctl ks.RABK in
let CtlZ   = dances.Control-Z in # ModTap mh.lctl kc.Z in
let DelWrd = md.lalt & kc.BSPC in
let DotCln = dances.Dot-Colon in
let MinSft = dances.Shift-Minus in # ModTap mh.rsft kc.MINS in
let NumEnt = LayerTap LNumb kc.ENT in
let QQuote = dances.Q-Quote in
let SftCap = dances.Shift_CapsWord in
let SftSla = ModTap mh.rsft kc.SLSH in
let SymSpc = dances.Space-Symbol in # LayerTap LSymb kc.SPC in
let UnAGt  = LiftModTap md.lalt ks.RABK in
let UnALt  = LiftModTap md.lalt ks.LABK in
let UnCLBr = LiftModTap md.lctl kc.LBRC in
let UnCRBr = LiftModTap md.lctl kc.RBRC in
let UnSDel = LiftModTap md.lsft kc.DEL in
let WDQuot = dances.W-DoubleQuote in

# Keymap definition
{
  virtual_keys = [
    combo.make 50 [8, 0],
    combo.make 50 [0, 1],
    combo.make 50 [1, 2],
    combo.make 50 [2, 3],
    combo.make 50 [3, 9],
    combo.make 50 [9, 21],
    combo.make 50 [24, 25],
    combo.make 50 [30, 31],
  ],
  layers = [
    [ # Base Layer
            QQuote, WDQuot, kc.D,   kc.P,                       kc.L,   kc.O,   kc.Y,   kc.BSPC,
    kc.ESC,                                 kc.G,       kc.M,                                   kc.EQL,
            kc.A,   kc.R,   kc.S,   kc.T,                       kc.N,   kc.E,   kc.I,   kc.U,
    SftCap,                                 kc.B,       CmdK,                                   MinSft,
            CtlZ,   AltX,   kc.C,   kc.V,                       AltH,   CtlF,   ComScl, DotCln,
                                    CmdTab, SymSpc,     NumEnt, kc.UP,
                                                         kc.LEFT,XXX,kc.RIGHT,
                                                               kc.DOWN,
    # Combos
    kc.N1,
    kc.N2,
    kc.N3,
    kc.N4,
    kc.N5,
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
    XXX,
    XXX,
    XXX,
  ],
  [ # Symbol Layer
              XXX,    XXX,    kc.UP,  kc.F3,                      ks.TILD,ks.ASTR,ra.LBRC,DelWrd,
      TTT,                                    ks.AT,      Ra.MINS,                                ra.RBRC,
              Ra.RBRC,kc.LEFT,kc.DOWN,kc.RGHT,                    ra.MINS,ra.SCLN,ks.PIPE,ks.DLR,
      kc.CAPS,                                mc.BK,      kc.GRV,                                 Ra.RBRC,
              ks.PERC,ks.AMPR,ks.CIRC,TTT,                        ks.HASH,TTT,    kc.BSLS,kc.SLSH,
                                      TTT,    TTT,       mo LMeta,kc.PGUP,
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
    ],
    [ # Meta Layer
              XXX,    XXX,    XXX,    XXX,                        XXX,    XXX,    XXX,    XXX,
      XXX,                                    Lg.N4,      XXX,                                    XXX,
              XXX,    XXX,    XXX,    XXX,                        XXX,    XXX,    XXX,    XXX,
      XXX,                                    XXX,        XXX,                                    XXX,
              md.lctl,md.lalt,XXX,    XXX,                        XXX,    XXX,    XXX,    XXX,
                                      TTT,    TTT,        TTT,    kc.UP,
                                                           kc.LEFT,XXX,kc.RIGHT,
                                                                 kc.DOWN,
      # Combos
      fa.BOOT,
      XXX,
      XXX,
      XXX,
      fa.REST,
      XXX,
      XXX,
      XXX,
    ],
  ]
}
