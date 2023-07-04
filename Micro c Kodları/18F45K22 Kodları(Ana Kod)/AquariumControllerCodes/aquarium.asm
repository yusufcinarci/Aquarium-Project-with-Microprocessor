
_start:

;aquarium.c,49 :: 		void start(){
;aquarium.c,50 :: 		feed=0;
	CLRF        _feed+0 
	CLRF        _feed+1 
;aquarium.c,51 :: 		LED = OFF;
	BCF         PORTD+0, 0 
;aquarium.c,52 :: 		FAN = OFF;
	BCF         PORTC+0, 6 
;aquarium.c,53 :: 		ANSELC = 0;    // PORTC = Digital I/O
	CLRF        ANSELC+0 
;aquarium.c,54 :: 		ANSELB = 0;
	CLRF        ANSELB+0 
;aquarium.c,55 :: 		TRISA0_bit=1; // RA0=Input.
	BSF         TRISA0_bit+0, BitPos(TRISA0_bit+0) 
;aquarium.c,56 :: 		TRISA1_bit=1;
	BSF         TRISA1_bit+0, BitPos(TRISA1_bit+0) 
;aquarium.c,58 :: 		TRISC=0;      // PORTC=Output. Bu LCD icin.
	CLRF        TRISC+0 
;aquarium.c,59 :: 		TRISD=0;      // PORTD=Output.
	CLRF        TRISD+0 
;aquarium.c,61 :: 		Keypad_Init();
	CALL        _Keypad_Init+0, 0
;aquarium.c,62 :: 		Lcd_Init();
	CALL        _Lcd_Init+0, 0
;aquarium.c,63 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;aquarium.c,64 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOVLW       12
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;aquarium.c,65 :: 		Lcd_Out(1,6, "174207005");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       6
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr3_aquarium+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr3_aquarium+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;aquarium.c,66 :: 		Lcd_Out(2,4, "Yusuf Cinarci");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       4
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr4_aquarium+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr4_aquarium+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;aquarium.c,67 :: 		Lcd_Out(3,2, "Akvaryum Kontrolu");
	MOVLW       3
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       2
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr5_aquarium+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr5_aquarium+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;aquarium.c,68 :: 		delay_ms(2000);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_start0:
	DECFSZ      R13, 1, 1
	BRA         L_start0
	DECFSZ      R12, 1, 1
	BRA         L_start0
	DECFSZ      R11, 1, 1
	BRA         L_start0
	NOP
;aquarium.c,69 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;aquarium.c,71 :: 		}
L_end_start:
	RETURN      0
; end of _start

_wait:

;aquarium.c,74 :: 		void wait(){
;aquarium.c,75 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;aquarium.c,76 :: 		Lcd_Out(2, 1, "# ile devam ediniz .");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr6_aquarium+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr6_aquarium+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;aquarium.c,78 :: 		kp =0;
	CLRF        _kp+0 
;aquarium.c,79 :: 		while(kp!=ENTER)
L_wait1:
	MOVF        _kp+0, 0 
	XORLW       15
	BTFSC       STATUS+0, 2 
	GOTO        L_wait2
;aquarium.c,81 :: 		do
L_wait3:
;aquarium.c,82 :: 		kp = Keypad_Key_Click();                    // Kp degeri Keypad_Key_Click() esittir;
	CALL        _Keypad_Key_Click+0, 0
	MOVF        R0, 0 
	MOVWF       _kp+0 
;aquarium.c,83 :: 		while(!kp);
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_wait3
;aquarium.c,84 :: 		}
	GOTO        L_wait1
L_wait2:
;aquarium.c,85 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;aquarium.c,86 :: 		}
L_end_wait:
	RETURN      0
; end of _wait

_calculations:

;aquarium.c,92 :: 		void calculations(){
;aquarium.c,93 :: 		ldrvalue = ADC_Read(1);                     // Reading light voltage from A1 input.
	MOVLW       1
	MOVWF       FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	CALL        _word2double+0, 0
	MOVF        R0, 0 
	MOVWF       _ldrvalue+0 
	MOVF        R1, 0 
	MOVWF       _ldrvalue+1 
	MOVF        R2, 0 
	MOVWF       _ldrvalue+2 
	MOVF        R3, 0 
	MOVWF       _ldrvalue+3 
;aquarium.c,94 :: 		temp = ADC_Read(0);                         // A0 (input) girisinden sýcaklýk okunuyor.    //DEÐÝÞÝM YAPILDI
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__calculations+0 
	MOVF        R1, 0 
	MOVWF       FLOC__calculations+1 
	MOVF        FLOC__calculations+0, 0 
	MOVWF       _temp+0 
	MOVF        FLOC__calculations+1, 0 
	MOVWF       _temp+1 
;aquarium.c,95 :: 		gerilim=0.0048828125*ldrvalue;              // input degerini voltaja donusturme
	MOVLW       0
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       32
	MOVWF       R2 
	MOVLW       119
	MOVWF       R3 
	MOVF        _ldrvalue+0, 0 
	MOVWF       R4 
	MOVF        _ldrvalue+1, 0 
	MOVWF       R5 
	MOVF        _ldrvalue+2, 0 
	MOVWF       R6 
	MOVF        _ldrvalue+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _gerilim+0 
	MOVF        R1, 0 
	MOVWF       _gerilim+1 
	MOVF        R2, 0 
	MOVWF       _gerilim+2 
	MOVF        R3, 0 
	MOVWF       _gerilim+3 
;aquarium.c,96 :: 		mV = temp * 5000.0/1024.0;                  // mV donusturme .
	MOVF        FLOC__calculations+0, 0 
	MOVWF       R0 
	MOVF        FLOC__calculations+1, 0 
	MOVWF       R1 
	CALL        _word2double+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       64
	MOVWF       R5 
	MOVLW       28
	MOVWF       R6 
	MOVLW       139
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       137
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _mV+0 
	MOVF        R1, 0 
	MOVWF       _mV+1 
	MOVF        R2, 0 
	MOVWF       _mV+2 
	MOVF        R3, 0 
	MOVWF       _mV+3 
;aquarium.c,97 :: 		ActualTemp = mV/10.0 ;                      // Celcius a donusturme
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       32
	MOVWF       R6 
	MOVLW       130
	MOVWF       R7 
	CALL        _Div_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _ActualTemp+0 
	MOVF        R1, 0 
	MOVWF       _ActualTemp+1 
	MOVF        R2, 0 
	MOVWF       _ActualTemp+2 
	MOVF        R3, 0 
	MOVWF       _ActualTemp+3 
;aquarium.c,98 :: 		IntToStr(ActualTemp,Txt);
	CALL        _double2int+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        R1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _Txt+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_Txt+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;aquarium.c,99 :: 		IntToStr(gerilim,istxt);
	MOVF        _gerilim+0, 0 
	MOVWF       R0 
	MOVF        _gerilim+1, 0 
	MOVWF       R1 
	MOVF        _gerilim+2, 0 
	MOVWF       R2 
	MOVF        _gerilim+3, 0 
	MOVWF       R3 
	CALL        _double2int+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        R1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _istxt+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_istxt+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;aquarium.c,100 :: 		IntToStr(wlvl,wlvl1txt);
	MOVF        _wlvl+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        _wlvl+1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _wlvl1txt+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_wlvl1txt+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;aquarium.c,101 :: 		IntToStr(susev,susevtxt);
	MOVF        _susev+0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        _susev+1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _susevtxt+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_susevtxt+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;aquarium.c,102 :: 		}
