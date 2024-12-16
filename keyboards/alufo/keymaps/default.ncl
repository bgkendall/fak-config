let { tap, hold, combo, td, LT, .. } = import "fak/keycode.ncl" in
let macros = import "private/macros.ncl" in

# Common aliases
let kc   = tap.reg.kc in
let ks   = tap.reg.ks in
let kh   = hold.reg.kc in
let md   = tap.reg.mod in
let mh   = hold.reg.mod in
let fa   = tap.custom.fak in
let S    = fun key => md.lsft & key in
let A    = fun key => md.lalt & key in
let MT   = fun modifier tap => hold.reg.behavior {} & modifier & tap in
let LT'  = fun layer tap => LT {} layer tap in
let XXXX = tap.none & hold.none in
let TTTT = tap.trans & hold.trans in

let dance = {
  CS = td.make 160 [kc.COMMA & mh.lsft & kh.SLSH, # tap = ,  hold = ?
                    kc.SEMI  & kh.COMMA],         # tap-tap = ;  tap-hold = ,
  DC = td.make 160 [kc.DOT   & mh.lsft & kh.N1,   # tap = .  hold = !
                    ks.COLN  & macros.PD],        # tap-tap = :  tap-hold = ../
} in

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
    combo.make 50 [30, 31]
  ],
  layers = [
    [ # Layer 0
            kc.Q,   kc.W,   kc.D,   kc.P,                 kc.L,   kc.O,   kc.Y,   kc.BSPC,
      kc.ESC,                             kc.G,   kc.M,                                     kc.EQL,
            kc.A,   kc.R,   kc.S,   kc.T,                 kc.N,   kc.E,   kc.I,   kc.U,
      md.lsft,                            kc.B,   kc.K,                                     kc.MINS,
            kc.Z,   kc.X,   kc.C,   kc.V,                 kc.H,   dance.CS,dance.DC,kc.SLSH,
                         MT mh.lgui kc.TAB, LT' 1 kc.SPC, LT' 2 kc.ENT,   kc.UP,
                                                                  kc.LEFT,XXXX, kc.RIGHT,
                                                                          kc.DOWN,
      # Combos
      kc.N1,
      kc.N2,
      kc.N3,
      kc.N4,
      kc.N5,
      kc.N0,
      fa.CWTG,
      macros.PD
    ]
  ]
}
