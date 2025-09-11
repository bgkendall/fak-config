let { ColToRowKey, PeripheralSideKey, .. } = import "fak/keyboard.ncl" in
let { CH552T, .. } = import "fak/mcus.ncl" in

let side_central = {
  mcu = CH552T,
  matrix = {
    cols = [16, 17, 15, 33, 34, 35],
    rows = [13, 10, 11]
  },
  split.channel = CH552T.features.uart_30_31
} in

let side_periph = {
  mcu = CH552T,
  matrix = {
    cols = [14, 15, 16, 17, 10, 11],
    rows = [32, 31, 30, 33]
  },
  split.channel = CH552T.features.uart_12_13,
  keys =
    let K = ColToRowKey in
    [
              K 1 0,  K 2 0,  K 3 0,  K 4 0,
      K 0 0,                                  K 5 0,
              K 1 1,  K 2 1,  K 3 1,  K 4 1,
      K 0 1,                                  K 5 1,
              K 1 2,  K 2 2,  K 3 2,  K 4 2,
      K 0 3,      K 1 3,
           K 2 3, K 3 3, K 4 3,
                  K 5 3
    ]
} in

side_central & {
  usb_dev = {
    vendor_id = 51966,  # 0xCAFE
    product_id = 44800, # 0xAF00
    product_ver = 256,  # 0x0100
  },
  split.peripheral = side_periph,
  keys =
    let L = ColToRowKey in
    let R = PeripheralSideKey in
    [
             L 1 0, L 2 0, L 3 0, L 4 0,                  R   0, R   1, R   2, R   3,
      L 0 0,                             L 5 0,    R   4,                             R   5,
             L 1 1, L 2 1, L 3 1, L 4 1,                  R   6, R   7, R   8, R   9,
      L 0 1,                             L 5 1,    R  10,                             R  11,
             L 0 2, L 1 2, L 2 2, L 3 2,                  R  12, R  13, R  14, R  15,
                                  L 4 2, L 5 2,    R  16, R  17,
                                                   R  18, R  19, R  20,
                                                          R  21
    ]
}
