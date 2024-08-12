let { DirectPinKey, .. } = import "fak/keyboard.ncl" in
let { CH552E, .. } = import "fak/mcus.ncl" in

{
  mcu = CH552E,
  usb_dev = {
    vendor_id = 51966,  # 0xCAFE
    product_id = 47806, # 0xBABE
    product_ver = 257,  # 0x0100
  },
  keys =
    let D = DirectPinKey in
    [
        D 15, D 16, D 14
    ]
}
