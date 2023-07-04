
_main:

;MyProject.c,2 :: 		void main() {
;MyProject.c,3 :: 		TRISB=0x00;
	CLRF        TRISB+0 
;MyProject.c,4 :: 		OSCCON=0x67;       //Configure OSCON Register to use
	MOVLW       103
	MOVWF       OSCCON+0 
;MyProject.c,8 :: 		UART1_Init(19200);     // Initialize UART module at 9600 bps
	BSF         BAUDCON+0, 3, 0
	CLRF        SPBRGH+0 
	MOVLW       103
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;MyProject.c,9 :: 		Delay_ms(100);        // Wait for UART module to stabilize
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_main0:
	DECFSZ      R13, 1, 1
	BRA         L_main0
	DECFSZ      R12, 1, 1
	BRA         L_main0
	DECFSZ      R11, 1, 1
	BRA         L_main0
	NOP
;MyProject.c,11 :: 		while (1) {                     // Endless loop
L_main1:
;MyProject.c,12 :: 		if (UART1_Data_Ready()) {     // If data is received,
	CALL        _UART1_Data_Ready+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main3
;MyProject.c,13 :: 		uart_rd = UART1_Read();     // read the received data
	CALL        _UART1_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _uart_rd+0 
;MyProject.c,14 :: 		switch(uart_rd){
	GOTO        L_main4
;MyProject.c,15 :: 		case 'a':LATB0_bit = 1;
L_main6:
	BSF         LATB0_bit+0, BitPos(LATB0_bit+0) 
;MyProject.c,16 :: 		LATB1_bit = 0;
	BCF         LATB1_bit+0, BitPos(LATB1_bit+0) 
;MyProject.c,17 :: 		LATB2_bit = 0;
	BCF         LATB2_bit+0, BitPos(LATB2_bit+0) 
;MyProject.c,19 :: 		break;
	GOTO        L_main5
;MyProject.c,21 :: 		case 'b':LATB0_bit = 0;
L_main7:
	BCF         LATB0_bit+0, BitPos(LATB0_bit+0) 
;MyProject.c,22 :: 		LATB1_bit = 1;
	BSF         LATB1_bit+0, BitPos(LATB1_bit+0) 
;MyProject.c,23 :: 		LATB2_bit = 0;
	BCF         LATB2_bit+0, BitPos(LATB2_bit+0) 
;MyProject.c,25 :: 		break;
	GOTO        L_main5
;MyProject.c,26 :: 		case 'c':LATB0_bit = 0;
L_main8:
	BCF         LATB0_bit+0, BitPos(LATB0_bit+0) 
;MyProject.c,27 :: 		LATB1_bit = 0;
	BCF         LATB1_bit+0, BitPos(LATB1_bit+0) 
;MyProject.c,28 :: 		LATB2_bit = 1;
	BSF         LATB2_bit+0, BitPos(LATB2_bit+0) 
;MyProject.c,30 :: 		break;
	GOTO        L_main5
;MyProject.c,31 :: 		default:LATB0_bit = 0;
L_main9:
	BCF         LATB0_bit+0, BitPos(LATB0_bit+0) 
;MyProject.c,32 :: 		LATB1_bit = 0;
	BCF         LATB1_bit+0, BitPos(LATB1_bit+0) 
;MyProject.c,33 :: 		LATB2_bit = 0;
	BCF         LATB2_bit+0, BitPos(LATB2_bit+0) 
;MyProject.c,34 :: 		break;
	GOTO        L_main5
;MyProject.c,36 :: 		}
L_main4:
	MOVF        _uart_rd+0, 0 
	XORLW       97
	BTFSC       STATUS+0, 2 
	GOTO        L_main6
	MOVF        _uart_rd+0, 0 
	XORLW       98
	BTFSC       STATUS+0, 2 
	GOTO        L_main7
	MOVF        _uart_rd+0, 0 
	XORLW       99
	BTFSC       STATUS+0, 2 
	GOTO        L_main8
	GOTO        L_main9
L_main5:
;MyProject.c,37 :: 		}
L_main3:
;MyProject.c,38 :: 		}
	GOTO        L_main1
;MyProject.c,40 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
