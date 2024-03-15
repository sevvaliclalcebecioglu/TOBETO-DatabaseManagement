--26.Stokta bulunmayan ürünlerin ürün listesiyle birlikte tedarikçilerin ismi ve iletişim numarasını (`ProductID`, `ProductName`, `CompanyName`, `Phone`) almak için bir sorgu yazın.
SELECT 
    p.product_id AS "ProductID",
    p.product_name AS "ProductName",
    s.company_name AS "CompanyName",
    s.phone AS "Phone"
FROM 
    products p
JOIN 
    suppliers s ON p.supplier_id = s.supplier_id
WHERE 
    p.units_in_stock <= 0;

--27.1998 yılı mart ayındaki siparişlerimin adresi, siparişi alan çalışanın adı, çalışanın soyadı
SELECT o.ship_address , e.first_name , e.last_name
FROM orders o
JOIN employees e ON o.employee_id = e.employee_id
WHERE EXTRACT(YEAR FROM o.order_date) = 1998 AND EXTRACT(MONTH FROM o.order_date) = 3;
--EXTRACT fonksiyonu ile sipariş tarihinin yılını ve ayını çıkarırız.

--28.1997 yılı şubat ayında kaç siparişim var?
SELECT 
    COUNT(*) AS "Sipariş Sayısı"
FROM 
    orders
WHERE 
    EXTRACT(YEAR FROM order_date) = 1997
    AND EXTRACT(MONTH FROM order_date) = 2;

--29.London şehrinden 1998 yılında kaç siparişim var?
SELECT COUNT(*)
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE EXTRACT(YEAR FROM o.order_date) = 1998 AND c.city = 'London';
--Orders" ve "Customers" tablolarını birleştirerek (JOIN) belirtilen koşullara uygun siparişlerin sayısını bulur. EXTRACT fonksiyonu ile sipariş tarihinin yılını kontrol ederiz ve müşterinin şehri "London" olarak belirtilmiştir.

--30.1997 yılında sipariş veren müşterilerimin contactname ve telefon numarası
SELECT DISTINCT c.contact_name, c.phone
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE EXTRACT(YEAR FROM o.order_date) = 1997;
--EXTRACT fonksiyonu ile sipariş tarihinin yılını kontrol ederiz. DISTINCT anahtar kelimesi ile aynı müşterinin birden fazla sipariş vermesi durumunda tekrar eden sonuçları önleriz.

--31.Taşıma ücreti 40 üzeri olan siparişlerim
SELECT order_id , freight
FROM orders
WHERE freight > 40
ORDER BY freight ASC;

--32.Taşıma ücreti 40 ve üzeri olan siparişlerimin şehri, müşterisinin adı
SELECT o.ship_city, c.contact_name 
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE o.freight >= 40;

--33.1997 yılında verilen siparişlerin tarihi, şehri, çalışan adı -soyadı ( ad soyad birleşik olacak ve büyük harf),
SELECT o.order_date , o.ship_city , CONCAT(UPPER(e.first_name), ' ' , UPPER(e.last_name)) AS "EmployeeName"  
FROM orders o 
JOIN employees e ON o.employee_id = e.employee_id
WHERE EXTRACT(YEAR FROM o.order_date) = 1997;
--CONCAT ve UPPER fonksiyonları ile çalışanın adı ve soyadı birleştirilir ve büyük harfle yazılır.

--34.1997 yılında sipariş veren müşterilerin contactname i, ve telefon numaraları ( telefon formatı 2223322 gibi olmalı )
SELECT
    c.contact_name,
    REPLACE(REPLACE(REPLACE(c.phone, '(', ''), ')', ''), '-', '') AS "phone"
FROM
    customers c
JOIN
    orders o ON c.customer_id = o.customer_id
WHERE
    EXTRACT(YEAR FROM o.order_date) = 1997;
--Telefon numarasının formatını düzenlemek için REPLACE fonksiyonu kullanılır. Bu şekilde telefon numarası parantezler ve tireler olmadan birleştirilir.