L_end_calculations:
	RETURN      0
; end of _calculations

_conditions:

;aquarium.c,108 :: 		void conditions(){
;aquarium.c,109 :: 		if(optionc==1){
	MOVLW       0
	XORWF       _optionc+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__conditions128
	MOVLW       1
	XORWF       _optionc+0, 0 
L__conditions128:
	BTFSS       STATUS+0, 2 
	GOTO        L_conditions6
;aquarium.c,110 :: 		if(gerilim>Volt_Ref){LED=ON;}
	MOVF        _gerilim+0, 0 
	MOVWF       R4 
	MOVF        _gerilim+1, 0 
	MOVWF       R5 
	MOVF        _gerilim+2, 0 
	MOVWF       R6 
	MOVF        _gerilim+3, 0 
	MOVWF       R7 
	MOVF        _Volt_Ref+0, 0 
	MOVWF       R0 
	MOVF        _Volt_Ref+1, 0 
	MOVWF       R1 
	MOVF        _Volt_Ref+2, 0 
	MOVWF       R2 
	MOVF        _Volt_Ref+3, 0 
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_conditions7
	BSF         PORTD+0, 0 
	GOTO        L_conditions8
L_conditions7:
;aquarium.c,111 :: 		else if(gerilim<Volt_Ref){LED=OFF;}
	MOVF        _Volt_Ref+0, 0 
	MOVWF       R4 
	MOVF        _Volt_Ref+1, 0 
	MOVWF       R5 
	MOVF        _Volt_Ref+2, 0 
	MOVWF       R6 
	MOVF        _Volt_Ref+3, 0 
	MOVWF       R7 
	MOVF        _gerilim+0, 0 
	MOVWF       R0 
	MOVF        _gerilim+1, 0 
	MOVWF       R1 
	MOVF        _gerilim+2, 0 
	MOVWF       R2 
	MOVF        _gerilim+3, 0 
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_conditions9
	BCF         PORTD+0, 0 
L_conditions9:
L_conditions8:
;aquarium.c,112 :: 		if(ActualTemp<Temp_Ref){FAN=ON;}
	MOVF        _Temp_Ref+0, 0 
	MOVWF       R4 
	MOVF        _Temp_Ref+1, 0 
	MOVWF       R5 
	MOVF        _Temp_Ref+2, 0 
	MOVWF       R6 
	MOVF        _Temp_Ref+3, 0 
	MOVWF       R7 
	MOVF        _ActualTemp+0, 0 
	MOVWF       R0 
	MOVF        _ActualTemp+1, 0 
	MOVWF       R1 
	MOVF        _ActualTemp+2, 0 
	MOVWF       R2 
	MOVF        _ActualTemp+3, 0 
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_conditions10
	BSF         PORTC+0, 6 
	GOTO        L_conditions11
L_conditions10:
;aquarium.c,113 :: 		else if(ActualTemp>Temp_Ref){FAN=OFF;}
	MOVF        _ActualTemp+0, 0 
	MOVWF       R4 
	MOVF        _ActualTemp+1, 0 
	MOVWF       R5 
	MOVF        _ActualTemp+2, 0 
	MOVWF       R6 
	MOVF        _ActualTemp+3, 0 
	MOVWF       R7 
	MOVF        _Temp_Ref+0, 0 
	MOVWF       R0 
	MOVF        _Temp_Ref+1, 0 
	MOVWF       R1 
	MOVF        _Temp_Ref+2, 0 
	MOVWF       R2 
	MOVF        _Temp_Ref+3, 0 
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_conditions12
	BCF         PORTC+0, 6 
L_conditions12:
L_conditions11:
;aquarium.c,115 :: 		}
	GOTO        L_conditions13
L_conditions6:
;aquarium.c,116 :: 		else if(optionc==2){
	MOVLW       0
	XORWF       _optionc+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__conditions129
	MOVLW       2
	XORWF       _optionc+0, 0 
L__conditions129:
	BTFSS       STATUS+0, 2 
	GOTO        L_conditions14
;aquarium.c,117 :: 		Temp_Ref=25;
	MOVLW       0
	MOVWF       _Temp_Ref+0 
	MOVLW       0
	MOVWF       _Temp_Ref+1 
	MOVLW       72
	MOVWF       _Temp_Ref+2 
	MOVLW       131
	MOVWF       _Temp_Ref+3 
;aquarium.c,118 :: 		Volt_Ref=3;
	MOVLW       0
	MOVWF       _Volt_Ref+0 
	MOVLW       0
	MOVWF       _Volt_Ref+1 
	MOVLW       64
	MOVWF       _Volt_Ref+2 
	MOVLW       128
	MOVWF       _Volt_Ref+3 
;aquarium.c,119 :: 		wlvl=7;
	MOVLW       7
	MOVWF       _wlvl+0 
	MOVLW       0
	MOVWF       _wlvl+1 
;aquarium.c,120 :: 		susev=3;
	MOVLW       3
	MOVWF       _susev+0 
	MOVLW       0
	MOVWF       _susev+1 
;aquarium.c,121 :: 		if(ActualTemp<Temp_Ref){FAN=ON;}
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       72
	MOVWF       R6 
	MOVLW       131
	MOVWF       R7 
	MOVF        _ActualTemp+0, 0 
	MOVWF       R0 
	MOVF        _ActualTemp+1, 0 
	MOVWF       R1 
	MOVF        _ActualTemp+2, 0 
	MOVWF       R2 
	MOVF        _ActualTemp+3, 0 
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_conditions15
	BSF         PORTC+0, 6 
L_conditions15:
;aquarium.c,122 :: 		if(ActualTemp>Temp_Ref){FAN=OFF;}
	MOVF        _ActualTemp+0, 0 
	MOVWF       R4 
	MOVF        _ActualTemp+1, 0 
	MOVWF       R5 
	MOVF        _ActualTemp+2, 0 
	MOVWF       R6 
	MOVF        _ActualTemp+3, 0 
	MOVWF       R7 
	MOVF        _Temp_Ref+0, 0 
	MOVWF       R0 
	MOVF        _Temp_Ref+1, 0 
	MOVWF       R1 
	MOVF        _Temp_Ref+2, 0 
	MOVWF       R2 
	MOVF        _Temp_Ref+3, 0 
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_conditions16
	BCF         PORTC+0, 6 
L_conditions16:
;aquarium.c,123 :: 		if(gerilim>Volt_Ref){LED=ON;}
	MOVF        _gerilim+0, 0 
	MOVWF       R4 
	MOVF        _gerilim+1, 0 
	MOVWF       R5 
	MOVF        _gerilim+2, 0 
	MOVWF       R6 
	MOVF        _gerilim+3, 0 
	MOVWF       R7 
	MOVF        _Volt_Ref+0, 0 
	MOVWF       R0 
	MOVF        _Volt_Ref+1, 0 
	MOVWF       R1 
	MOVF        _Volt_Ref+2, 0 
	MOVWF       R2 
	MOVF        _Volt_Ref+3, 0 
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_conditions17
	BSF         PORTD+0, 0 
L_conditions17:
;aquarium.c,124 :: 		if(gerilim<Volt_Ref){LED=OFF;}
	MOVF        _Volt_Ref+0, 0 
	MOVWF       R4 
	MOVF        _Volt_Ref+1, 0 
	MOVWF       R5 
	MOVF        _Volt_Ref+2, 0 
	MOVWF       R6 
	MOVF        _Volt_Ref+3, 0 
	MOVWF       R7 
	MOVF        _gerilim+0, 0 
	MOVWF       R0 
	MOVF        _gerilim+1, 0 
	MOVWF       R1 
	MOVF        _gerilim+2, 0 
	MOVWF       R2 
	MOVF        _gerilim+3, 0 
	MOVWF       R3 
	CALL        _Compare_Double+0, 0
	MOVLW       1
	BTFSC       STATUS+0, 0 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_conditions18
	BCF         PORTD+0, 0 
L_conditions18:
;aquarium.c,126 :: 		}
L_conditions14:
L_conditions13:
;aquarium.c,127 :: 		}
L_end_conditions:
	RETURN      0
