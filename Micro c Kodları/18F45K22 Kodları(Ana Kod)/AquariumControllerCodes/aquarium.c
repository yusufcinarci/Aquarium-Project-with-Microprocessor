char keypadPort at PORTB;
//LCD Baglant�lar�
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
//LCD Baglant�lar�

//Tan�mlamalar

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

/****************************************/


#define LED PORTD.RD0
#define FEEDL PORTD.RD1
#define FAN PORTC.RC6
#define ON 1
#define OFF 0
#define ENTER 15
#define CLEAR 13


      void start(){
      feed=0;
      LED = OFF;
      FAN = OFF;
      ANSELC = 0;    // PORTC = Digital I/O
      ANSELB = 0;
      TRISA0_bit=1; // RA0=Input.
      TRISA1_bit=1;
     // TRISA2_bit=1;
      TRISC=0;      // PORTC=Output. Bu LCD icin.
      TRISD=0;      // PORTD=Output.

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
      // # tu�una bas�l�ncaya kadar bekleyin
      kp =0;
      while(kp!=ENTER)
      {
         do
           kp = Keypad_Key_Click();                    // Kp degeri Keypad_Key_Click() esittir;
         while(!kp);
                                             }
       Lcd_Cmd(_LCD_CLEAR);
                                                 }





     void calculations(){
     ldrvalue = ADC_Read(1);                     // Reading light voltage from A1 input.
     temp = ADC_Read(0);                         // A0 (input) girisinden s�cakl�k okunuyor.    //DE����M YAPILDI
     gerilim=0.0048828125*ldrvalue;              // input degerini voltaja donusturme
     mV = temp * 5000.0/1024.0;                  // mV donusturme .
     ActualTemp = mV/10.0 ;                      // Celcius a donusturme
     IntToStr(ActualTemp,Txt);
     IntToStr(gerilim,istxt);
    IntToStr(wlvl,wlvl1txt);
    IntToStr(susev,susevtxt);
                                       }


/* LED ve FAN i�in ko�ullar. Manuel ve otomatik se�enek i�in iki if blo�u vard�r. Eger otomotik secilirse, degerlerimiz biliniyor ve kosullar�m�z ona g�re secildi.
Eger manuel se�ilirse d�sar�dan bizim girdigimiz referans degerlerimiz olacakt�r.
*/
       void conditions(){
       if(optionc==1){
       if(gerilim>Volt_Ref){LED=ON;}
       else if(gerilim<Volt_Ref){LED=OFF;}
       if(ActualTemp<Temp_Ref){FAN=ON;}
       else if(ActualTemp>Temp_Ref){FAN=OFF;}

                                              }
      else if(optionc==2){
       Temp_Ref=25;
       Volt_Ref=3;
       wlvl=7;
       susev=3;
       if(ActualTemp<Temp_Ref){FAN=ON;}
       if(ActualTemp>Temp_Ref){FAN=OFF;}
       if(gerilim>Volt_Ref){LED=ON;}
       if(gerilim<Volt_Ref){LED=OFF;}

                                         }
                                                }
//Sayac kosullar�                                             /// timer kesme
     void cond2(){

     if(sec1>9){sec1=0; sec=sec+1;}
     if(sec>5){sec=0; m=m+1;}
     if(m>9){m=0; mm=mm+1;}
                                     }

