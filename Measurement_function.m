function [data_out,Result,LCR_ID] = Measurement_function(Voltage_min_in,Voltage_max_in,Frequency)
%Measurement_function LCR automation function
%   This is the Matlab function to contrl the LCR Meter to perform the measurement of the capacitance, voltage and current for the sample and dervie the data.
%   Voltage_min_in: The minimum input voltage (Minimun 0V)
%   Voltage_max_in: The maximum input voltage (Minimun 20V)
%   Frequency: The target frequency performing the measurement. (20Hz to 1MHz)
%   
%   Author: Zimo Zhao
%   Date: 02/11/2020
%   Dept. Engineering Science, University of Oxford, Oxford OX1 3PJ, UK
%   Website: http://wwww.eng.ox.ac.uk/smp

    %% Measurement Parameter Initialization
    VOLTAGE_MIN=Voltage_min_in;% V
    VOLTAGE_MAX=Voltage_max_in;% V
    LIST_MAX=10; % The Maximum number of measurements on one list.
    LIST_SIZE=120; % The total number of measurements to be performed.
    Voltage_Sequence=VOLTAGE_MIN:(VOLTAGE_MAX-VOLTAGE_MIN)/(LIST_SIZE):VOLTAGE_MAX; % 120 is determined by the device limitation (MAX 126).
    Voltage_Sequence=round(Voltage_Sequence(2:end),4);  % resize to 120 elements, with 4 digits accuracy.
    [~,m]=size(Voltage_Sequence);
    list_loop=m/LIST_MAX;
    clear m;
    Voltage_Reshape=reshape(Voltage_Sequence,LIST_MAX,list_loop);
    Voltage_String=strings([list_loop,1]);
    for i=1:1:list_loop
        V_string=num2str(Voltage_Reshape(:,i));
        for k=1:1:LIST_MAX
            Voltage_String(i)=Voltage_String(i)+V_string(k,:)+',';
        end
    end
    clear i;
    clear k;
    clear V_string;
    % The measurement list has been generated.

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

    % Connect to instrument object LCR.
    LCR.InputBufferSize=5120; % Increase the receiver buffer to read the data in one transmission.
    fopen(LCR);

    %% Instrument Configuration and Control

    % Communicating with instrument object, obj1.
    LCR_ID = query(LCR, '*IDN?');
    fprintf(LCR, '*RST');
    fprintf(LCR, '*CLS');

    % The parameter here determine the P1 and P2 in the result array. Refer the instrument manual for detail. 
    fprintf(LCR, 'FUNCtion:IMPedance:TYPE CPD;');% FUNCtion:IMPedance:TYPE <function> % CPD ----> P1 <=C_{p}, P2 <= D

    fprintf(LCR, 'FUNCtion:SMONitor:VAC:STATe ON;');% FUNCtion:SMONitor:VAC:STATe [ON/OFF]
    fprintf(LCR, 'FUNCtion:SMONitor:IAC:STATe ON;');% FUNCtion:SMONitor:IAC:STATe [ON/OFF]
    fprintf(LCR, 'VOLTage:LEVel %fV;',VOLTAGE_MIN);% VOLTage:LEVel [<value>/MAX/MIN]
    fprintf(LCR, 'FREQuency:CW %f;',Frequency);% FREQuency:CW [<value>/MAX/MIN]
	pause(5);% Wait for the intial state switching
    fprintf(LCR, 'APERture LONG;');% APERture [SHORt/MEDium/LONG] [,<value>]
    fprintf(LCR, 'TRIGger:DELay 0.3;');% TRIGger:DELay [<value>/MAX/MIN]
    fprintf(LCR, 'FORMat:DATA ASCii;');% FORMat[:DATA?] [ASCii/REAL[,64]]
    fprintf(LCR, 'MEMory:DIM DBUF,128;');% MEMory:DIM DBUF,<value>
    fprintf(LCR, 'MEMory:CLEar DBUF;');% MEMory:CLEar DBUF
    fprintf(LCR, 'TRIGger:SOURce BUS;');% TRIGger:SOURce [INTernal/EXTernal/BUS/HOLD]
    fprintf(LCR, 'DISPlay:PAGE LIST;');% DISPlay:PAGE <page name>
    fprintf(LCR, 'LIST:MODE STEPped;');% LIST:MODE [SEQuence/STEPped]
    fprintf(LCR, 'INITiate:CONTinuous ON;');% INITiate:CONTinuous [ON/OFF]
    fprintf(LCR, 'MEMory:FILL DBUF;');% MEMory:FILL DBUF
    for i=1:1:list_loop
        fprintf(LCR, 'LIST:VOLTage %s;',Voltage_String(i));% LIST:VOLTage <value> [,<value>*]
        for k=1:1:LIST_MAX
            fprintf(LCR, 'TRIGger:IMMediate;');% TRIGger[:IMMediate]
            while(str2double(query(LCR,';*OPC?;'))~=1.0)
            end
            data=query(LCR, 'MEMory:READ? DBUF;');% MEMory:READ? DBUF
            fprintf(LCR, 'MEMory:CLEar DBUF;');% MEMory:CLEar DBUF
            data_num=str2num(data);
            [~,m]=size(data_num);
            data_reshape=reshape(data_num,4,m/4);
            data_final=data_reshape';
            data_Result(((i-1)*LIST_MAX+k),1)=Voltage_Reshape(k,i);
            data_Result(((i-1)*LIST_MAX+k),2:3)=data_final(1,1:2);
            IAC=query(LCR, 'FETCh:SMONitor:IAC?;');% FETCh:SMONitor:VAC?
            data_Result(((i-1)*LIST_MAX+k),4)=str2num(IAC);
            fprintf(LCR, 'MEMory:CLEar DBUF;');% MEMory:CLEar DBUF
            fprintf(LCR, 'MEMory:FILL DBUF;');% MEMory:FILL DBUF
        end
    end
    Result.V=data_Result(:,1);
    Result.P1=data_Result(:,2); 
    Result.P2=data_Result(:,3);
    Result.I=data_Result(:,4);
    clear data;
    clear data_num;
    clear data_reshape;
    clear m;
    clear i;

    %% Disconnect and Clean Up

    % Disconnect from instrument object, obj1.
    fclose(LCR);

    % The following code has been automatically generated to ensure that any
    % object manipulated in TMTOOL has been properly disposed when executed
    % as part of a function or script.

    % Clean up all objects.
    delete(LCR);
    clear LCR;
    
    %% Output the results
    data_out=data_Result;
end