; end of _conditions

_cond2:

;aquarium.c,129 :: 		void cond2(){
;aquarium.c,131 :: 		if(sec1>9){sec1=0; sec=sec+1;}
	MOVLW       0
	MOVWF       R0 
	MOVF        _sec1+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__cond2131
	MOVF        _sec1+0, 0 
	SUBLW       9
L__cond2131:
	BTFSC       STATUS+0, 0 
	GOTO        L_cond219
	CLRF        _sec1+0 
	CLRF        _sec1+1 
	INFSNZ      _sec+0, 1 
	INCF        _sec+1, 1 
L_cond219:
;aquarium.c,132 :: 		if(sec>5){sec=0; m=m+1;}
	MOVLW       0
	MOVWF       R0 
	MOVF        _sec+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__cond2132
	MOVF        _sec+0, 0 
	SUBLW       5
L__cond2132:
	BTFSC       STATUS+0, 0 
	GOTO        L_cond220
	CLRF        _sec+0 
	CLRF        _sec+1 
	INFSNZ      _m+0, 1 
	INCF        _m+1, 1 
L_cond220:
;aquarium.c,133 :: 		if(m>9){m=0; mm=mm+1;}
	MOVLW       0
	MOVWF       R0 
	MOVF        _m+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__cond2133
	MOVF        _m+0, 0 
	SUBLW       9
L__cond2133:
	BTFSC       STATUS+0, 0 
	GOTO        L_cond221
	CLRF        _m+0 
	CLRF        _m+1 
	INFSNZ      _mm+0, 1 
	INCF        _mm+1, 1 
L_cond221:
;aquarium.c,134 :: 		}
L_end_cond2:
	RETURN      0
; end of _cond2

_print:

;aquarium.c,137 :: 		void print(){
;aquarium.c,139 :: 		digit[0] = mm + 48;           // mm m : sec sec1;
	MOVLW       48
	ADDWF       _mm+0, 0 
	MOVWF       R0 
	MOVFF       _digit+0, FSR1L+0
	MOVFF       _digit+1, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;aquarium.c,140 :: 		digit[1] = m + 48;            // mm m : sec sec1;
	MOVLW       1
	ADDWF       _digit+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      _digit+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       48
	ADDWF       _m+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;aquarium.c,141 :: 		digit1[0] = sec + 48;         // mm m : sec sec1;
	MOVLW       48
	ADDWF       _sec+0, 0 
	MOVWF       R0 
	MOVFF       _digit1+0, FSR1L+0
	MOVFF       _digit1+1, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;aquarium.c,142 :: 		digit1[1] = sec1 + 48;        // mm m : sec sec1;
	MOVLW       1
	ADDWF       _digit1+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      _digit1+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       48
	ADDWF       _sec1+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;aquarium.c,144 :: 		Lcd_Out(1,1,"Temperature: ");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr7_aquarium+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr7_aquarium+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;aquarium.c,145 :: 		Lcd_Out(1,15,Txt);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       15
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _Txt+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_Txt+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;aquarium.c,146 :: 		Lcd_Out(2,1,"Light V: ");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr8_aquarium+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr8_aquarium+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;aquarium.c,147 :: 		Lcd_Out(2,15,istxt);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       15
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _istxt+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_istxt+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;aquarium.c,148 :: 		Lcd_Out(3,1,"pH: ");
	MOVLW       3
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr9_aquarium+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr9_aquarium+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;aquarium.c,149 :: 		Lcd_Out(3,15,wlvl1txt);
	MOVLW       3
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       15
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _wlvl1txt+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_wlvl1txt+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;aquarium.c,150 :: 		Lcd_Out(4,1,"Runtime :");
	MOVLW       4
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr10_aquarium+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr10_aquarium+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;aquarium.c,151 :: 		Lcd_Out(4,12,digit);                    // LCD ekranda  2 sutün ,7 karakter;
	MOVLW       4
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       12
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        _digit+0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVF        _digit+1, 0 
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;aquarium.c,152 :: 		Lcd_Out(4,14,dn);
	MOVLW       4
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       14
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _dn+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_dn+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;aquarium.c,153 :: 		Lcd_Out(4,15,digit1);
	MOVLW       4
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       15
	MOVWF       FARG_Lcd_Out_column+0 
	MOVF        _digit1+0, 0 
	MOVWF       FARG_Lcd_Out_text+0 
	MOVF        _digit1+1, 0 
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;aquarium.c,154 :: 		delay_ms(375);
	MOVLW       4
	MOVWF       R11, 0
	MOVLW       207
	MOVWF       R12, 0
	MOVLW       1
	MOVWF       R13, 0
L_print22:
	DECFSZ      R13, 1, 1
	BRA         L_print22
	DECFSZ      R12, 1, 1
	BRA         L_print22
	DECFSZ      R11, 1, 1
	BRA         L_print22
	NOP
	NOP
;aquarium.c,155 :: 		if(m==1 && feed==0){
	MOVLW       0
	XORWF       _m+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__print135
	MOVLW       1
	XORWF       _m+0, 0 
L__print135:
	BTFSS       STATUS+0, 2 
	GOTO        L_print25
	MOVLW       0
	XORWF       _feed+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__print136
	MOVLW       0
	XORWF       _feed+0, 0 
L__print136:
	BTFSS       STATUS+0, 2 
	GOTO        L_print25
L__print113:
;aquarium.c,156 :: 		feed=1;
	MOVLW       1
	MOVWF       _feed+0 
	MOVLW       0
	MOVWF       _feed+1 
;aquarium.c,157 :: 		FEEDL=ON;
	BSF         PORTD+0, 1 
;aquarium.c,159 :: 		Lcd_Out(4,1,"Baliklari besleme zamani!");
	MOVLW       4
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr11_aquarium+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr11_aquarium+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;aquarium.c,160 :: 		delay_ms(300);
	MOVLW       4
	MOVWF       R11, 0
	MOVLW       12
	MOVWF       R12, 0
	MOVLW       51
	MOVWF       R13, 0
L_print26:
	DECFSZ      R13, 1, 1
	BRA         L_print26
	DECFSZ      R12, 1, 1
	BRA         L_print26
	DECFSZ      R11, 1, 1
	BRA         L_print26
	NOP
	NOP
;aquarium.c,161 :: 		Lcd_Out(4,1,"                    ");
	MOVLW       4
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr12_aquarium+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr12_aquarium+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;aquarium.c,162 :: 		delay_ms(300);
	MOVLW       4
	MOVWF       R11, 0
	MOVLW       12
	MOVWF       R12, 0
	MOVLW       51
	MOVWF       R13, 0
L_print27:
	DECFSZ      R13, 1, 1
	BRA         L_print27
	DECFSZ      R12, 1, 1
	BRA         L_print27
	DECFSZ      R11, 1, 1
	BRA         L_print27
	NOP
	NOP
;aquarium.c,163 :: 		Lcd_Out(4,1,"Baliklari besleme zamani!");
	MOVLW       4
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr13_aquarium+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr13_aquarium+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;aquarium.c,164 :: 		delay_ms(300);
	MOVLW       4
	MOVWF       R11, 0
	MOVLW       12
	MOVWF       R12, 0
	MOVLW       51
	MOVWF       R13, 0
L_print28:
	DECFSZ      R13, 1, 1
	BRA         L_print28
	DECFSZ      R12, 1, 1
	BRA         L_print28
	DECFSZ      R11, 1, 1
	BRA         L_print28
	NOP
	NOP
;aquarium.c,165 :: 		Lcd_Out(4,1,"                    ");          }
	MOVLW       4
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr14_aquarium+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr14_aquarium+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
L_print25:
;aquarium.c,166 :: 		FEEDL=OFF;
	BCF         PORTD+0, 1 
;aquarium.c,168 :: 		}
L_end_print:
	RETURN      0