/* LCD Ekrandaki son durumu yazd�rmak i�in yazd�rma i�levi*/
     void print(){
// Bu blok, de�erleri ASCII'ye d�n��t�rmek i�indir, daha sonra de�erleri LCD ekranda g�sterebiliriz.
     digit[0] = mm + 48;           // mm m : sec sec1;
     digit[1] = m + 48;            // mm m : sec sec1;
     digit1[0] = sec + 48;         // mm m : sec sec1;
     digit1[1] = sec1 + 48;        // mm m : sec sec1;

     Lcd_Out(1,1,"Temperature: ");
     Lcd_Out(1,15,Txt);
     Lcd_Out(2,1,"Light V: ");
     Lcd_Out(2,15,istxt);
     Lcd_Out(3,1,"pH: ");
     Lcd_Out(3,15,wlvl1txt);
     Lcd_Out(4,1,"Runtime :");
     Lcd_Out(4,12,digit);                    // LCD ekranda  2 sut�n ,7 karakter;
     Lcd_Out(4,14,dn);
     Lcd_Out(4,15,digit1);
     delay_ms(375);
     if(m==1 && feed==0){
      feed=1;
      FEEDL=ON;

      Lcd_Out(4,1,"Baliklari besleme zamani!");
      delay_ms(300);
      Lcd_Out(4,1,"                    ");
      delay_ms(300);
      Lcd_Out(4,1,"Baliklari besleme zamani!");
      delay_ms(300);
      Lcd_Out(4,1,"                    ");          }
      FEEDL=OFF;

                                                       }

 /*Manuel secenekte referans sicakligi secmek icin bu tu� tak�m� dongusu olustucag�z.Bu dongude kullan�c�dan referans degerini alacag�z.
 Kp degerimiz Keypad_Key_Click e esittir sonra Temp_Ref degi�kenimiz kp degerine e�it olacakt�r.
 Tu� tak�m�ndaki degerleri say�lara d�n��t�rmek i�in if bloklar� kullanacag�z. */

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
         if (kp == ENTER )break;
         if (kp > 3 && kp < 8) kp = kp-1;
         if (kp > 8 && kp < 12) kp = kp-2;
         if (kp ==14)kp = 0;
         if ( kp == CLEAR )goto START1;
         Lcd_Chr_Cp(kp + '0');
         Temp_Ref =(10*Temp_Ref) + kp;
                                             }

      intToStr(Temp_Ref,Txt);
      wait();


                                               }

 /* Bu i�levi LCD ekranda men� se�ene�ini ve referans de�erlerini g�stermek i�in olu�turdum. Eger otomatik secilirse degerlerimiz bilinecektir,
 Eger manuel secilirse, Kullan�c� referans degerlerini girer ve LCD ekran ustunde g�rebiliriz */

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
          Delay_ms(2000);                   }
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
 /* Manuel se�enekte referans voltaj�n� se�mek i�in bu tu� tak�m� d�ng�s�n� kullanacag�z. Bu d�ng�de kullan�c�dan referans de�erini alaca��z.
 Kp de�erimiz Keypad_Key_Click'e e�it oldu�undan Volt_Ref de�i�kenimiz kp de�erine e�it olacakt�r.
 Tu� tak�m�ndaki de�erleri say�lara d�n��t�rmek i�in if bloklar�n� kullacag�z.
 */
       void keypadvolt(){

       START2:

       Lcd_Cmd(_LCD_CLEAR);
       Lcd_Out(1, 1, "Volt degeri giriniz");               //Referans S�cakl���n� Lcd'de belirlenen yere Keypad ile girmemizi sa�lar
       Volt_Ref=0;
           Lcd_Out(3,1,"0-4 Volt araliginda.");
        Lcd_Out(2, 1, "Ref.Volt: ");
        while(1)
        {
         do
         kp = Keypad_Key_Click();
         while (!kp);
         if ( kp == ENTER )break;
         if (kp > 3 && kp < 8) kp = kp-1;
         if (kp > 8 && kp < 12) kp = kp-2;
         if (kp ==14)kp = 0;
         if ( kp == CLEAR )goto START2;
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
         if ( kp == ENTER )break;
         if (kp > 3 && kp < 8) kp = kp-1;
         if (kp > 8 && kp < 12) kp = kp-2;
         if (kp ==14)kp = 0;
         if ( kp == CLEAR )goto START3;
           Lcd_Chr_Cp(kp + '0');
              wlvl_Ref =  kp;
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
         if ( kp == ENTER )break;
         if (kp > 3 && kp < 8) kp = kp-1;
         if (kp > 8 && kp < 12) kp = kp-2;
         if (kp ==14)kp = 0;
         if ( kp == CLEAR )goto START4;
           Lcd_Chr_Cp(kp + '0');
              susev_Ref = kp;
                                              }
            intToStr(susev_Ref,susevtxt);
                                          }

 /* Men�deki otomatik ve manuel se�ene�i se�mek i�in bu tu� tak�m� d�ng�s� kullan�lacakt�r. Bu d�ng�de kullan�c�dan men� de�erini alaca��z.
 Kp de�erimiz Keypad_Key_Click'e e�ittir, ard�ndan men� se�enek de�i�kenimiz kp de�erine e�it olacakt�r.
 Tu� tak�m�ndaki de�erleri say�lara d�n��t�rmek i�in if bloklar�n� kullacag�z.
 */

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
         if ( kp == ENTER )break;
         if (kp > 3 && kp < 8) kp = kp-1;
         if (kp > 8 && kp < 12) kp = kp-2;
         if (kp ==14)kp = 0;
         if (kp == CLEAR )goto START;
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
       Lcd_Out(2,1,"Yanl�s secim!");
       Delay_ms(1000);
        goto start;                           }}


  void uart() {                 //uart haberle�me mod�l�
    TRISB=0x00;
    OSCCON=0x67;       //Configure OSCON Register to use
                       //internal oscillator. Please check datasheet


    UART1_Init(19200);     // Initialize UART module at 9600 bps
    Delay_ms(100);        // Wait for UART module to stabilize

             while(1){
    if (UART1_Data_Ready()) {     // If data is received,
             uart_rd = UART1_Read();     // read the received data
             switch(uart_rd){
             case 'a':LATD2_bit = 1;
                      LATD3_bit = 0;
                      LATD4_bit = 0;

             break;

             case 'b':LATD2_bit = 0;
                      LATD3_bit = 1;                   //uart haberle�me mod�l�
                      LATD4_bit = 0;

             break;
             case 'c':LATD2_bit = 0;
                      LATD3_bit = 0;
                      LATD4_bit = 1;

             break;
              default:LATD1_bit = 0;
                      LATD2_bit = 0;
                      LATD3_bit = 0;
             break;

                 }
           }
         }        }
         
      void check_device(unsigned short dev_address){
      I2C1_Start();
      if (I2C1_Wr(dev_address)){
      Lcd_Out(2,1,"Cihaz Bulunamad�");                            //i2c haberle�me mod�l�
                                                       }
      else Lcd_Out(2,1,"Cihaz calismaya hazir ");
      I2C1_Stop();
}



 /*Ana k�s�m buradad�r ve burada ad�m ad�m fonksiyonlar �a�r�l�r. */
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