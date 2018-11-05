# Create C/C++ array header utility

This script utility is useful when convering a FPGA configuration binary file to a C array header file.

This is useful in embedding the FPGA configuration as rodata within the firmware in non volatile storage, for an external processor.

The PHY interfaces between the FPGA and processor can be by bitbanged JTAG, slave serial among other compatible schemes.

After generation of the array representation it is prudent to :

1. Add the size of the array within the square brackets manually after generation rather than deffering it to the compiler to infer the size.
2. Qualify the array as const to mark it as read only and read always read from ROM.

## Dependencies

xxd utility.

## Usage

`bash mkarray.sh infile`

Where infile is the name of the input binary file.