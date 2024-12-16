let { tap, hold, combo, LT, .. } = import "fak/keycode.ncl" in
let macros = import "private/macros.ncl" in

# Common aliases
let kc   = tap.reg.kc in
let md   = tap.reg.mod in
let mh   = hold.reg.mod in
let fa   = tap.custom.fak in
let S    = fun key => md.lsft & key in
let A    = fun key => md.lalt & key in
let MT   = fun modifier tap => hold.reg.behavior {} & modifier & tap in
let LT'  = fun layer tap => LT {} layer tap in
let XXXX = tap.none & hold.none in
let TTTT = tap.trans & hold.trans in

# Keymap definition
{
  layers = [
    [ # Layer 0
              kc.Q,  kc.W,  kc.D,  kc.P,
      kc.ESC,                             kc.G,
              kc.A,  kc.R,  kc.S,  kc.T,
      md.lsft,                            kc.B,
              kc.Z,  kc.X,  kc.C,  kc.V,
                                md.lgui,kc.SPC
    ]
  ]
}
