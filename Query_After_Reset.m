%% TEST_SESSION Code for communicating with an instrument.
%
%   This is the machine generated representation of an instrument control
%   session. The instrument control session comprises all the steps you are
%   likely to take when communicating with your instrument. These steps are:
%   
%       1. Instrument Connection
%       2. Instrument Configuration and Control
%       3. Disconnect and Clean Up
% 
%   To run the instrument control session, type the name of the file,
%   test_session, at the MATLAB command prompt.
% 
%   The file, TEST_SESSION.M must be on your MATLAB PATH. For additional information 
%   on setting your MATLAB PATH, type 'help addpath' at the MATLAB command 
%   prompt.
% 
%   Example:
%       test_session;
% 
%   See also SERIAL, GPIB, TCPIP, UDP, VISA, BLUETOOTH, I2C, SPI.
% 
%   Creation time: 16-Nov-2020 14:00:56

%% Instrument Connection

% Find a VISA-GPIB object.
LCR = instrfind('Type', 'visa-gpib', 'RsrcName', 'GPIB0::8::INSTR', 'Tag', '');

% Create the VISA-GPIB object if it does not exist
% otherwise use the object that was found.
if isempty(LCR)
    LCR = visa('KEYSIGHT', 'GPIB0::8::INSTR');
else
    fclose(LCR);
    LCR = LCR(1);
end

% Connect to instrument object, obj1.
fopen(LCR);

%% Instrument Configuration and Control

% Communicating with instrument object, obj1.
LCR_Id = query(LCR, '*IDN?');
fprintf(LCR, '*RST');

% DISPlay Subsystem
screen=query(LCR, 'DISPlay:PAGE?;');% DISPlay:PAGE <page name>
% % MEASurement BNUMber BCOunt LIST MSETup CSETup LTABle LSETup CATalog SYSTem SELF
% fprintf(LCR, 'DISPlay:LINE ""TEST"";');% DISPlay:LINE "<string>"

% FREQuency Subsystem
frequency=query(LCR, 'FREQuency:CW?;');% FREQuency:CW [<value>/MAX/MIN]

% VOLTage Subsystem
voltage=query(LCR, 'VOLTage:LEVel?;');% VOLTage:LEVel [<value>/MAX/MIN]

% CURRent Subsystem
% current=query(LCR, 'CURRent:LEVel?;');% CURRent:LEVel [<value>/MAX/MIN] % voltage mode disabled

% AMPLitude Subsystem
amplitude=query(LCR, 'AMPLitude:ALC?;');% AMPLitude:ALC [ON/OFF]

% OUTPut Subsystem
out_power=query(LCR, 'OUTPut:HPOWer?;');% OUTPut:HPOWer [ON/OFF]
out_dc_power=query(LCR, 'OUTPut:DC:ISOLation?;');% OUTPut:DC:ISOLation [ON/OFF]

% BIAS Subsystem
bias_state=query(LCR, 'BIAS:STATe?;');% BIAS:STATe [ON/OFF]
bias_voltage=query(LCR, 'BIAS:VOLTage:LEVel?;');% BIAS:VOLTage:LEVel [<value>/MAX/MIN]
%bias_current=query(LCR, 'BIAS:CURRent:LEVel?;');% BIAS:CURRent:LEVel [<value>/MAX/MIN] % voltage mode disabled

% FUNCtion Subsystem
function_type=query(LCR, 'FUNCtion:IMPedance:TYPE?;');% FUNCtion:IMPedance:TYPE <function>
% % CPD Sets function to Cp-D     % LPRP Sets function to Lp-Rp
% % CPQ Sets function to Cp-Q     % LSD Sets function to Ls-D
% % CPG Sets function to Cp-G     % LSQ Sets function to Ls-Q
% % CPRP Sets function to Cp-Rp   % LSRS Sets function to Ls-Rs
% % CSD Sets function to Cs-D     % RX Sets function to R-X
% % CSQ Sets function to Cs-Q     % ZTD Sets function to Z-(deg)
% % CSRS Sets function to Cs-Rs   % ZTR Sets function to Z-(rad)
% % LPQ Sets function to Lp-Q     % GB Sets function to G-B
% % LPD Sets function to Lp-D     % YTD Sets function to Y-(deg)
% % LPG Sets function to Lp-G     % YTR Sets function to Y-(rad)
function_range=query(LCR, 'FUNCtion:IMPedance:RANGe?;');% FUNCtion:IMPedance:RANGe <value>
% %10 100 300 1000 3000 10000 30000 100000 (1 if Option 001 is installed)
function_range_auto=query(LCR, 'FUNCtion:IMPedance:RANGe:AUTO?;');% FUNCtion:IMPedance:RANGe:AUTO [ON/OFF]
function_VAC=query(LCR, 'FUNCtion:SMONitor:VAC:STATe?;');% FUNCtion:SMONitor:VAC:STATe [ON/OFF]
function_IAC=query(LCR, 'FUNCtion:SMONitor:IAC:STATe?;');% FUNCtion:SMONitor:IAC:STATe [ON/OFF]
function_dev1_mode=query(LCR, 'FUNCtion:DEV1:MODE?;');% FUNCtion:DEV<n>:MODE [ABSolute/PERCent/OFF]
function_dev2_mode=query(LCR, 'FUNCtion:DEV2:MODE?;');% FUNCtion:DEV<n>:MODE [ABSolute/PERCent/OFF]
function_dev1_ref=query(LCR, 'FUNCtion:DEV1:REFerence?;');% FUNCtion:DEV<n>:REFerence <value>
function_dev2_ref=query(LCR, 'FUNCtion:DEV2:REFerence?;');% FUNCtion:DEV<n>:REFerence <value>
% fprintf(LCR, 'FUNCtion:DEV1:REFerence:FILL;');% FUNCtion:DEV<n>:REFerence:FILL
% fprintf(LCR, 'FUNCtion:DEV2:REFerence:FILL;');% FUNCtion:DEV<n>:REFerence:FILL