--35.Sipariş tarihi, müşteri contact name, çalışan ad, çalışan soyad
SELECT o.order_date , c.contact_name , e.first_name , e.last_name
FROM orders o 
JOIN customers c ON c.customer_id = o.customer_id
JOIN employees e ON o.employee_id = e.employee_id
--"Orders" tablosunu "Customers" ve "Employees" tabloları ile birleştirir (JOIN) ve her bir siparişin tarihini, müşterinin iletişim adını, çalışanın adını ve soyadını getirir.

--36.Geciken siparişlerim?
SELECT
    o.order_id,
    o.order_date,
    o.required_date,
    o.shipped_date,
    (o.shipped_date - o.required_date) AS "Gecikme"
FROM
    orders o
WHERE
    o.shipped_date > o.required_date;
--orders tablosundaki siparişleri seçer ve teslim tarihi sipariş tarihinden sonra olanları filtreler. Gecikme süresi , teslim tarihi ve gerekli tarih arasındaki fark olarak hesaplanır

--37.Geciken siparişlerimin tarihi, müşterisinin adı
SELECT
    o.order_date,
    c.contact_name
FROM
    orders o
JOIN
    customers c ON o.customer_id = c.customer_id
WHERE
    o.shipped_date > o.required_date;

--38.10248 nolu siparişte satılan ürünlerin adı, kategorisinin adı, adedi
SELECT
    p.product_name,
    c.category_name,
    od.quantity
FROM
    order_details od
JOIN
    products p ON od.product_id = p.product_id
JOIN
    categories c ON p.category_id = c.category_id
WHERE
    od.order_id = 10248;
	
--39.10248 nolu siparişin ürünlerinin adı , tedarikçi adı

SELECT 
    p.product_name AS "Ürün Adı",
    s.company_name AS "Tedarikçi Adı"
FROM 
    orders o
JOIN 
    order_details od ON o.order_id = od.order_id
JOIN 
    products p ON od.product_id = p.product_id
JOIN 
    suppliers s ON p.supplier_id = s.supplier_id
WHERE 
    o.order_id = 10248;

--40.3 numaralı ID ye sahip çalışanın 1997 yılında sattığı ürünlerin adı ve adeti
SELECT 
    p.product_name AS "Ürün Adı",
    SUM(od.quantity) AS "Adet"
FROM 
    orders o
JOIN 
    order_details od ON o.order_id = od.order_id
JOIN 
    products p ON od.product_id = p.product_id
JOIN 
    employees e ON o.employee_id = e.employee_id
WHERE 
    EXTRACT(YEAR FROM o.order_date) = 1997
    AND e.employee_id = 3
GROUP BY 
    p.product_name;

--41. 1997 yılında bir defasinda en çok satış yapan çalışanımın ID,Ad soyad
SELECT e.employee_id, e.first_name || ' ' || e.last_name AS "ad_soyad", SUM(Quantity) AS "tek_seferde_toplam_satis" FROM order_details AS od
INNER JOIN orders AS o ON od.order_id = o.order_id
INNER JOIN employees AS e ON o.employee_id = e.employee_id
WHERE EXTRACT('YEAR' FROM order_date) = 1997
GROUP BY e.employee_id
ORDER BY "tek_seferde_toplam_satis" DESC LIMIT 1;

--42. 1997 yılında en çok satış yapan çalışanımın ID,Ad soyad ****
SELECT e.employee_id, e.first_name || ' ' || e.last_name AS "ad_soyad", COUNT(od.order_id) AS "toplam_satis_sayisi" FROM order_details AS od
INNER JOIN orders AS o ON od.order_id = o.order_id
INNER JOIN employees AS e ON o.employee_id = e.employee_id
WHERE EXTRACT('YEAR' FROM order_date) = 1997
GROUP BY e.employee_id
ORDER BY "toplam_satis_sayisi" DESC
LIMIT 1;


--43.En pahalı ürünümün adı,fiyatı ve kategorisin adı nedir?
SELECT 
    p.product_name AS "Ürün Adı",
    p.unit_price AS "Fiyat",
    c.category_name AS "Kategori"
