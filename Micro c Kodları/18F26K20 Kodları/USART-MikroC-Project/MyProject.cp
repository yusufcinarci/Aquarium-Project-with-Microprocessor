#line 1 "C:/Users/Yusuf/Desktop/Mikroiþlemci ÖDEVÝ/Yazýlým Dosyalarý/Micro c Kodlarý/18F26K20 Kodlarý/USART-MikroC-Project/MyProject.c"
char uart_rd;
void main() {
 TRISB=0x00;
 OSCCON=0x67;



 UART1_Init(19200);
 Delay_ms(100);

 while (1) {
 if (UART1_Data_Ready()) {
 uart_rd = UART1_Read();
 switch(uart_rd){
 case 'a':LATB0_bit = 1;
 LATB1_bit = 0;
 LATB2_bit = 0;

 break;

 case 'b':LATB0_bit = 0;
 LATB1_bit = 1;
 LATB2_bit = 0;

 break;
 case 'c':LATB0_bit = 0;
 LATB1_bit = 0;
 LATB2_bit = 1;

 break;
 default:LATB0_bit = 0;
 LATB1_bit = 0;
 LATB2_bit = 0;
 break;

 }
 }
 }

}
