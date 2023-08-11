# Aquarium-Project-with-Microprocessor
Bu çalışmada PIC18F45K22 Mikdrodenetleyicisi kullanılarak akvaryum sistemi otomatik ve manuel olarak iki ayrı şekilde Proteus üzerinden simüle edilmiştir. Microdenetleyici MicroC Pro aracılığı ile programlanmıştır. C# üzerinden yaptığımız arayüz ile PIC18F26K20 mikroişlemcisi kullanılarak proteus üzerinden iki taraflı kontrol sağlanmıştır..

Bu projeyi okulumuzda Microişlemci Projesi dersinde yapmış bulunmaktayım. Hali hazırda tezi ve makalesini de bitmiş durumdadır. Bu kısımda detaylı olarak incelemeye çalışacağım.

### Sistemin Çalışma Mantığı ve Kullanılan Malzemeler

Akvaryum kontrolünde kullanılan malzemeler ve haberleşme çeşitlerini, tüm kontrol sistemlerini, kullanılan sensörleri, diyagramları, kullanılan elemanların teknik özellikleri ile ilgili olan bilgiler ayrıntılı olarak bu bölümde verilmektedir. Şekilde sistemin çalışma mantığı blok diyagramla verilmiştir.

![blog diyagram1](https://github.com/yusufcinarci/Aquarium-Project-with-Microprocessor/assets/77057546/5d8490f8-8b8a-400c-926a-d7e0dd73493e)

Micro c üzerinden kaynak kodları ile sıcaklık, ışık, su seviyesi ve pH değeri kontrolünü PROTEUS simülasyonu üstünden PIC18F45K22 ile LCD ekran yardımıyla kontrol edilmiştir. PROTEUS simülasyonunda ilk başta LCD ekran üzerinde manuel ve otomatik olmak üzere iki seçenek verilmiştir. Manuel seçmemiz durumunda dışarıdan PROTEUS simülasyonundaki KEYPAD aracılığı ile değerler belirlenmiştir. İstediğimiz ışık, sıcaklık veya suyun PH değerlerini ayarlanmıştır. Otomatik seçeneği ile Micro c üstünden ortalama değerleri otomatik olarak ekrana yansıtıp simülasyonu üzerinden gösterilmiştir. Balık yemleme sistemi ile istenen zaman aralıklarında yemleme yapılmıştır. Şekil 2 de gösterilmiştir. 

![blogdiyagram2](https://github.com/yusufcinarci/Aquarium-Project-with-Microprocessor/assets/77057546/990b8516-8bee-4f7d-9486-f04aed2ab151)

### Sistemin Proteus Üzerinden Simülasyonu

Micro c üzerinden kaynak kodları ile sıcaklık, ışık, su seviyesi ve pH değeri kontrolünü PROTEUS simülasyonu üstünden PIC18F45K22 ile LCD ekran yardımıyla kontrol edilmiştir. PROTEUS simülasyonunda ilk başta LCD ekran üzerinde manuel ve otomatik olmak üzere iki seçenek verilmiştir. Manuel seçmemiz durumunda dışarıdan PROTEUS simülasyonundaki KEYPAD aracılığı ile değerleri kendimiz belirledik. İstediğimiz ışık, sıcaklık veya suyun PH değerlerini ayarlanmıştır. Otomatik seçeneği ile Micro c üstünden ortalama değerleri otomatik olarak ekrana yansıtıp simülasyonu üzerinden gösterilmiştir. 

![xxx](https://github.com/yusufcinarci/Aquarium-Project-with-Microprocessor/assets/77057546/0577cc69-c513-4a99-bbce-c7320a9c788f)

### Sistemin C# Üzerinden Gösterilmesi

C# üstündeki arayüz ile birlikte pH, ışık kontrolü ve sıcaklık kontrolü de bu arayüz üstünden PROTEUS simülasyonu yardımı ile kontrol edilebileceği gibi anlık sıcaklık, ışık ve PH değerlerini de anlık olarak C#’ a aktarılmıştır.

![c#](https://github.com/yusufcinarci/Aquarium-Project-with-Microprocessor/assets/77057546/829f465c-c3b9-47e0-8523-815436c30e0c)

Şekillerde görüldüğü gibi C# arayüzünü çalıştırmaya başladıktan sonra manuel ve otomatik olmak üzere arayüzde de iki seçenek verilmiştir. Bu iki seçenekten herhangi biri girildiğinde şekildeki gibi küçük ekranda değerler alınmıştır. Otomatik seçeneğindeki veriler kendi belirlemiş olduğumuz değerler olarak alınmıştır.Bu değerleri aynı anda proteustaki simülasyonda ki LCD ekrandaki  verileride  çekerek kullanabildiğimiz gösterilmiştir. Hem arayüz üstünden hem de simülayondaki keypad üstünden kullanabildiğimiz bir sistem tasarlanmıştır.

### Sistemin Çalışma Prensibinin Videosu 

[<img src="https://r.resimlink.com/cpI2a_mYREKo.jpg" width="50%">](https://drive.google.com/file/d/1TcCQ9HTlAhuZIJ-u0hB-9x-mBtNtEzVH/view?usp=drive_link)

### Sonuçlar

Tasarlanan akvaryum kontrolü sistemi ile balıklar için hayati önem taşıyan ihtiyaçlardan biri olan beslenme, gerekli zamanlarda gerekli miktarda tedarik edilebilmiştir. Bu yemleme sistemi her balığa göre değişiklik göstermektedir. Bu kullanıcı tarafından balığının cinsine göre belli saat aralıklarına ayarlanabilecektir. Bunun yanı sıra akvaryumdaki mevcut suyun sıcaklığı sensörler ile tespit edilerek hem otomatik hem manuel olarak istenilen sıcaklığa uygun olarak ayarlanabilmiştir. Ayrıca zamanla buharlaşma sonucu meydana gelen su kaybı su seviyesi sensörü ile telafi edilebilmiştir.Bu sensör belli kademelerde su miktarı seçenekler için kullanılmıştır. Bu seviyeyide kendi balık cinsine göre kullanıcı değiştirebilmektedir. pH sensörü ile de her balığa uygun ph değeri dışardan veya otomatik seçeneği ile ayarlanabilmiştir. LDR sensörü kullanılarak ışık miktarı da kontrol edilmiştir. Sistemimizin arayüzü ile de ph,sıcaklık,ışık miktarı,su seviyesi kontrolü yapılmıştır.  Böylece balıklar için oluşturulan yaşam alanı yaşamsal standartlarına göre düzenlenmiştir. 

Projenin C# arayüzü ve bir takım kısımda değişikler yapmayı düşünüyorum. Onları da tamamladıkça buradaki repo da düzenlemeler yapacağımı söylemekten mutluluk duyuyorum.

Güç sizinle olsun !!!