FROM 
    products p
JOIN 
    categories c ON p.category_id = c.category_id
WHERE 
    p.unit_price = (
        SELECT 
            MAX(unit_price)
        FROM 
            products
    );

--44.Siparişi alan personelin adı,soyadı, sipariş tarihi, sipariş ID. Sıralama sipariş tarihine göre
SELECT 
    e.first_name AS "Ad",
    e.last_name AS "Soyad",
    o.order_date AS "Sipariş Tarihi",
    o.order_id AS "Sipariş ID"
FROM 
    employees e
JOIN 
    orders o ON e.employee_id = o.employee_id
ORDER BY 
    o.order_date;
	
--45.SON 5 siparişimin ortalama fiyatı ve orderid nedir?
SELECT 
    AVG(od.unit_price * od.quantity) AS "Ortalama Fiyat",
    o.order_id AS "Sipariş ID"
FROM 
    orders o
JOIN 
    order_details od ON o.order_id = od.order_id
GROUP BY 
    o.order_id
ORDER BY 
    o.order_date DESC
LIMIT 5;

--46.Ocak ayında satılan ürünlerimin adı ve kategorisinin adı ve toplam satış miktarı nedir?
SELECT 
    p.product_name AS "Ürün Adı",
    c.category_name AS "Kategori",
    SUM(od.quantity) AS "Toplam Satış Miktarı"
FROM 
    orders o
JOIN 
    order_details od ON o.order_id = od.order_id
JOIN 
    products p ON od.product_id = p.product_id
JOIN 
    categories c ON p.category_id = c.category_id
WHERE 
    EXTRACT(MONTH FROM o.order_date) = 1
GROUP BY 
    p.product_name, c.category_name;


--48.En çok satılan ürünümün(adet bazında) adı, kategorisinin adı ve tedarikçisinin adı
SELECT 
    p.product_name AS "Ürün Adı",
    c.category_name AS "Kategori",
    s.company_name AS "Tedarikçi Adı"
FROM 
    products p
JOIN 
    categories c ON p.category_id = c.category_id
JOIN 
    suppliers s ON p.supplier_id = s.supplier_id
JOIN 
    (
        SELECT 
            product_id,
            SUM(quantity) AS toplam_satis
        FROM 
            order_details
        GROUP BY 
            product_id
        ORDER BY 
            toplam_satis DESC
        LIMIT 1
    ) AS en_cok_satis_yapan ON p.product_id = en_cok_satis_yapan.product_id;

--49.Kaç ülkeden müşterim var
SELECT 
    COUNT(DISTINCT country) AS "Ülke Sayısı"
FROM 
    customers;
	
--50.3 numaralı ID ye sahip çalışan (employee) son Ocak ayından BUGÜNE toplamda ne kadarlık ürün sattı?
SELECT 
    e.employee_id AS "Çalışan ID",
    SUM(od.quantity) AS "Toplam Satılan Ürün Miktarı"
FROM 
    employees e
JOIN 
    orders o ON e.employee_id = o.employee_id
JOIN 
    order_details od ON o.order_id = od.order_id
WHERE 
    e.employee_id = 3
    AND o.order_date >= '2024-01-01'
GROUP BY 
    e.employee_id;
	
--56.En pahalı ürünümün adı,fiyatı ve kategorisin adı nedir?
SELECT p.product_name AS "Ürün Adı", p.unit_price AS "Fiyat", c.category_name AS "Kategori"
FROM products p
JOIN categories c ON p.category_id = c.category_id
ORDER BY p.unit_price DESC
LIMIT 1;

--57.Siparişi alan personelin adı,soyadı, sipariş tarihi, sipariş ID. Sıralama sipariş tarihine göre
SELECT e.first_name AS "Adı", e.last_name AS "Soyadı", o.order_date AS "Sipariş Tarihi", o.order_id AS "Sipariş ID"
FROM orders o
JOIN employees e ON o.employee_id = e.employee_id
ORDER BY o.order_date;