% LIST Subsystem
% list_freq=query(LCR, 'LIST:FREQuency?;');% LIST:FREQuency <value> [,<value>*]% 
% list_voltage=query(LCR, 'LIST:VOLTage?;');% LIST:VOLTage <value> [,<value>*]%
% list_current=query(LCR, 'LIST:CURRent?;');% LIST:CURRent <value> [,<value>*]%
% list_bias_voltage=query(LCR, 'LIST:BIAS:VOLTage?;');% LIST:BIAS:VOLTage <value> [,<value>*]% 
% list_bias_current=query(LCR, 'LIST:BIAS:CURRent?;');% LIST:BIAS:CURRent <value> [,<value>*]% 
list_mode=query(LCR, 'LIST:MODE?;');% LIST:MODE [SEQuence/STEPped]
% list_band=query(LCR, 'LIST:BAND<n>?;');% LIST:BAND<n> <parameter> [,<low limit n>,<high limit n>]%
% % <n> 1 to 10 (NR1) : Sweep point number
% % <parameter> is: A Limit setting enable for primary parameter
% %                 B Limit setting enable for secondary parameter
% %                 OFF Limit setting disable
% % <low limit n> NR1, NR2, or NR3 format : low limit for sweep point<n>
% % <high limit n> NR1, NR2, or NR3 format : high limit for sweep point<n>

% APERture Subsystem
aperture=query(LCR, 'APERture?;');% APERture [SHORt/MEDium/LONG] [,<value>]

% TRIGger Subsystem
% fprintf(LCR, 'TRIGger:IMMediate;');% TRIGger[:IMMediate]
trigger_source=query(LCR, 'TRIGger:SOURce?;');% TRIGger:SOURce [INTernal/EXTernal/BUS/HOLD]
trigger_delay=query(LCR, 'TRIGger:DELay?;');% TRIGger:DELay [<value>/MAX/MIN]