; end of _print

_keypadtemp:

;aquarium.c,174 :: 		void keypadtemp(){
;aquarium.c,175 :: 		START1:
___keypadtemp_START1:
;aquarium.c,176 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;aquarium.c,177 :: 		Lcd_Out(1, 1, "Sicakligi gir");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr15_aquarium+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr15_aquarium+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;aquarium.c,178 :: 		Temp_Ref=0;
	CLRF        _Temp_Ref+0 
	CLRF        _Temp_Ref+1 
	CLRF        _Temp_Ref+2 
	CLRF        _Temp_Ref+3 
;aquarium.c,179 :: 		Lcd_Out(2, 1, "Ref.Sicak:");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr16_aquarium+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr16_aquarium+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;aquarium.c,180 :: 		while(1)
L_keypadtemp29:
;aquarium.c,182 :: 		do
L_keypadtemp31:
;aquarium.c,183 :: 		kp = Keypad_Key_Click();
	CALL        _Keypad_Key_Click+0, 0
	MOVF        R0, 0 
	MOVWF       _kp+0 
;aquarium.c,184 :: 		while (!kp);
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_keypadtemp31
;aquarium.c,185 :: 		if (kp == ENTER )break;
	MOVF        _kp+0, 0 
	XORLW       15
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadtemp34
	GOTO        L_keypadtemp30
L_keypadtemp34:
;aquarium.c,186 :: 		if (kp > 3 && kp < 8) kp = kp-1;
	MOVF        _kp+0, 0 
	SUBLW       3
	BTFSC       STATUS+0, 0 
	GOTO        L_keypadtemp37
	MOVLW       8
	SUBWF       _kp+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_keypadtemp37
L__keypadtemp115:
	DECF        _kp+0, 1 
L_keypadtemp37:
;aquarium.c,187 :: 		if (kp > 8 && kp < 12) kp = kp-2;
	MOVF        _kp+0, 0 
	SUBLW       8
	BTFSC       STATUS+0, 0 
	GOTO        L_keypadtemp40
	MOVLW       12
	SUBWF       _kp+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_keypadtemp40
L__keypadtemp114:
	MOVLW       2
	SUBWF       _kp+0, 1 
L_keypadtemp40:
;aquarium.c,188 :: 		if (kp ==14)kp = 0;
	MOVF        _kp+0, 0 
	XORLW       14
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadtemp41
	CLRF        _kp+0 
L_keypadtemp41:
;aquarium.c,189 :: 		if ( kp == CLEAR )goto START1;
	MOVF        _kp+0, 0 
	XORLW       13
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadtemp42
	GOTO        ___keypadtemp_START1
L_keypadtemp42:
;aquarium.c,190 :: 		Lcd_Chr_Cp(kp + '0');
	MOVLW       48
	ADDWF       _kp+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;aquarium.c,191 :: 		Temp_Ref =(10*Temp_Ref) + kp;
	MOVLW       0
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       32
	MOVWF       R2 
	MOVLW       130
	MOVWF       R3 
	MOVF        _Temp_Ref+0, 0 
	MOVWF       R4 
	MOVF        _Temp_Ref+1, 0 
	MOVWF       R5 
	MOVF        _Temp_Ref+2, 0 
	MOVWF       R6 
	MOVF        _Temp_Ref+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__keypadtemp+0 
	MOVF        R1, 0 
	MOVWF       FLOC__keypadtemp+1 
	MOVF        R2, 0 
	MOVWF       FLOC__keypadtemp+2 
	MOVF        R3, 0 
	MOVWF       FLOC__keypadtemp+3 
	MOVF        _kp+0, 0 
	MOVWF       R0 
	CALL        _byte2double+0, 0
	MOVF        FLOC__keypadtemp+0, 0 
	MOVWF       R4 
	MOVF        FLOC__keypadtemp+1, 0 
	MOVWF       R5 
	MOVF        FLOC__keypadtemp+2, 0 
	MOVWF       R6 
	MOVF        FLOC__keypadtemp+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _Temp_Ref+0 
	MOVF        R1, 0 
	MOVWF       _Temp_Ref+1 
	MOVF        R2, 0 
	MOVWF       _Temp_Ref+2 
	MOVF        R3, 0 
	MOVWF       _Temp_Ref+3 
;aquarium.c,192 :: 		}
	GOTO        L_keypadtemp29
L_keypadtemp30:
;aquarium.c,194 :: 		intToStr(Temp_Ref,Txt);
	MOVF        _Temp_Ref+0, 0 
	MOVWF       R0 
	MOVF        _Temp_Ref+1, 0 
	MOVWF       R1 
	MOVF        _Temp_Ref+2, 0 
	MOVWF       R2 
	MOVF        _Temp_Ref+3, 0 
	MOVWF       R3 
	CALL        _double2int+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        R1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _Txt+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_Txt+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;aquarium.c,195 :: 		wait();
	CALL        _wait+0, 0