--58.SON 5 siparişimin ortalama fiyatı ve orderid nedir?
SELECT AVG(od.unit_price) AS "Ortalama Fiyat", array_agg(od.order_id) AS "OrderIDler"
FROM (
    SELECT o.order_id, od.unit_price
    FROM orders o
    JOIN order_details od ON o.order_id = od.order_id
    ORDER BY o.order_date DESC
    LIMIT 5
) AS od;
--Bu sorgu, son 5 siparişi içeren alt sorguyu oluşturur, siparişlerin fiyatlarını alır ve sonra bu fiyatların ortalamasını hesaplar. Ayrıca, bu 5 siparişin orderID'lerini de dizi olarak döndürür.
--array_agg(od.orderid) ifadesi, "od.orderid" alanının değerlerini bir diziye dönüştürür. Bu dizi, sorgunun sonucunda her bir satıra karşılık gelen orderID'lerin listesini içerir.
--Bu durumda, "OrderID'ler" adında bir sütun oluşturulur ve her bir satırda bu sütun, o satıra karşılık gelen orderID'lerin bir listesini içerir. Bu listenin elemanları virgülle ayrılmış orderID'lerdir. Bu, verilerin daha düzenli ve okunabilir bir şekilde sunulmasına yardımcı olur.

--59.Ocak ayında satılan ürünlerimin adı ve kategorisinin adı ve toplam satış miktarı nedir?
SELECT p.product_name AS "Ürün Adı", c.category_name AS "Kategori", SUM(od.quantity) AS "Toplam Satış Miktarı"
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
JOIN categories c ON p.category_id = c.category_id
WHERE EXTRACT(MONTH FROM o.order_date) = 1
GROUP BY p.product_name, c.category_name;
--EXTRACT(MONTH FROM o.orderdate) ifadesi, "o.orderdate" alanından ayı (1'den 12'ye kadar olan bir sayı) alır.
--Bu ifadenin ardından gelen = 1, Ocak ayını temsil eder. Yani, bu ifade "o.orderdate" alanından ayın Ocak olup olmadığını kontrol eder. Eğer Ocak ayıysa, bu koşul doğru olur ve bu siparişler alınır.

--60.Ortalama satış miktarımın üzerindeki satışlarım nelerdir?
WITH average_sales AS (
    SELECT AVG(quantity) AS avg_quantity
    FROM order_details
)
SELECT od.order_id, od.product_id, od.quantity
FROM order_details od
CROSS JOIN average_sales avg
WHERE od.quantity > avg.avg_quantity;
--Bu sorgu, "order_details" tablosundan sipariş detaylarını alır ve bir CTE (common table expression) kullanarak ortalama satış miktarını hesaplar. Daha sonra, CROSS JOIN ile bu ortalama miktarını diğer tablodaki her bir satıra ekleriz ve WHERE koşulu ile bu miktarın üzerindeki satışları filtreleriz. Sonuç olarak, ortalamanın üzerindeki satışların detaylarını elde edersiniz.

--61.En çok satılan ürünümün(adet bazında) adı, kategorisinin adı ve tedarikçisinin adı
SELECT p.product_name AS "Ürün Adı", c.category_name AS "Kategori", s.company_name AS "Tedarikçi"
FROM products p
JOIN categories c ON p.category_id = c.category_id
JOIN order_details od ON p.product_id = od.product_id
JOIN suppliers s ON p.supplier_id = s.supplier_id
GROUP BY p.product_name, c.category_name, s.company_name
ORDER BY SUM(od.quantity) DESC
LIMIT 1;
--Bu sorgu, "products", "categories", "order_details" ve "suppliers" tablolarını birleştirir ve satılan ürünleri adet bazında gruplar. Ardından, bu grupları ürün adı, kategori adı ve tedarikçi adıyla birlikte gruplar. Son olarak, bu grupları satış miktarına göre azalan şekilde sıralar ve en yüksek satış miktarına sahip olan ürünü alır. Bu şekilde, en çok satılan ürünün adını, kategorisini ve tedarikçisini bulabilirsiniz.

