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
  virtual_keys = [
    combo.make 75 [0, 1],
    combo.make 25 [1, 2]
  ],
  layers = [
    [ # Layer 0
      LT' 2 kc.TAB,
      MT mh.lalt kc.ENTER,
      LT' 1 (S kc.TAB),
      # Combos
      XXXX,
      XXXX
    ],
    [ # Layer 1
      kc.UP,
      kc.DOWN,
      TTTT,
      # Combos
      macros.M1,
      XXXX
    ],
    [ # Layer 2
      TTTT,
      XXXX,
      XXXX,
      # Combos
      XXXX,
      fa.BOOT
    ]
  ]
}