;aquarium.c,198 :: 		}
L_end_keypadtemp:
	RETURN      0
; end of _keypadtemp

_startvalue:

;aquarium.c,203 :: 		void startvalue(){
;aquarium.c,204 :: 		if(optionc==1){
	MOVLW       0
	XORWF       _optionc+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__startvalue139
	MOVLW       1
	XORWF       _optionc+0, 0 
L__startvalue139:
	BTFSS       STATUS+0, 2 
	GOTO        L_startvalue43
;aquarium.c,205 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;aquarium.c,206 :: 		Lcd_Out(1,1,"Ref. Sicaklik: ");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr17_aquarium+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr17_aquarium+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;aquarium.c,207 :: 		Lcd_Out(1,15,Txt);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       15
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _Txt+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_Txt+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;aquarium.c,208 :: 		Lcd_Out(2,1,"Ref. Volt:  ");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr18_aquarium+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr18_aquarium+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;aquarium.c,209 :: 		Lcd_Out(2,15,voltxt);
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       15
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _voltxt+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_voltxt+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;aquarium.c,210 :: 		Lcd_Out(3,1,"Ref. pH:  ");
	MOVLW       3
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr19_aquarium+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr19_aquarium+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;aquarium.c,211 :: 		Lcd_Out(3,15,wlvl1txt);
	MOVLW       3
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       15
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _wlvl1txt+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_wlvl1txt+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;aquarium.c,212 :: 		Lcd_Out(4,1,"Ref. susev:  ");
	MOVLW       4
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr20_aquarium+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr20_aquarium+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;aquarium.c,213 :: 		Lcd_Out(4,15,susevtxt);
	MOVLW       4
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       15
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       _susevtxt+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_susevtxt+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;aquarium.c,214 :: 		Delay_ms(2000);                   }
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_startvalue44:
	DECFSZ      R13, 1, 1
	BRA         L_startvalue44
	DECFSZ      R12, 1, 1
	BRA         L_startvalue44
	DECFSZ      R11, 1, 1
	BRA         L_startvalue44
	NOP
	GOTO        L_startvalue45
L_startvalue43:
;aquarium.c,215 :: 		else if(optionc==2){
	MOVLW       0
	XORWF       _optionc+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__startvalue140
	MOVLW       2
	XORWF       _optionc+0, 0 
L__startvalue140:
	BTFSS       STATUS+0, 2 
	GOTO        L_startvalue46
;aquarium.c,216 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;aquarium.c,217 :: 		Lcd_Out(1,1,"Ref. Sicaklik:  ");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr21_aquarium+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr21_aquarium+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;aquarium.c,218 :: 		Lcd_Out(1,15,"25*C");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       15
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr22_aquarium+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr22_aquarium+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;aquarium.c,219 :: 		Lcd_Out(2,1,"Ref. Volt:  ");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr23_aquarium+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr23_aquarium+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;aquarium.c,220 :: 		Lcd_Out(2,17,"3V");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       17
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr24_aquarium+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr24_aquarium+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;aquarium.c,221 :: 		Lcd_Out(3,1,"Ref. pH:  ");
	MOVLW       3
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr25_aquarium+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr25_aquarium+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;aquarium.c,222 :: 		Lcd_Out(3,15,"  7 ");
	MOVLW       3
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       15
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr26_aquarium+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr26_aquarium+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;aquarium.c,223 :: 		Lcd_Out(4,1,"Ref. susev:  ");
	MOVLW       4
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr27_aquarium+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr27_aquarium+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;aquarium.c,224 :: 		Lcd_Out(4,15,"  3");
	MOVLW       4
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       15
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr28_aquarium+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr28_aquarium+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;aquarium.c,226 :: 		Delay_ms(2000);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_startvalue47:
	DECFSZ      R13, 1, 1
	BRA         L_startvalue47
	DECFSZ      R12, 1, 1
	BRA         L_startvalue47
	DECFSZ      R11, 1, 1
	BRA         L_startvalue47
	NOP
;aquarium.c,227 :: 		}
L_startvalue46:
L_startvalue45:
;aquarium.c,229 :: 		}
L_end_startvalue:
	RETURN      0
; end of _startvalue

_keypadvolt:

;aquarium.c,234 :: 		void keypadvolt(){
;aquarium.c,236 :: 		START2:
___keypadvolt_START2:
;aquarium.c,238 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;aquarium.c,239 :: 		Lcd_Out(1, 1, "Volt degeri giriniz");               //Referans Sýcaklýðýný Lcd'de belirlenen yere Keypad ile girmemizi saðlar
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr29_aquarium+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr29_aquarium+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;aquarium.c,240 :: 		Volt_Ref=0;
	CLRF        _Volt_Ref+0 
	CLRF        _Volt_Ref+1 
	CLRF        _Volt_Ref+2 
	CLRF        _Volt_Ref+3 
;aquarium.c,241 :: 		Lcd_Out(3,1,"0-4 Volt araliginda.");
	MOVLW       3
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr30_aquarium+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr30_aquarium+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;aquarium.c,242 :: 		Lcd_Out(2, 1, "Ref.Volt: ");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr31_aquarium+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr31_aquarium+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;aquarium.c,243 :: 		while(1)
L_keypadvolt48:
;aquarium.c,245 :: 		do
L_keypadvolt50:
;aquarium.c,246 :: 		kp = Keypad_Key_Click();
	CALL        _Keypad_Key_Click+0, 0
	MOVF        R0, 0 
	MOVWF       _kp+0 
;aquarium.c,247 :: 		while (!kp);
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_keypadvolt50
;aquarium.c,248 :: 		if ( kp == ENTER )break;
	MOVF        _kp+0, 0 
	XORLW       15
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadvolt53
	GOTO        L_keypadvolt49
L_keypadvolt53:
;aquarium.c,249 :: 		if (kp > 3 && kp < 8) kp = kp-1;
	MOVF        _kp+0, 0 
	SUBLW       3
	BTFSC       STATUS+0, 0 
	GOTO        L_keypadvolt56
	MOVLW       8
	SUBWF       _kp+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_keypadvolt56
L__keypadvolt117:
	DECF        _kp+0, 1 
L_keypadvolt56:
;aquarium.c,250 :: 		if (kp > 8 && kp < 12) kp = kp-2;
	MOVF        _kp+0, 0 
	SUBLW       8
	BTFSC       STATUS+0, 0 
	GOTO        L_keypadvolt59
	MOVLW       12
	SUBWF       _kp+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_keypadvolt59
L__keypadvolt116:
	MOVLW       2
	SUBWF       _kp+0, 1 
L_keypadvolt59:
;aquarium.c,251 :: 		if (kp ==14)kp = 0;
	MOVF        _kp+0, 0 
	XORLW       14
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadvolt60
	CLRF        _kp+0 
L_keypadvolt60:
;aquarium.c,252 :: 		if ( kp == CLEAR )goto START2;
	MOVF        _kp+0, 0 
	XORLW       13
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadvolt61
	GOTO        ___keypadvolt_START2
L_keypadvolt61:
;aquarium.c,253 :: 		Lcd_Chr_Cp(kp + '0');
	MOVLW       48
	ADDWF       _kp+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;aquarium.c,254 :: 		Volt_Ref =(10*Volt_Ref) + kp;
	MOVLW       0
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       32
	MOVWF       R2 
	MOVLW       130
	MOVWF       R3 
	MOVF        _Volt_Ref+0, 0 
	MOVWF       R4 
	MOVF        _Volt_Ref+1, 0 
	MOVWF       R5 
	MOVF        _Volt_Ref+2, 0 
	MOVWF       R6 
	MOVF        _Volt_Ref+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__keypadvolt+0 
	MOVF        R1, 0 
	MOVWF       FLOC__keypadvolt+1 
	MOVF        R2, 0 
	MOVWF       FLOC__keypadvolt+2 
	MOVF        R3, 0 
	MOVWF       FLOC__keypadvolt+3 
	MOVF        _kp+0, 0 
	MOVWF       R0 
	CALL        _byte2double+0, 0
	MOVF        FLOC__keypadvolt+0, 0 
	MOVWF       R4 
	MOVF        FLOC__keypadvolt+1, 0 
	MOVWF       R5 
	MOVF        FLOC__keypadvolt+2, 0 
	MOVWF       R6 
	MOVF        FLOC__keypadvolt+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _Volt_Ref+0 
	MOVF        R1, 0 
	MOVWF       _Volt_Ref+1 
	MOVF        R2, 0 
	MOVWF       _Volt_Ref+2 
	MOVF        R3, 0 
	MOVWF       _Volt_Ref+3 
;aquarium.c,255 :: 		}
	GOTO        L_keypadvolt48
