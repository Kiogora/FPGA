onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+vio_core_0 -L xil_defaultlib -L xpm -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.vio_core_0 xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {vio_core_0.udo}

run -all

endsim

quit -force