--62.Kaç ülkeden müşterim var
SELECT COUNT(DISTINCT country) AS "Müşteri Ülke Sayısı"
FROM customers;
--Bu sorgu, "customers" tablosundan müşterilerin bulunduğu ülkeleri alır ve bu ülkelerin benzersiz sayısını bulur. Sonuç olarak, kaç farklı ülkeden müşteri olduğunu belirleyen bir sayı elde edilir.

--63.Hangi ülkeden kaç müşterimiz var
SELECT country, COUNT(*) AS "Müşteri Sayısı"
FROM customers
GROUP BY country;
--Bu sorgu, "customers" tablosundaki müşterileri ülkelerine göre gruplar. Daha sonra, her bir ülkede kaç müşteri olduğunu sayar. Sonuç olarak, her bir ülkenin altında o ülkeden kaç müşteriniz olduğunu gösteren bir tablo elde edersiniz.

--64.3 numaralı ID ye sahip çalışan (employee) son Ocak ayından BUGÜNE toplamda ne kadarlık ürün sattı?
--Son ocak ayından'ı veriler içindeki son ocak ayı olarak düşünüp o yılın ocak ayından dahil ve sonraki yılların hepsini aldım.
SELECT SUM(od.quantity * od.unit_price) AS "total" FROM orders AS o
INNER JOIN order_details od ON o.order_id = od.order_id
WHERE employee_id = 3
AND EXTRACT('YEAR' FROM order_date) >= (SELECT EXTRACT('YEAR' FROM MAX(order_date)) FROM orders)
AND EXTRACT('MONTH' FROM order_date) >= '01';

--65.10 numaralı ID ye sahip ürünümden son 3 ayda ne kadarlık ciro sağladım?
--Veriler içindeki son 3 ay kapsayacak şekilde hesapladım.
SELECT SUM(od.unit_price * od.quantity) AS "Ciro" FROM orders AS o
INNER JOIN order_details AS od ON o.order_id = od.order_id
WHERE product_id = 10
AND o.order_date >= (SELECT DATE_TRUNC('MONTH', MAX(order_date) - INTERVAL '2 MONTHS') FROM orders)
AND o.order_date <= (SELECT DATE_TRUNC('MONTH', MAX(order_date)) FROM orders);

--66.Hangi çalışan şimdiye kadar toplam kaç sipariş almış..?
SELECT employee_id, COUNT(*) AS "Toplam Sipariş Sayısı"
FROM orders
GROUP BY employee_id;
--Bu sorgu, her bir çalışanın toplam sipariş sayısını verir. Sonuçlar, çalışan ID'si ve o çalışanın toplam sipariş sayısı sütunlarını içeren bir tablo olacaktır. Bu şekilde, her çalışanın şimdiye kadar kaç sipariş aldığını bulabilirsiniz.

--67.91 müşterim var. Sadece 89’u sipariş vermiş. Sipariş vermeyen 2 kişiyi bulun
SELECT c.customer_id, c.company_name
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.company_name
HAVING COUNT(o.order_id) = 0
LIMIT 2;
--COUNT(o.orderid) = 0 ifadesi, her bir müşterinin toplam sipariş sayısını kontrol eder. Eğer bir müşterinin sipariş sayısı 0 ise (yani, müşteri hiçbir sipariş vermemişse), bu müşteri HAVING filtresi tarafından seçilir.
--Bu sorgunun LIMIT 2 bölümü, sorgunun yalnızca ilk 2 sonucunu döndürmesini sağlar. Yani, sipariş vermeyen ilk 2 müşteriyi bulmak için kullanılır.

--68.Brazil’de bulunan müşterilerin Şirket Adı, TemsilciAdi, Adres, Şehir, Ülke bilgileri
SELECT company_name AS "Şirket Adı", contact_name AS "Temsilci Adı", address AS "Adres", city AS "Şehir", country AS "Ülke"
FROM customers
WHERE country = 'Brazil';
--Bu sorgu, "customers" tablosundan Brazil'de bulunan müşterilerin şirket adı, temsilci adı, adres, şehir ve ülke bilgilerini seçer. Ve bize verir.