L_keypadvolt49:
;aquarium.c,257 :: 		intToStr(Volt_Ref,voltxt);
	MOVF        _Volt_Ref+0, 0 
	MOVWF       R0 
	MOVF        _Volt_Ref+1, 0 
	MOVWF       R1 
	MOVF        _Volt_Ref+2, 0 
	MOVWF       R2 
	MOVF        _Volt_Ref+3, 0 
	MOVWF       R3 
	CALL        _double2int+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        R1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _voltxt+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_voltxt+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;aquarium.c,258 :: 		wait();
	CALL        _wait+0, 0
;aquarium.c,259 :: 		}
L_end_keypadvolt:
	RETURN      0
; end of _keypadvolt

_keypadpH:

;aquarium.c,261 :: 		void keypadpH(){
;aquarium.c,263 :: 		START3:
___keypadpH_START3:
;aquarium.c,265 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;aquarium.c,266 :: 		Lcd_Out(1, 1, "pH degeri giriniz");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr32_aquarium+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr32_aquarium+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;aquarium.c,267 :: 		wlvl_Ref=0;
	CLRF        _wlvl_Ref+0 
	CLRF        _wlvl_Ref+1 
	CLRF        _wlvl_Ref+2 
	CLRF        _wlvl_Ref+3 
;aquarium.c,268 :: 		Lcd_Out(3,1,"0-14  araliginda.");
	MOVLW       3
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr33_aquarium+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr33_aquarium+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;aquarium.c,269 :: 		Lcd_Out(2, 1, "Ref.pH: ");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr34_aquarium+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr34_aquarium+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;aquarium.c,270 :: 		while(1)
L_keypadpH62:
;aquarium.c,272 :: 		do
L_keypadpH64:
;aquarium.c,273 :: 		kp = Keypad_Key_Click();
	CALL        _Keypad_Key_Click+0, 0
	MOVF        R0, 0 
	MOVWF       _kp+0 
;aquarium.c,274 :: 		while (!kp);
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_keypadpH64
;aquarium.c,275 :: 		if ( kp == ENTER )break;
	MOVF        _kp+0, 0 
	XORLW       15
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadpH67
	GOTO        L_keypadpH63
L_keypadpH67:
;aquarium.c,276 :: 		if (kp > 3 && kp < 8) kp = kp-1;
	MOVF        _kp+0, 0 
	SUBLW       3
	BTFSC       STATUS+0, 0 
	GOTO        L_keypadpH70
	MOVLW       8
	SUBWF       _kp+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_keypadpH70
L__keypadpH119:
	DECF        _kp+0, 1 
L_keypadpH70:
;aquarium.c,277 :: 		if (kp > 8 && kp < 12) kp = kp-2;
	MOVF        _kp+0, 0 
	SUBLW       8
	BTFSC       STATUS+0, 0 
	GOTO        L_keypadpH73
	MOVLW       12
	SUBWF       _kp+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_keypadpH73
L__keypadpH118:
	MOVLW       2
	SUBWF       _kp+0, 1 
L_keypadpH73:
;aquarium.c,278 :: 		if (kp ==14)kp = 0;
	MOVF        _kp+0, 0 
	XORLW       14
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadpH74
	CLRF        _kp+0 
L_keypadpH74:
;aquarium.c,279 :: 		if ( kp == CLEAR )goto START3;
	MOVF        _kp+0, 0 
	XORLW       13
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadpH75
	GOTO        ___keypadpH_START3
L_keypadpH75:
;aquarium.c,280 :: 		Lcd_Chr_Cp(kp + '0');
	MOVLW       48
	ADDWF       _kp+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;aquarium.c,281 :: 		wlvl_Ref =  kp;
	MOVF        _kp+0, 0 
	MOVWF       R0 
	CALL        _byte2double+0, 0
	MOVF        R0, 0 
	MOVWF       _wlvl_Ref+0 
	MOVF        R1, 0 
	MOVWF       _wlvl_Ref+1 
	MOVF        R2, 0 
	MOVWF       _wlvl_Ref+2 
	MOVF        R3, 0 
	MOVWF       _wlvl_Ref+3 
;aquarium.c,282 :: 		}
	GOTO        L_keypadpH62
L_keypadpH63:
;aquarium.c,283 :: 		intToStr(wlvl_Ref,wlvl1txt);
	MOVF        _wlvl_Ref+0, 0 
	MOVWF       R0 
	MOVF        _wlvl_Ref+1, 0 
	MOVWF       R1 
	MOVF        _wlvl_Ref+2, 0 
	MOVWF       R2 
	MOVF        _wlvl_Ref+3, 0 
	MOVWF       R3 
	CALL        _double2int+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        R1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _wlvl1txt+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_wlvl1txt+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;aquarium.c,284 :: 		wait();
	CALL        _wait+0, 0
;aquarium.c,285 :: 		}
L_end_keypadpH:
	RETURN      0
; end of _keypadpH

_keypadsusev:

