using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.IO.Ports;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace AkvaryumDemo
{

    public partial class Form1 : Form
    {
        SerialPort SerialPort1 = new SerialPort();
        String comname = "COM2";
        String rate = "9600";
        int manueldeger = 0;
        String sicaklikgirin = "Sıcaklık değeri giriniz :  ";
        String isikgirin = "Sıcaklık değeri belirlendi. Işığın değerini giriniz (Volt) :";
        String phgirin = "Işık değeri belirlendi. pH değerini giriniz) :";
        String manueltamamlandi = "Manuel değer girişi tamamlandı.";
        String yusufbilgiler = "YUSUF ÇINARCI \n AKVARYUM PROJESİ \n Lütfen Bekleyin...";
        int sicaklikdeger = 0;
        int degergirildi = 0;
        int isikvolt = 0;
        int isik = 0;
        int pH = 0;
        int hosgeldinyazisikalmasuresi = 0;
        int manuelyazisikalmasuresi = 0;
        int otomatikyazisikalmasuresi = 0;
        public Form1()
        {
            InitializeComponent();
            try
            {
                serialPort1.PortName = comname;
                serialPort1.BaudRate = Convert.ToInt16(rate);

                if (!serialPort1.IsOpen)
                {
                    serialPort1.Open();
                    label4.Text = "Bağlanıldı.";
                    label4.ForeColor = Color.Lime;
                }

            }
            catch (Exception)
            {
                label4.Text = "Bağlantı Yok";
                label4.ForeColor = Color.Red;
            }
        }


        private void Form1_Load(object sender, EventArgs e)
        {
            lcdyazi.Text = yusufbilgiler;
            sicaklikdegeryazi.Text = sicaklikdeger + "°C";
            if (isik == 0)
            {
                isikdegeryazi.Text = "Kapalı";
            }
            if (isik == 1)
            {
                isikdegeryazi.Text = "Açık" + isikvolt + "V";
            }
            phdegeryazi.Text = pH + "pH";
            timer1.Start();

        }

        private void button1_Click(object sender, EventArgs e)
        {
            if (manueldeger == 0)
            {
                lcdyazi.Text = "Manuel Modu Seçiliyor..."; lcdyazi.Refresh();
            }

            manueldeger++;
            timer2.Start();
            if (manueldeger > 1)
            {
                if (lcdyazi.Text == sicaklikgirin || lcdyazi.Text == isikgirin || lcdyazi.Text == phgirin)

                {

                    lcdyazi.Text = "1"; lcdyazi.Refresh();

                }

                else

                {

                    lcdyazi.Text = lcdyazi.Text + "1";

                }
            }




        }

        private void button2_Click(object sender, EventArgs e)
        {
            if (manueldeger == 0)
            {
                lcdyazi.Text = "Otomatik Modu Seçiliyor..."; lcdyazi.Refresh();
                timer3.Start();
                sicaklikdegeryazi.Text = "20°C";
                isikdegeryazi.Text = "Açık, 20V";
                phdegeryazi.Text = "7 pH";
            }
            if (manueldeger >= 1)
            {
                if (lcdyazi.Text == sicaklikgirin || lcdyazi.Text == isikgirin || lcdyazi.Text == phgirin)

                {

                    lcdyazi.Text = "2"; lcdyazi.Refresh();

                }

                else

                {

                    lcdyazi.Text = lcdyazi.Text + "2";

                }
            }
        }

        private void button3_Click(object sender, EventArgs e)
        {
            if (manueldeger >= 1)
            {
                if (lcdyazi.Text == sicaklikgirin || lcdyazi.Text == isikgirin || lcdyazi.Text == phgirin)

                {

                    lcdyazi.Text = "3"; lcdyazi.Refresh();

                }

                else

                {

                    lcdyazi.Text = lcdyazi.Text + "3";

                }
            }
        }

        private void button4_Click(object sender, EventArgs e)
        {

            if (manueldeger >= 1)
            {
                if (lcdyazi.Text == sicaklikgirin || lcdyazi.Text == isikgirin || lcdyazi.Text == phgirin)

                {




                }

                else

                {

                    lcdyazi.Text = lcdyazi.Text + "4";

                }
            }
        }

        private void button5_Click(object sender, EventArgs e)
        {
            if (manueldeger >= 1)
            {
                if (lcdyazi.Text == sicaklikgirin || lcdyazi.Text == isikgirin || lcdyazi.Text == phgirin)

                {

                    lcdyazi.Text = "5"; lcdyazi.Refresh();

                }

                else

                {

                    lcdyazi.Text = lcdyazi.Text + "5";

                }
            }
        }

        private void button6_Click(object sender, EventArgs e)
        {
            if (manueldeger >= 1)
            {
                if (lcdyazi.Text == sicaklikgirin || lcdyazi.Text == isikgirin || lcdyazi.Text == phgirin)

                {

                    lcdyazi.Text = "6"; lcdyazi.Refresh();

                }

                else

                {

                    lcdyazi.Text = lcdyazi.Text + "6";

                }
            }
        }

        private void button7_Click(object sender, EventArgs e)
        {
            if (manueldeger >= 1)
            {
                if (lcdyazi.Text == sicaklikgirin || lcdyazi.Text == isikgirin || lcdyazi.Text == phgirin)

                {

                    lcdyazi.Text = "7"; lcdyazi.Refresh();

                }

                else

                {

                    lcdyazi.Text = lcdyazi.Text + "7";

                }
            }
        }

        private void button8_Click(object sender, EventArgs e)
        {
            if (manueldeger >= 1)
            {
                if (lcdyazi.Text == sicaklikgirin || lcdyazi.Text == isikgirin || lcdyazi.Text == phgirin)

                {

                    lcdyazi.Text = "8"; lcdyazi.Refresh();

                }

                else

                {

                    lcdyazi.Text = lcdyazi.Text + "8";

                }
            }
        }

        private void button9_Click(object sender, EventArgs e)
        {
            if (manueldeger >= 1)
            {
                if (lcdyazi.Text == sicaklikgirin || lcdyazi.Text == isikgirin || lcdyazi.Text == phgirin)

                {

                    lcdyazi.Text = "9"; lcdyazi.Refresh();

                }

                else

                {

                    lcdyazi.Text = lcdyazi.Text + "9";

                }
            }
        }

        private void button10_Click(object sender, EventArgs e)
        {
            if (lcdyazi.Text == sicaklikgirin || lcdyazi.Text == isikgirin || lcdyazi.Text == phgirin)
            {

            }
            Application.Restart();
        }

        private void button11_Click(object sender, EventArgs e)
        {
            if (manueldeger >= 1)
            {
                if (lcdyazi.Text == sicaklikgirin || lcdyazi.Text == isikgirin || lcdyazi.Text == phgirin)

                {

                    lcdyazi.Text = "0"; lcdyazi.Refresh();

                }

                else

                {

                    lcdyazi.Text = lcdyazi.Text + "0";

                }
            }

        }

        private void button12_Click(object sender, EventArgs e)
        {
            degergirildi++;

            if (degergirildi == 1)
            {
                int sayi = Convert.ToInt32(lcdyazi.Text);
                sicaklikdegeryazi.Text = sayi.ToString() + "°C";
                lcdyazi.Text = isikgirin;

            }

            if (degergirildi == 2)
            {
                int sayi2 = Convert.ToInt32(lcdyazi.Text);
                isikdegeryazi.Text = sayi2.ToString() + "V, Açık";
                lcdyazi.Text = phgirin;
                isik++;

            }
            if (degergirildi == 3)
            {

                int sayi3 = Convert.ToInt32(lcdyazi.Text);
                phdegeryazi.Text = sayi3.ToString() + "pH";
                lcdyazi.Text = manueltamamlandi;
            }


        }
        private void timer1_Tick(object sender, EventArgs e)
        {
            hosgeldinyazisikalmasuresi++;

            if (hosgeldinyazisikalmasuresi == 20)
            {
                lcdyazi.Text = "Manuel (1'e basın) \n Otomatik (2'ye basın)";
                timer1.Stop();

            }

        }

        private void timer2_Tick(object sender, EventArgs e)
        {
            manuelyazisikalmasuresi++;
            if (manuelyazisikalmasuresi == 20)
            {

                lcdyazi.Text = sicaklikgirin;
                sicaklikdeger++;
                timer1.Stop();

            }
        }

        private void timer3_Tick(object sender, EventArgs e)
        {
            otomatikyazisikalmasuresi++;
            if (otomatikyazisikalmasuresi == 20)
            {

                lcdyazi.Text = "Balığınıza uygun sıcaklık değeri otomatik olarak girilmiştir.";
                timer3.Stop();

            }
        }
        private void btnRedLEDON_Click(object sender, EventArgs e)
        {
            char[] buff = new char[1];
            buff[0] = '4'; //ASCII for 4.
            SerialPort1.Write(buff, 0, 1);
            redLEDOFF.Visible = true;
            redLEDON.Visible = false;
        }
        private void btnREDLEDOFF_Click(object sender, EventArgs e)
        {
            char[] buff = new char[1];
            buff[0] = '1'; //ASCII for 1.
            SerialPort1.Write(buff, 0, 1);
            redLEDOFF.Visible = false;
            redLEDON.Visible = true;
            yellowLEDOFF.Visible = true;
            yellowLEDOFF.Visible = true;
        }

        private void btnyellowLEDON_Click(object sender, EventArgs e)
        {
            char[] buff = new char[1];
            buff[0] = '4'; //ASCII for 4.
            SerialPort1.Write(buff, 0, 1);
            yellowLEDOFF.Visible = true;
            yellowLEDON.Visible = false;
        }

        private void greenLEDOFF_Click(object sender, EventArgs e)
        {
            char[] buff = new char[1];
            buff[0] = '2'; //ASCII for 2.
            SerialPort1.Write(buff, 0, 1);
            yellowLEDOFF.Visible = false;
            yellowLEDON.Visible = true;
            yellowLEDOFF.Visible = true;
            redLEDOFF.Visible = true;
        }

        private void btngreenLEDON_Click(object sender, EventArgs e)
        {
            char[] buff = new char[1];
            buff[0] = '3'; //ASCII for 3.
            SerialPort1.Write(buff, 0, 1);
            yellowLEDOFF.Visible = false;
            greenLEDON.Visible = true;
            yellowLEDOFF.Visible = true;
            redLEDOFF.Visible = true;
        }

        private void btngreenLEDOFF_Click(object sender, EventArgs e)
        {
            char[] buff = new char[1];
            buff[0] = '4'; //ASCII for 4.
            SerialPort1.Write(buff, 0, 1);
            yellowLEDOFF.Visible = true;
            greenLEDON.Visible = false;
        }

        private void panel2_Paint(object sender, PaintEventArgs e)
        {

        }
    }
}
