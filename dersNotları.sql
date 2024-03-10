select * from products; -- * tümünü filtrelemeden getir demektir
select product_name,unit_price from products; -- bana sadece product_name'i getir diye filtreleem yaptım. bunu virgül ile çoğaltabilirim.

-- hangi sorguyu çalıştırmak istiyorsam o sorguyu seçip çalıştırmaya basmalıyım .

--where koşulu
select * from products where category_id=2; -- category_id'si 2 olanları getir demektir.

--birden fazla filtreleme 
--stok sayısı 60'dan büyük ve category_id=3

--iki koşuluda sağlayan dataları getir
--AND
select product_name,units_in_stock,category_id from products where units_in_stock>60 AND category_id=3;

--iki koşuldan birisini sağlama durumu
--OR
select product_name,units_in_stock,category_id from products where units_in_stock>60 OR category_id=3;

--product_name'i 'Chai' olanı getir
select * from products where product_name='Chai';

--son yazdığım sorguya ; koymazsam direk onu çalıştırır. ; koyarsam yine seçip çalıştırmam lazım.

--küçük harfe çevir 
select lower(product_name),category_id from products where product_name='Chai';

--between(arasında) keywordu
--units_in_stock 60'dan büyük ve 90'dan küçükleri bana getir
select * from products where units_in_stock>60 and units_in_stock<90;
--bunu between kullanarak yapalım
select * from products where units_in_stock between 60 and 90;

--Count => adet hesabı
--null(boş geçilenleri) saymıyor
--unit_price'ı 60'dan büyük olanların adedi
select COUNT(*) from products where unit_price>60;
--toplam adedi isterken takma isim ekleyebiliriz
--alias => takma isim
select COUNT(*) as"ürün adedi" from products where unit_price>60;

--employees tablosuna sorgu atmak için
select * from employees;

--tekrar eden verileri kullanmak istemiyorum
--Dıstınct => tekrar eden verileri kaldırır

select distinct city from employees; -- city içindeki verileri tekrarlamadan getirdi

--bide bunun adedini almak istersem
select count (distinct city) as"şehir toplam" from employees;

--aynı alanlarda and yerine or kullanılır
select * from products where product_name='Chai' or product_name='Chang';

--IN fonksiyonu
--İçinde parametre olarak verilen n tane veri
select * from products where product_name IN('Chai','Chang','Ikura');
--aynısının categoy_id=2,3 olanları çağıralım
select * from products where category_id IN(2,3);

--LIKE keywordu
--pattern => kalıba benzer ifadeleri getirir
-- % => ilgili metin sol ya da sağına eklendiğinde
select * from products where product_name like'%t%';

--SUM => toplama
select SUM(unit_price) as"toplam" from products;

--average(AVG) => ortama
select AVG(unit_price) as"ortalama" from products;

--MAX => en büyük değer
select MAX(unit_price) as"en büyük değer" from products;

--MIN => en küçük değer 
select MIN(unit_price) as"en küçük değer" from products;

--order by => sıralama
--default olarak ; küçükten büyüğe
--ascending(ASC) => küçükten büyüğe
--descending(DESC) => büyükten küçüğe
select product_name,unit_price from products order by unit_price DESC;
select product_name,unit_price from products order by unit_price ASC;

--SUB QUERY => iç içe sorgular
--ortalamanın altında bir fiyata sahip olan 
select product_name,unit_price from products where unit_price<(select AVG(unit_price) from products);
--unit_price eşitse max değeri getir
select product_name,unit_price from products where unit_price=(select MAX(unit_price) from products);



































