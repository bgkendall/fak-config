let { tap, hold, combo, td, LT, .. } = import "fak/keycode.ncl" in
let mc = import "private/macros.ncl" in

# Common aliases
let kc  = tap.reg.kc in
let ks  = tap.reg.ks in
# let kh  = hold.reg.kc in
let md  = tap.reg.mod in
let mh  = hold.reg.mod in
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
let ModTap    = fun modifier tap => hold.reg.behavior {} & modifier & tap in
let LayerTap  = fun layer tap => LT {} layer tap in

# Tap-dances
let dances = {
#  CS = td.make 160 [kc.COMMA & mh.lsft & kh.SLSH, # tap = ,      hold = ?
#                    kc.SCLN  & kh.COMMA],         # tap-tap = ;  tap-hold = ,
#  DC = td.make 160 [kc.DOT   & mh.lsft & kh.N1,   # tap = .      hold = !
#                    ks.COLN  & macros.PD],        # tap-tap = :  tap-hold = ../

  Shift-CapsWord = td.make 200 [md.lsft,
                                fa.CWTG],
  Comma-SemiCln  = td.make 160 [kc.COMM,
                                kc.SCLN],
  Dot-Colon      = td.make 160 [kc.DOT,
                                ks.COLN],
} in

# Special key abbreviations
let CmdTab = ModTap mh.lgui kc.TAB in
let ComScl = dances.Comma-SemiCln in
let DotCln = dances.Dot-Colon in
let NumEnt = LayerTap 0 kc.ENT in
let SftCap = dances.Shift-CapsWord in
let SftSla = ModTap mh.rsft kc.SLSH in
let SymSpc = LayerTap 1 kc.SPC in

# Keymap definition
{
  virtual_keys = [
    combo.make 50 [8, 0],
    combo.make 50 [0, 1],
    combo.make 50 [1, 2],
    combo.make 50 [2, 3],
    combo.make 50 [3, 9],
    combo.make 50 [24, 25],
    combo.make 50 [26, 27],
    combo.make 50 [30, 31],
  ],
  layers = [
    [ # Layer 0
              kc.Q,   kc.W,   kc.D,   kc.P,                       kc.L,   kc.O,   kc.Y,   kc.BSPC,
      kc.ESC,                                 kc.G,       kc.M,                                   kc.EQL,
              kc.A,   kc.R,   kc.S,   kc.T,                       kc.N,   kc.E,   kc.I,   kc.U,
      SftCap,                                 kc.B,       kc.K,                                   kc.MINS,
              kc.Z,   kc.X,   kc.C,   kc.V,                       kc.H,   ComScl, DotCln, SftSla,
                                      CmdTab, SymSpc,     NumEnt, kc.UP,
                                                           kc.LEFT,XXX,kc.RIGHT,
                                                                 kc.DOWN,
      # Combos
      kc.N1,
      kc.N2,
      kc.N3,
      kc.N4,
      kc.N5,
      kc.N0,
      fa.CWTG,
      mc.PD
    ],
    [ # Layer 1 (Sym)
              XXX,    XXX,    kc.UP,  kc.F3,                      ks.TILD,ks.ASTR,ra.LBRC,la.BSPC,
      TTT,                                    Lg.N4,      Ra.MINS,                                ra.RBRC,
              Ra.LBRC,kc.LEFT,kc.DOWN,kc.RGHT,                    ra.MINS,ra.SCLN,ks.PIPE,ks.DLR,
      kc.CAPS,                                mc.BK,      kc.GRV,                                 Ra.RBRC,
              ks.PERC,ks.AMPR,ks.CIRC,TTT,                        ks.HASH,kc.BSLS,kc.SLSH, TTT,
                                      TTT,    TTT,        XXX,    kc.PGUP,
                                                            kc.HOME,XXX,kc.END,
                                                                  kc.PGDN,
      # Combos
       kc.N1,
       kc.N2,
       kc.N3,
       kc.N4,
       kc.N5,
       kc.N0,
       fa.CWTG,
       mc.PD
    ],
  ]
}