;aquarium.c,287 :: 		void keypadsusev(){
;aquarium.c,288 :: 		START4:
___keypadsusev_START4:
;aquarium.c,290 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;aquarium.c,291 :: 		Lcd_Out(1, 1, "suseviye degeri gir");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr35_aquarium+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr35_aquarium+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;aquarium.c,292 :: 		susev_Ref=0;
	CLRF        _susev_Ref+0 
	CLRF        _susev_Ref+1 
	CLRF        _susev_Ref+2 
	CLRF        _susev_Ref+3 
;aquarium.c,293 :: 		Lcd_Out(3,1,"0-3 araliginda.");
	MOVLW       3
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr36_aquarium+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr36_aquarium+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;aquarium.c,294 :: 		Lcd_Out(2, 1, "Ref.susev: ");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr37_aquarium+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr37_aquarium+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;aquarium.c,295 :: 		while(1)
L_keypadsusev76:
;aquarium.c,297 :: 		do
L_keypadsusev78:
;aquarium.c,298 :: 		kp = Keypad_Key_Click();
	CALL        _Keypad_Key_Click+0, 0
	MOVF        R0, 0 
	MOVWF       _kp+0 
;aquarium.c,299 :: 		while (!kp);
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_keypadsusev78
;aquarium.c,300 :: 		if ( kp == ENTER )break;
	MOVF        _kp+0, 0 
	XORLW       15
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadsusev81
	GOTO        L_keypadsusev77
L_keypadsusev81:
;aquarium.c,301 :: 		if (kp > 3 && kp < 8) kp = kp-1;
	MOVF        _kp+0, 0 
	SUBLW       3
	BTFSC       STATUS+0, 0 
	GOTO        L_keypadsusev84
	MOVLW       8
	SUBWF       _kp+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_keypadsusev84
L__keypadsusev121:
	DECF        _kp+0, 1 
L_keypadsusev84:
;aquarium.c,302 :: 		if (kp > 8 && kp < 12) kp = kp-2;
	MOVF        _kp+0, 0 
	SUBLW       8
	BTFSC       STATUS+0, 0 
	GOTO        L_keypadsusev87
	MOVLW       12
	SUBWF       _kp+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_keypadsusev87
L__keypadsusev120:
	MOVLW       2
	SUBWF       _kp+0, 1 
L_keypadsusev87:
;aquarium.c,303 :: 		if (kp ==14)kp = 0;
	MOVF        _kp+0, 0 
	XORLW       14
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadsusev88
	CLRF        _kp+0 
L_keypadsusev88:
;aquarium.c,304 :: 		if ( kp == CLEAR )goto START4;
	MOVF        _kp+0, 0 
	XORLW       13
	BTFSS       STATUS+0, 2 
	GOTO        L_keypadsusev89
	GOTO        ___keypadsusev_START4
L_keypadsusev89:
;aquarium.c,305 :: 		Lcd_Chr_Cp(kp + '0');
	MOVLW       48
	ADDWF       _kp+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;aquarium.c,306 :: 		susev_Ref = kp;
	MOVF        _kp+0, 0 
	MOVWF       R0 
	CALL        _byte2double+0, 0
	MOVF        R0, 0 
	MOVWF       _susev_Ref+0 
	MOVF        R1, 0 
	MOVWF       _susev_Ref+1 
	MOVF        R2, 0 
	MOVWF       _susev_Ref+2 
	MOVF        R3, 0 
	MOVWF       _susev_Ref+3 
;aquarium.c,307 :: 		}
	GOTO        L_keypadsusev76
L_keypadsusev77:
;aquarium.c,308 :: 		intToStr(susev_Ref,susevtxt);
	MOVF        _susev_Ref+0, 0 
	MOVWF       R0 
	MOVF        _susev_Ref+1, 0 
	MOVWF       R1 
	MOVF        _susev_Ref+2, 0 
	MOVWF       R2 
	MOVF        _susev_Ref+3, 0 
	MOVWF       R3 
	CALL        _double2int+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_IntToStr_input+0 
	MOVF        R1, 0 
	MOVWF       FARG_IntToStr_input+1 
	MOVLW       _susevtxt+0
	MOVWF       FARG_IntToStr_output+0 
	MOVLW       hi_addr(_susevtxt+0)
	MOVWF       FARG_IntToStr_output+1 
	CALL        _IntToStr+0, 0
;aquarium.c,309 :: 		}
L_end_keypadsusev:
	RETURN      0
; end of _keypadsusev

_keypad:

;aquarium.c,316 :: 		void keypad(){
;aquarium.c,317 :: 		START:
___keypad_START:
;aquarium.c,318 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;aquarium.c,319 :: 		Lcd_Out(1, 1, "Bir opsiyon seciniz:");
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr38_aquarium+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr38_aquarium+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;aquarium.c,320 :: 		menu=0;
	CLRF        _menu+0 
	CLRF        _menu+1 
	CLRF        _menu+2 
	CLRF        _menu+3 
;aquarium.c,321 :: 		Lcd_Out(2, 1, ">>Manuel icin (1) ");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr39_aquarium+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr39_aquarium+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;aquarium.c,322 :: 		Lcd_Out(3, 1, ">>Otomatik icin (2) ");
	MOVLW       3
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr40_aquarium+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr40_aquarium+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;aquarium.c,323 :: 		Lcd_Out(4,1,">># ile devam ediniz ");
	MOVLW       4
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr41_aquarium+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr41_aquarium+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;aquarium.c,324 :: 		while(1)
L_keypad90:
;aquarium.c,326 :: 		do
L_keypad92:
;aquarium.c,327 :: 		kp = Keypad_Key_Click();
	CALL        _Keypad_Key_Click+0, 0
	MOVF        R0, 0 
	MOVWF       _kp+0 
;aquarium.c,328 :: 		while (!kp);
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_keypad92
;aquarium.c,329 :: 		if ( kp == ENTER )break;
	MOVF        _kp+0, 0 
	XORLW       15
	BTFSS       STATUS+0, 2 
	GOTO        L_keypad95
	GOTO        L_keypad91
L_keypad95:
;aquarium.c,330 :: 		if (kp > 3 && kp < 8) kp = kp-1;
	MOVF        _kp+0, 0 
	SUBLW       3
	BTFSC       STATUS+0, 0 
	GOTO        L_keypad98
	MOVLW       8
	SUBWF       _kp+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_keypad98
L__keypad123:
	DECF        _kp+0, 1 
L_keypad98:
;aquarium.c,331 :: 		if (kp > 8 && kp < 12) kp = kp-2;
	MOVF        _kp+0, 0 
	SUBLW       8
	BTFSC       STATUS+0, 0 
	GOTO        L_keypad101
	MOVLW       12
	SUBWF       _kp+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_keypad101
L__keypad122:
	MOVLW       2
	SUBWF       _kp+0, 1 
L_keypad101:
;aquarium.c,332 :: 		if (kp ==14)kp = 0;
	MOVF        _kp+0, 0 
	XORLW       14
	BTFSS       STATUS+0, 2 
	GOTO        L_keypad102
	CLRF        _kp+0 
L_keypad102:
;aquarium.c,333 :: 		if (kp == CLEAR )goto START;
	MOVF        _kp+0, 0 
	XORLW       13
	BTFSS       STATUS+0, 2 
	GOTO        L_keypad103
	GOTO        ___keypad_START
L_keypad103:
;aquarium.c,334 :: 		Lcd_Chr_Cp(kp + '0');
	MOVLW       48
	ADDWF       _kp+0, 0 
	MOVWF       FARG_Lcd_Chr_CP_out_char+0 
	CALL        _Lcd_Chr_CP+0, 0
;aquarium.c,335 :: 		menu =(10*menu) + kp;
	MOVLW       0
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       32
	MOVWF       R2 
	MOVLW       130
	MOVWF       R3 
	MOVF        _menu+0, 0 
	MOVWF       R4 
	MOVF        _menu+1, 0 
	MOVWF       R5 
	MOVF        _menu+2, 0 
	MOVWF       R6 
	MOVF        _menu+3, 0 
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__keypad+0 
	MOVF        R1, 0 
	MOVWF       FLOC__keypad+1 
	MOVF        R2, 0 
	MOVWF       FLOC__keypad+2 
	MOVF        R3, 0 
	MOVWF       FLOC__keypad+3 
	MOVF        _kp+0, 0 
	MOVWF       R0 
	CALL        _byte2double+0, 0
	MOVF        FLOC__keypad+0, 0 
	MOVWF       R4 
	MOVF        FLOC__keypad+1, 0 
	MOVWF       R5 
	MOVF        FLOC__keypad+2, 0 
	MOVWF       R6 
	MOVF        FLOC__keypad+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       _menu+0 
	MOVF        R1, 0 
	MOVWF       _menu+1 
	MOVF        R2, 0 
	MOVWF       _menu+2 
	MOVF        R3, 0 
	MOVWF       _menu+3 
;aquarium.c,336 :: 		}
	GOTO        L_keypad90
