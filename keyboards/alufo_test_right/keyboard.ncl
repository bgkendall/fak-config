let { ColToRowKey, RowToColKey, .. } = import "fak/keyboard.ncl" in
let { CH552T, .. } = import "fak/mcus.ncl" in

{
  mcu = CH552T,
  usb_dev = {
    vendor_id = 51966,  # 0xCAFE
    product_id = 44800, # 0xAF00
    product_ver = 256,  # 0x0100
  },
  matrix = {
    cols = [32, 15, 16, 17, 10, 11],
    rows = [14, 31, 30, 33],
  },
  keys =
    let K = ColToRowKey in
    [
              K 1 0,  K 2 0,  K 3 0,  K 4 0,
      K 0 0,                                  K 5 0,
              K 1 1,  K 2 1,  K 3 1,  K 4 1,
      K 0 1,                                  K 5 1,
              K 1 2,  K 2 2,  K 3 2,  K 4 2,
      K 0 3,      K 3 3,
           K 2 3, K 1 3, K 4 3,
                  K 5 3
    ]
}