% INITiate Subsystem
% fprintf(INITiate:IMMediate;');% INIT[:IMM]
initiate_continuous=query(LCR, 'INITiate:CONTinuous?;');% INITiate:CONTinuous [ON/OFF]

% FETCh? Subsystem
% fprintf(LCR, 'FETCh:IMP?;');% FETCh[:IMP]?
fetch_VAC=query(LCR, 'FETCh:SMONitor:VAC?;');% FETCh:SMONitor:VAC?
fetch_IAC=query(LCR, 'FETCh:SMONitor:IAC?;');% FETCh:SMONitor:IAC?

% ABORt Subsystem
% fprintf(LCR, 'ABORt;');% ABORt

% FORMat Subsystem
format=query(LCR, 'FORMat:DATA?;');% FORMat[:DATA?] [ASCii/REAL[,64]]

% MEMory Subsystem
% fprintf(LCR, 'MEMory:DIM DBUF,3;');% MEMory:DIM DBUF,<value>
% fprintf(LCR, 'MEMory:FILL DBUF;');% MEMory:FILL DBUF
% fprintf(LCR, 'MEMory:CLEar DBUF;');% MEMory:CLEar DBUF
% fprintf(LCR, 'MEMory:READ? DBUF;');% MEMory:READ? DBUF

% CORRection Subsystem
correction_length=query(LCR, 'CORRection:LENGth?;');% CORRection:LENGth <value>
correction_method=query(LCR, 'CORRection:METHod?;');% CORRection:METHod [SINGle/MULTi]
% fprintf(LCR, 'CORRection:OPEN;');% CORRection:OPEN
correction_state=query(LCR, 'CORRection:OPEN:STATe?;');% CORRection:OPEN:STATe [ON/OFF]
% fprintf(LCR, 'CORRection:SHORt;');% CORRection:SHORt
correction_short_state=query(LCR, 'CORRection:SHORt:STATe?;');% CORRection:SHORt:STATe [ON/OFF]
correction_load_state=query(LCR, 'CORRection:LOAD:STATe?;');% CORRection:LOAD:STATe [ON/OFF]
correction_load_type=query(LCR, 'CORRection:LOAD:TYPE?;');% CORRection:LOAD:TYPE <function>
% % CPD Sets function to Cp-D     % LPRP Sets function to Lp-Rp
% % CPQ Sets function to Cp-Q     % LSD Sets function to Ls-D
% % CPG Sets function to Cp-G     % LSQ Sets function to Ls-Q
% % CPRP Sets function to Cp-Rp   % LSRS Sets function to Ls-Rs
% % CSD Sets function to Cs-D     % RX Sets function to R-X
% % CSQ Sets function to Cs-Q     % ZTD Sets function to Z-(deg)
% % CSRS Sets function to Cs-Rs   % ZTR Sets function to Z-(rad)
% % LPQ Sets function to Lp-Q     % GB Sets function to G-B
% % LPD Sets function to Lp-D     % YTD Sets function to Y-(deg)
% % LPG Sets function to Lp-G     % YTR Sets function to Y-(rad)
% correction_load_spot1_state=query(LCR, 'CORRection:LOAD:SPOT1:STATe?;');% CORRection:SPOT<n>:STATe [ON/OFF]%
% correction_load_spot1_frequency=query(LCR, 'CORRection:LOAD:SPOT1:FREQuency?;');% CORRection:LOAD:SPOT<n>:FREQuency <value>% 
% fprintf(LCR, 'CORRection:LOAD:SPOT1:OPEN;');% CORRection:LOAD:SPOT1:OPEN
% fprintf(LCR, 'CORRection:LOAD:SPOT1:SHORt;');% CORRection:LOAD:SPOT1:SHORt
% fprintf(LCR, 'CORRection:LOAD:SPOT1:LOAD;');% CORRection:LOAD:SPOT1:LOAD
% correction_load_spot1_load_standard=query(LCR, 'CORRection:LOAD:SPOT1:LOAD:STANdard?;');% CORRection:SPOT<n>:LOAD:STANdard <REF.A>,<REF.B>%
% % <n> is:
% % 1 State setting for FREQ1 point
% % 2 State setting for FREQ2 point
% % 3 State setting for FREQ3 point
% % <REF.A> is the NR1, NR2, or NR3 format: 
% % Primary parameter's reference v alue of the standard
% % <REF.B> is the NR1, NR2, or NR3 format: 
% % Secondary parameter's reference v alue of the standard
% correction_load_use=query(LCR, 'CORRection:LOAD:USE?;');% CORRection:USE <channel number>%
% correction_load_use_data=query(LCR, 'CORRection:LOAD:USE:DATA? 1;');% CORRection:USE:DATA? <channel number>
% % Returned format is :
% % <open1 A>, <open1 B>, <short1 A>, <short1 B>, <load1 A>, <load1 B>,
% % <open2 A>, <open2 B>, <short2 A>, <short2 B>, <load2 A>, <load2 B>,
% % <open3 A>, <open3 B>, <short3 A>, <short3 B>, <load3 A>, <load3 B>,
% % Where,
% % <open1/2/3 A> NR3 format : primary OPEN correction data at FREQ1/2/3.
% % <open1/2/3 B> NR3 format : secondary OPEN correction data at FREQ1/2/3.
% % <short1/2/3 A> NR3 format : primary SHORT correction data at FREQ1/2/3.
% % <short1/2/3 B> NR3 format : secondary SHORT correction data at FREQ1/2/3.
% % <load1/2/3 A> NR3 format : primary LOAD correction data at FREQ1/2/3.
% % <load1/2/3 B> NR3 format : secondary LOAD correction data at FREQ1/2/3.

% COMParator Subsystem
comparator_state=query(LCR, 'COMParator:STATe?;');% COMParator:STATe [ON/OFF]
comparator_mode=query(LCR, 'COMParator:MODE?;');% COMParator:MODE [ATOLerance/PTOLerance/SEQuence]
comparator_tolerance_nominal=query(LCR, 'COMParator:TOLerance:NOMinal?;');% COMParator:TOLerance:NOMinal  <value>
% comparator_tolerance_bin=query(LCR, 'COMParator:TOLerance:BIN1?;');% COMParator:TOLerance:BIN<n> <low limit>,<high limit>%
% <n> 1to 9 (NR1) : BIN number
% <low limit> NR1, NR2, or NR3 format : low limit v alue
% <high limit> NR1, NR2, or NR3 format : high limit value
comparator_sequence_bin=query(LCR, 'COMParator:SEQuence:BIN?;');% COMParator:SEQuence:BIN <BIN1 low limit>,<BIN1 high limit>,<BIN2 high limit>, ... , <BINn high limit>%
% comparator_secondary_limit=query(LCR, 'COMParator:SLIMit?;');% COMParator:SLIMit <low limit>,<high limit>% 
% <low limit> is the NR1, NR2, or NR3 format : low limit v alue
% <high limit> is the NR1, NR2, or NR3 format : high limit v alue
% comparator_auxiliary_bin=query(LCR, 'COMParator:Auxiliary BIN?;');% COMParator:Auxiliary BIN [ON/OFF]% 
comparator_swap=query(LCR, 'COMParator:SWAP?;');% COMParator:SWAP [ON/OFF]
% fprintf(LCR, 'COMParator:BIN:CLEar;');% COMParator:BIN:CLEar
comparator_bin_count_data=query(LCR, 'COMParator:BIN:COUNt:DATA?;');% COMParator:BIN:COUNt:DATA?
% % Returned F ormat is :
% % <BIN1 count>,<BIN2 count>, ..., <BIN9 count>,<OUT OF BIN count>, <AUX BIN count><NL^END>
% % Where,
% % <BIN1-9 count> NR1 format : count result of BIN1{9
% % <OUT OF BINS count> NR1 format : count result of OUT OF BINS
% % <AUX BIN count> NR1 format : count result of AUX BIN
% fprintf(LCR, COMParator:BIN:COUNt:CLEar?;');% COMParator:BIN:COUNt:CLEar

% Mass MEMory Subsystem
% fprintf(LCR, 'MMEMory:LOAD:STATe 0;');% MMEMory:LOAD:STATe <value>
% fprintf(LCR, 'MMEMory:LOAD:STORe 0;');% MMEMory:STORe:STATe <value>
% % <value> 0 to 9 (NR1) : record number for internal EEPROM
% %         10 to 19 (NR1) : record number for memory card

% SYSTem:ERRor?
system_error=query(LCR, 'SYSTem:ERRor?;');% SYSTem:ERRor?
% % Returned Format is: <number>,"<message>"
% % Where,
% % <number> NR1 format: error number For details, refer to Appendix B.
% % <message> ASCII string: error message For details, refer to Appendix B.

% STATus Subsystem
status_operation_event=query(LCR, 'STATus:OPERation:EVENt?;');% STATus:OPERation[:EVENt]?
% % Returned Format is: 
% % <value><NL^END>
% % Where,
% % <value> NR1 format : decimal expression of the contents of the operation status event register
% % The definition of each bit of the operation status event register is as follows.
% % Bit No.         Description
% % 15 - 5          Always 0 (zero)
% % 4               Measurement Complete Bit
% % 3               List Sweep Measuremen t Complete Bit
% % 2, 1            Always 0 (zero)
% % 0               Correction Data Measurement Complete Bit
status_operation_condition=query(LCR, 'STATus:OPERation:CONDition?;');% STATus:OPERation:CONDition?
% % Returned Format is :
% % <value><NL^END>
% % Where,
% % <value> NR1 format : decimal expression of the contents of the operation status condition register
% % The definition of each bit in the operation status condition register is as follows.
% % Bit No.         Description
% % 15 - 5          Always 0 (zero)
% % 4               Measuring Bit
% % 3               Sweeping Bit
% % 2, 1            Always 0 (zero)
% % 0               Measuring Correction Data Bit
% fprintf(LCR, 'STATus:OPERation:ENABle <value>;');% STATus:OPERation:ENABle <value>
% % Where,
% % <value> NR1 format : decimal expression of enable bits of the operation status event register
% % The definition of each bit in the operation status event register is as follows.
% % Bit No.         Description
% % 15 - 5          Always 0 (zero)
% % 4               Measurement Complete Bit
% % 3               List Sweep Measuremen t Complete Bit
% % 2, 1            Always 0 (zero)
% % 0               Correction Data Measurement Complete Bit

%% Disconnect and Clean Up

% Disconnect from instrument object, obj1.
fclose(LCR);

% The following code has been automatically generated to ensure that any
% object manipulated in TMTOOL has been properly disposed when executed
% as part of a function or script.

% Clean up all objects.
delete(LCR);
clear LCR;