L_keypad91:
;aquarium.c,337 :: 		if(menu==1){
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       127
	MOVWF       R7 
	MOVF        _menu+0, 0 
	MOVWF       R0 
	MOVF        _menu+1, 0 
	MOVWF       R1 
	MOVF        _menu+2, 0 
	MOVWF       R2 
	MOVF        _menu+3, 0 
	MOVWF       R3 
	CALL        _Equals_Double+0, 0
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_keypad104
;aquarium.c,338 :: 		optionc=1;
	MOVLW       1
	MOVWF       _optionc+0 
	MOVLW       0
	MOVWF       _optionc+1 
;aquarium.c,339 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;aquarium.c,340 :: 		Lcd_Out(2,1,"Manuel secildi");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr42_aquarium+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr42_aquarium+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;aquarium.c,341 :: 		Delay_ms(1000);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_keypad105:
	DECFSZ      R13, 1, 1
	BRA         L_keypad105
	DECFSZ      R12, 1, 1
	BRA         L_keypad105
	DECFSZ      R11, 1, 1
	BRA         L_keypad105
	NOP
	NOP
;aquarium.c,342 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;aquarium.c,343 :: 		keypadtemp();
	CALL        _keypadtemp+0, 0
;aquarium.c,344 :: 		keypadvolt();
	CALL        _keypadvolt+0, 0
;aquarium.c,345 :: 		keypadpH();
	CALL        _keypadpH+0, 0
;aquarium.c,346 :: 		keypadsusev();
	CALL        _keypadsusev+0, 0
;aquarium.c,347 :: 		}
	GOTO        L_keypad106
L_keypad104:
;aquarium.c,348 :: 		else if(menu==2){
	MOVLW       0
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVLW       0
	MOVWF       R6 
	MOVLW       128
	MOVWF       R7 
	MOVF        _menu+0, 0 
	MOVWF       R0 
	MOVF        _menu+1, 0 
	MOVWF       R1 
	MOVF        _menu+2, 0 
	MOVWF       R2 
	MOVF        _menu+3, 0 
	MOVWF       R3 
	CALL        _Equals_Double+0, 0
	MOVLW       1
	BTFSS       STATUS+0, 2 
	MOVLW       0
	MOVWF       R0 
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_keypad107
;aquarium.c,349 :: 		optionc=2;
	MOVLW       2
	MOVWF       _optionc+0 
	MOVLW       0
	MOVWF       _optionc+1 
;aquarium.c,350 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;aquarium.c,351 :: 		Lcd_Out(2,1,"Otomatik secildi.");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr43_aquarium+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr43_aquarium+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;aquarium.c,352 :: 		Delay_ms(1000);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_keypad108:
	DECFSZ      R13, 1, 1
	BRA         L_keypad108
	DECFSZ      R12, 1, 1
	BRA         L_keypad108
	DECFSZ      R11, 1, 1
	BRA         L_keypad108
	NOP
	NOP
;aquarium.c,353 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;aquarium.c,356 :: 		}
	GOTO        L_keypad109
L_keypad107:
;aquarium.c,358 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;aquarium.c,359 :: 		Lcd_Out(2,1,"Yanlýs secim!");
	MOVLW       2
	MOVWF       FARG_Lcd_Out_row+0 
	MOVLW       1
	MOVWF       FARG_Lcd_Out_column+0 
	MOVLW       ?lstr44_aquarium+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(?lstr44_aquarium+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;aquarium.c,360 :: 		Delay_ms(1000);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_keypad110:
	DECFSZ      R13, 1, 1
	BRA         L_keypad110
	DECFSZ      R12, 1, 1
	BRA         L_keypad110
	DECFSZ      R11, 1, 1
	BRA         L_keypad110
	NOP
	NOP
;aquarium.c,361 :: 		goto start;                           }}
	GOTO        ___keypad_START
L_keypad109:
L_keypad106:
L_end_keypad:
	RETURN      0
; end of _keypad

_main:

;aquarium.c,366 :: 		void main() {
;aquarium.c,367 :: 		start();
	CALL        _start+0, 0
;aquarium.c,368 :: 		keypad();
	CALL        _keypad+0, 0
;aquarium.c,369 :: 		startvalue();
	CALL        _startvalue+0, 0
;aquarium.c,370 :: 		wait();
	CALL        _wait+0, 0
;aquarium.c,371 :: 		m=0;
	CLRF        _m+0 
	CLRF        _m+1 
;aquarium.c,372 :: 		mm=0;
	CLRF        _mm+0 
	CLRF        _mm+1 
;aquarium.c,373 :: 		sec=0;
	CLRF        _sec+0 
	CLRF        _sec+1 
;aquarium.c,374 :: 		sec1=0;
	CLRF        _sec1+0 
	CLRF        _sec1+1 
;aquarium.c,377 :: 		while(1){
L_main111:
;aquarium.c,378 :: 		sec1=sec1+1;
	INFSNZ      _sec1+0, 1 
	INCF        _sec1+1, 1 
;aquarium.c,379 :: 		calculations();
	CALL        _calculations+0, 0
;aquarium.c,380 :: 		conditions();
	CALL        _conditions+0, 0
;aquarium.c,381 :: 		cond2();
	CALL        _cond2+0, 0
;aquarium.c,382 :: 		print();
	CALL        _print+0, 0
;aquarium.c,385 :: 		}
	GOTO        L_main111
;aquarium.c,386 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
