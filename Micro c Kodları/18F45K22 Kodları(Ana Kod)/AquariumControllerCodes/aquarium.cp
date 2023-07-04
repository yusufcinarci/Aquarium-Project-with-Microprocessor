#line 1 "D:/Yusuf/Projeler/Mikroiþlemci Projem/Aquarium Project/AquariumController/AquariumControllerCodes/aquarium.c"
char keypadPort at PORTB;

sbit LCD_RS at LATC4_bit;
sbit LCD_EN at LATC5_bit;
sbit LCD_D4 at LATC0_bit;
sbit LCD_D5 at LATC1_bit;
sbit LCD_D6 at LATC2_bit;
sbit LCD_D7 at LATC3_bit;

sbit LCD_RS_Direction at TRISC4_bit;
sbit LCD_EN_Direction at TRISC5_bit;
sbit LCD_D4_Direction at TRISC0_bit;
sbit LCD_D5_Direction at TRISC1_bit;
sbit LCD_D6_Direction at TRISC2_bit;
sbit LCD_D7_Direction at TRISC3_bit;




unsigned short kp, Txt[14], istxt[14], voltxt[14],wlvl1txt[14],susevtxt[14];
unsigned char inTemp, inVolt;
unsigned int temp,wlvl=7,susev=3;
float mV, ActualTemp, Temp_Ref, Volt_Ref,wlvl_Ref,susev_Ref;
float menu;
float ldrvalue, gerilim;
unsigned int optionc;
unsigned int feed;
unsigned int mm;
unsigned int m;
unsigned int sec;
unsigned int sec1;
char uart_rd;
char *digit="--";
char *digit1="--";
char dn[]=":";
#line 49 "D:/Yusuf/Projeler/Mikroiþlemci Projem/Aquarium Project/AquariumController/AquariumControllerCodes/aquarium.c"
 void start(){
 feed=0;
  PORTD.RD0  =  0 ;
  PORTC.RC6  =  0 ;
 ANSELC = 0;
 ANSELB = 0;
 TRISA0_bit=1;
 TRISA1_bit=1;

 TRISC=0;
 TRISD=0;

 Keypad_Init();
 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
 Lcd_Out(1,6, "174207005");
 Lcd_Out(2,4, "Yusuf Cinarci");
 Lcd_Out(3,2, "Akvaryum Kontrolu");
 delay_ms(2000);
 Lcd_Cmd(_LCD_CLEAR);

 }


 void wait(){
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(2, 1, "# ile devam ediniz .");

 kp =0;
 while(kp!= 15 )
 {
 do
 kp = Keypad_Key_Click();
 while(!kp);
 }
 Lcd_Cmd(_LCD_CLEAR);
 }





 void calculations(){
 ldrvalue = ADC_Read(1);
 temp = ADC_Read(0);
 gerilim=0.0048828125*ldrvalue;
 mV = temp * 5000.0/1024.0;
 ActualTemp = mV/10.0 ;
 IntToStr(ActualTemp,Txt);
 IntToStr(gerilim,istxt);
 IntToStr(wlvl,wlvl1txt);
 IntToStr(susev,susevtxt);
 }