--69.Brezilya’da olmayan müşteriler
SELECT company_name , country
FROM customers
WHERE country != 'Brazil';
--"!=" operatörü, Brezilya dışındaki tüm ülkeleri filtreler

--70.Ülkesi (Country) YA Spain, Ya France, Ya da Germany olan müşteriler
SELECT company_name , country 
FROM customers
WHERE country IN ('Spain', 'France', 'Germany');
--"IN" operatörü, belirli bir liste içindeki değerlere sahip olan satırları filtreler

--71.Faks numarasını bilmediğim müşteriler
SELECT 
    *
FROM 
    customers
WHERE 
    fax IS NULL;

--72.Londra’da ya da Paris’de bulunan müşterilerim
SELECT 
    *
FROM 
    customers
WHERE 
    city IN ('London', 'Paris');

--73.Hem Mexico D.F’da ikamet eden HEM DE ContactTitle bilgisi ‘owner’ olan müşteriler
SELECT 
    *
FROM 
    customers
WHERE 
    city = 'México D.F.'
    AND contact_title = 'Owner';

--74.C ile başlayan ürünlerimin isimleri ve fiyatları
SELECT 
    product_name AS "Ürün İsmi",
    unit_price AS "Fiyat"
FROM 
    products
WHERE 
    product_name LIKE 'C%';

--75.Adı (FirstName) ‘A’ harfiyle başlayan çalışanların (Employees); Ad, Soyad ve Doğum Tarihleri
SELECT 
    first_name AS "Ad",
    last_name AS "Soyad",
    birth_date AS "Doğum Tarihi"
FROM 
    employees
WHERE 
    first_name LIKE 'A%';
	
--76.İsminde ‘RESTAURANT’ geçen müşterilerimin şirket adları
SELECT 
    company_name AS "Şirket Adı"
FROM 
    customers
WHERE 
    company_name ILIKE '%RESTAURANT%';
	
--77.50$ ile 100$ arasında bulunan tüm ürünlerin adları ve fiyatları
SELECT 
    product_name AS "Ürün Adı",
    unit_price AS "Fiyat"
FROM 
    products
WHERE 
    unit_price BETWEEN 50 AND 100;

--78.1 temmuz 1996 ile 31 Aralık 1996 tarihleri arasındaki siparişlerin (Orders), SiparişID (OrderID) ve SiparişTarihi (OrderDate) bilgileri
SELECT 
    order_id AS "Sipariş ID",
    order_date AS "Sipariş Tarihi"
FROM 
    orders
WHERE 
    order_date BETWEEN '1996-07-01' AND '1996-12-31';

--79.Ülkesi (Country) YA Spain, Ya France, Ya da Germany olan müşteriler
SELECT 
    *
FROM 
    customers
WHERE 
    country IN ('Spain', 'France', 'Germany');
	
--80.Faks numarasını bilmediğim müşteriler
SELECT 
    *
FROM 
    customers
WHERE 
    fax IS NULL;
	
--81.Müşterilerimi ülkeye göre sıralıyorum:
SELECT 
    *
FROM 
    customers
ORDER BY 
    country;
	
--82.Ürünlerimi en pahalıdan en ucuza doğru sıralama, sonuç olarak ürün adı ve fiyatını istiyoruz
SELECT 
    product_name AS "Ürün Adı",
    unit_price AS "Fiyat"
FROM 
    products
ORDER BY 
    unit_price DESC;
	
--83.Ürünlerimi en pahalıdan en ucuza doğru sıralasın, ama stoklarını küçükten-büyüğe doğru göstersin sonuç olarak ürün adı ve fiyatını istiyoruz
SELECT 
    product_name AS "Ürün Adı",
    unit_price AS "Fiyat"
FROM 
    products
ORDER BY 
    unit_price DESC, units_in_stock ASC;

--84.1 Numaralı kategoride kaç ürün vardır..?
SELECT 
    COUNT(*) AS "Ürün Sayısı"
