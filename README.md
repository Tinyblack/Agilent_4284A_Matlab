# Agilent 4284A Precision LCR Meter control Matlab script

This is the Matlab function to contrl the LCR Meter to perform the measurement of the capacitance, voltage and current for the sample and dervie the data.

[Measurement_function.m](.\Measurement_function.m) is the core function to config and perform the measurement.

[LCR_Measurement.m](.\LCR_Measurement.m) is the front p[anel script to read and display the data from the measurement.

[Query_After_Resat.m](.\Query_After_Resat.m) contains all the commands to control the LCR meter.

The LCR meter is connect to the PC via GPIB cable.

The operating manual of Agilent 4284A is [here](https://www.keysight.com/gb/en/assets/9018-01389/user-manuals/9018-01389.pdf?success=true) (Login or Register on Keysight website may be required.)