#line 108 "D:/Yusuf/Projeler/Mikroiþlemci Projem/Aquarium Project/AquariumController/AquariumControllerCodes/aquarium.c"
 void conditions(){
 if(optionc==1){
 if(gerilim>Volt_Ref){ PORTD.RD0 = 1 ;}
 else if(gerilim<Volt_Ref){ PORTD.RD0 = 0 ;}
 if(ActualTemp<Temp_Ref){ PORTC.RC6 = 1 ;}
 else if(ActualTemp>Temp_Ref){ PORTC.RC6 = 0 ;}

 }
 else if(optionc==2){
 Temp_Ref=25;
 Volt_Ref=3;
 wlvl=7;
 susev=3;
 if(ActualTemp<Temp_Ref){ PORTC.RC6 = 1 ;}
 if(ActualTemp>Temp_Ref){ PORTC.RC6 = 0 ;}
 if(gerilim>Volt_Ref){ PORTD.RD0 = 1 ;}
 if(gerilim<Volt_Ref){ PORTD.RD0 = 0 ;}

 }
 }

 void cond2(){

 if(sec1>9){sec1=0; sec=sec+1;}
 if(sec>5){sec=0; m=m+1;}
 if(m>9){m=0; mm=mm+1;}
 }


 void print(){

 digit[0] = mm + 48;
 digit[1] = m + 48;
 digit1[0] = sec + 48;
 digit1[1] = sec1 + 48;

 Lcd_Out(1,1,"Temperature: ");
 Lcd_Out(1,15,Txt);
 Lcd_Out(2,1,"Light V: ");
 Lcd_Out(2,15,istxt);
 Lcd_Out(3,1,"pH: ");
 Lcd_Out(3,15,wlvl1txt);
 Lcd_Out(4,1,"Runtime :");
 Lcd_Out(4,12,digit);
 Lcd_Out(4,14,dn);
 Lcd_Out(4,15,digit1);
 delay_ms(375);
 if(m==1 && feed==0){
 feed=1;
  PORTD.RD1 = 1 ;

 Lcd_Out(4,1,"Baliklari besleme zamani!");
 delay_ms(300);
 Lcd_Out(4,1,"                    ");
 delay_ms(300);
 Lcd_Out(4,1,"Baliklari besleme zamani!");
 delay_ms(300);
 Lcd_Out(4,1,"                    "); }
  PORTD.RD1 = 0 ;

 }
#line 174 "D:/Yusuf/Projeler/Mikroiþlemci Projem/Aquarium Project/AquariumController/AquariumControllerCodes/aquarium.c"
 void keypadtemp(){
 START1:
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1, 1, "Sicakligi gir");
 Temp_Ref=0;
 Lcd_Out(2, 1, "Ref.Sicak:");
 while(1)
 {
 do
 kp = Keypad_Key_Click();
 while (!kp);
 if (kp ==  15  )break;
 if (kp > 3 && kp < 8) kp = kp-1;
 if (kp > 8 && kp < 12) kp = kp-2;
 if (kp ==14)kp = 0;
 if ( kp ==  13  )goto START1;
 Lcd_Chr_Cp(kp + '0');
 Temp_Ref =(10*Temp_Ref) + kp;
 }

 intToStr(Temp_Ref,Txt);
 wait();


 }
#line 203 "D:/Yusuf/Projeler/Mikroiþlemci Projem/Aquarium Project/AquariumController/AquariumControllerCodes/aquarium.c"
 void startvalue(){
 if(optionc==1){
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1,1,"Ref. Sicaklik: ");
 Lcd_Out(1,15,Txt);
 Lcd_Out(2,1,"Ref. Volt:  ");
 Lcd_Out(2,15,voltxt);
 Lcd_Out(3,1,"Ref. pH:  ");
 Lcd_Out(3,15,wlvl1txt);
 Lcd_Out(4,1,"Ref. susev:  ");
 Lcd_Out(4,15,susevtxt);
 Delay_ms(2000); }
 else if(optionc==2){
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1,1,"Ref. Sicaklik:  ");
 Lcd_Out(1,15,"25*C");
 Lcd_Out(2,1,"Ref. Volt:  ");
 Lcd_Out(2,17,"3V");
 Lcd_Out(3,1,"Ref. pH:  ");
 Lcd_Out(3,15,"  7 ");
 Lcd_Out(4,1,"Ref. susev:  ");
 Lcd_Out(4,15,"  3");

 Delay_ms(2000);
 }

 }