FROM 
    products
WHERE 
    category_id = 1;
	
--85.Kaç farklı ülkeye ihracat yapıyorum..?
SELECT 
    COUNT(DISTINCT ship_country) AS "Farklı Ülke Sayısı"
FROM 
    orders;
	
--86.a.Bu ülkeler hangileri..?
SELECT 
    DISTINCT ship_country AS "Ülke"
FROM 
    orders;
	
--87.En Pahalı 5 ürün
SELECT 
    product_name AS "Ürün Adı",
    unit_price AS "Fiyat"
FROM 
    products
ORDER BY 
    unit_price DESC
LIMIT 5;

--88.ALFKI CustomerID’sine sahip müşterimin sipariş sayısı..?
SELECT 
    COUNT(*) AS "Sipariş Sayısı"
FROM 
    orders
WHERE 
    customer_id = 'ALFKI';
	
--89.Ürünlerimin toplam maliyeti
SELECT 
    SUM(unit_price * units_in_stock) AS "Toplam Maliyet"
FROM 
    products;
	
--90.Şirketim, şimdiye kadar ne kadar ciro yapmış..?
SELECT 
    SUM(od.unit_price * od.quantity) AS "Toplam Ciro"
FROM 
    orders o
JOIN 
    order_details od ON o.order_id = od.order_id;
	
--91.Ortalama Ürün Fiyatım
SELECT 
    AVG(unit_price) AS "Ortalama Ürün Fiyatı"
FROM 
    products;
	
--92.En Pahalı Ürünün Adı
SELECT 
    product_name AS "En Pahalı Ürünün Adı"
FROM 
    products
ORDER BY 
    unit_price DESC
LIMIT 1;

--93.En az kazandıran sipariş
SELECT 
    o.order_id AS "Sipariş ID",
    MIN(od.unit_price * od.quantity) AS "En Az Kazandıran Sipariş Tutarı"
FROM 
    orders o
JOIN 
    order_details od ON o.order_id = od.order_id
GROUP BY 
    o.order_id
ORDER BY 
    "En Az Kazandıran Sipariş Tutarı" ASC
LIMIT 1;

--94.Müşterilerimin içinde en uzun isimli müşteri
SELECT 
    customer_id,
    company_name,
    LENGTH(company_name) AS name_length
FROM 
    customers
ORDER BY 
    name_length DESC
LIMIT 1;

--95.Çalışanlarımın Ad, Soyad ve Yaşları
SELECT 
    first_name AS "Ad",
    last_name AS "Soyad",
    DATE_PART('year', AGE(NOW(), birth_date)) AS "Yaş"
FROM 
    employees;

--96.Hangi üründen toplam kaç adet alınmış..?
SELECT 
    product_id,
    SUM(quantity) AS "Toplam Satış Miktarı"
FROM 
    order_details
GROUP BY 
    product_id;

--97.Hangi siparişte toplam ne kadar kazanmışım..?
SELECT 
    o.order_id AS "Sipariş ID",
    SUM(od.unit_price * od.quantity) AS "Toplam Kazanç"
FROM 
    orders o
JOIN 
    order_details od ON o.order_id = od.order_id
GROUP BY 
    o.order_id;
	
--98.Hangi kategoride toplam kaç adet ürün bulunuyor..?
SELECT 
    category_id,
    COUNT(*) AS "Ürün Sayısı"
FROM 
    products
GROUP BY 
    category_id;
	
--99.1000 Adetten fazla satılan ürünler?
SELECT 
    product_id,
    SUM(quantity) AS "Toplam Satış Miktarı"
FROM 
    order_details
GROUP BY 
    product_id
HAVING 
    SUM(quantity) > 1000;
	
--100.Hangi Müşterilerim hiç sipariş vermemiş..?
SELECT 
    company_name
FROM 
    customers
LEFT JOIN 
    orders ON customers.customer_id = orders.customer_id
WHERE 
    orders.order_id IS NULL;




	
	

	
	


























