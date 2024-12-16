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
              kc.L,   kc.O,   kc.Y,   kc.BSPC,
      kc.M,                                   kc.EQL,
              kc.N,   kc.E,   kc.I,   kc.U,
      kc.K,                                   kc.MINS,
              kc.H,   kc.COMM,kc.DOT, kc.SLSH,
      kc.ENT,       kc.UP,
            kc.LEFT,kc.SPC, kc.RIGHT,
                    kc.DOWN
    ]
  ]
}
