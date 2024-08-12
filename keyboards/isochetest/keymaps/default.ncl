let { tap, hold, combo, LT, .. } = import "fak/keycode.ncl" in

# Common aliases
let kc   = tap.reg.kc in
# let md   = tap.reg.mod in
# let mh   = hold.reg.mod in
let fa   = tap.custom.fak in
# let S    = fun key => md.lsft & key in
# let A    = fun key => md.lalt & key in
# let MT   = fun modifier tap => hold.reg.behavior {} & modifier & tap in
let LT'  = fun layer tap => LT {} layer tap in
let XXXX = tap.none & hold.none in
let TTTT = tap.trans & hold.trans in

# Keymap definition
{
  layers = [
    [ # Layer 0
      LT' 3 fa.CWTG,
      LT' 1 kc.A,
      LT' 2 kc.SPACE
    ],
    [ # Layer 1
      kc.SPACE,
      TTTT,
      LT' 2 kc.B
    ],
    [ # Layer 2
      fa.BOOT,
      TTTT,
      TTTT
    ],
    [ # Layer 3
      fa.BOOT,
      TTTT,
      TTTT
    ]
  ]
}