#line 234 "D:/Yusuf/Projeler/Mikroiþlemci Projem/Aquarium Project/AquariumController/AquariumControllerCodes/aquarium.c"
 void keypadvolt(){

 START2:

 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1, 1, "Volt degeri giriniz");
 Volt_Ref=0;
 Lcd_Out(3,1,"0-4 Volt araliginda.");
 Lcd_Out(2, 1, "Ref.Volt: ");
 while(1)
 {
 do
 kp = Keypad_Key_Click();
 while (!kp);
 if ( kp ==  15  )break;
 if (kp > 3 && kp < 8) kp = kp-1;
 if (kp > 8 && kp < 12) kp = kp-2;
 if (kp ==14)kp = 0;
 if ( kp ==  13  )goto START2;
 Lcd_Chr_Cp(kp + '0');
 Volt_Ref =(10*Volt_Ref) + kp;
 }

 intToStr(Volt_Ref,voltxt);
 wait();
 }

 void keypadpH(){

 START3:

 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1, 1, "pH degeri giriniz");
 wlvl_Ref=0;
 Lcd_Out(3,1,"0-14  araliginda.");
 Lcd_Out(2, 1, "Ref.pH: ");
 while(1)
 {
 do
 kp = Keypad_Key_Click();
 while (!kp);
 if ( kp ==  15  )break;
 if (kp > 3 && kp < 8) kp = kp-1;
 if (kp > 8 && kp < 12) kp = kp-2;
 if (kp ==14)kp = 0;
 if ( kp ==  13  )goto START3;
 Lcd_Chr_Cp(kp + '0');
 wlvl_Ref = kp;
 }
 intToStr(wlvl_Ref,wlvl1txt);
 wait();
 }

 void keypadsusev(){
 START4:

 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1, 1, "suseviye degeri gir");
 susev_Ref=0;
 Lcd_Out(3,1,"0-3 araliginda.");
 Lcd_Out(2, 1, "Ref.susev: ");
 while(1)
 {
 do
 kp = Keypad_Key_Click();
 while (!kp);
 if ( kp ==  15  )break;
 if (kp > 3 && kp < 8) kp = kp-1;
 if (kp > 8 && kp < 12) kp = kp-2;
 if (kp ==14)kp = 0;
 if ( kp ==  13  )goto START4;
 Lcd_Chr_Cp(kp + '0');
 susev_Ref = kp;
 }
 intToStr(susev_Ref,susevtxt);
 }
#line 316 "D:/Yusuf/Projeler/Mikroiþlemci Projem/Aquarium Project/AquariumController/AquariumControllerCodes/aquarium.c"
 void keypad(){
 START:
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(1, 1, "Bir opsiyon seciniz:");
 menu=0;
 Lcd_Out(2, 1, ">>Manuel icin (1) ");
 Lcd_Out(3, 1, ">>Otomatik icin (2) ");
 Lcd_Out(4,1,">># ile devam ediniz ");
 while(1)
 {
 do
 kp = Keypad_Key_Click();
 while (!kp);
 if ( kp ==  15  )break;
 if (kp > 3 && kp < 8) kp = kp-1;
 if (kp > 8 && kp < 12) kp = kp-2;
 if (kp ==14)kp = 0;
 if (kp ==  13  )goto START;
 Lcd_Chr_Cp(kp + '0');
 menu =(10*menu) + kp;
 }
 if(menu==1){
 optionc=1;
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(2,1,"Manuel secildi");
 Delay_ms(1000);
 Lcd_Cmd(_LCD_CLEAR);
 keypadtemp();
 keypadvolt();
 keypadpH();
 keypadsusev();
 }
 else if(menu==2){
 optionc=2;
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(2,1,"Otomatik secildi.");
 Delay_ms(1000);
 Lcd_Cmd(_LCD_CLEAR);


 }
 else{
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Out(2,1,"Yanlýs secim!");
 Delay_ms(1000);
 goto start; }}




 void main() {
 start();
 keypad();
 startvalue();
 wait();
 m=0;
 mm=0;
 sec=0;
 sec1=0;


 while(1){
 sec1=sec1+1;
 calculations();
 conditions();
 cond2();
 print();


 }
 }
