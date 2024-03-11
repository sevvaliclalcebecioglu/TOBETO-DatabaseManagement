select * from products;

--1.Product isimlerini (`ProductName`) ve birim başına miktar (`QuantityPerUnit`) değerlerini almak için sorgu yazın.
SELECT product_name , quantity_per_unit
FROM Products;

--2.Ürün Numaralarını (`ProductID`) ve Product isimlerini (`ProductName`) değerlerini almak için sorgu yazın. Artık satılmayan ürünleri (`Discontinued`) filtreleyiniz.
SELECT product_id , product_name 
FROM products 
WHERE discontinued = 0;
--true=1  false=0

--3.Durdurulmayan (`Discontinued`) Ürün Listesini, Ürün kimliği ve ismi (`ProductID`, `ProductName`) değerleriyle almak için bir sorgu yazın.
SELECT product_id , product_name 
FROM products 
WHERE discontinued = 0;

--4.Ürünlerin maliyeti 20'dan az olan Ürün listesini (`ProductID`, `ProductName`, `UnitPrice`) almak için bir sorgu yazın.
SELECT product_id , product_name , unit_price
FROM products
WHERE unit_price < 20;

--5.Ürünlerin maliyetinin 15 ile 25 arasında olduğu Ürün listesini (`ProductID`, `ProductName`, `UnitPrice`) almak için bir sorgu yazın.
SELECT product_id , product_name , unit_price 
FROM products
WHERE unit_price BETWEEN 15 AND 25;

--6.Ürün listesinin (`ProductName`, `UnitsOnOrder`, `UnitsInStock`) stoğun siparişteki miktardan az olduğunu almak için bir sorgu yazın
SELECT product_name , units_on_order , units_in_stock
FROM products
WHERE units_in_stock < units_on_order;

--7.İsmi `a` ile başlayan ürünleri listeleyeniz.
SELECT product_name
FROM products
WHERE product_name ILIKE 'a%';  -- büyük küçük harfe duyarlı değildir.

--8.İsmi `i` ile biten ürünleri listeleyeniz.
SELECT product_name
FROM products
WHERE product_name ILIKE '%i';  -- büyük küçük harfe duyarlı değildir.

--9.Ürün birim fiyatlarına %18’lik KDV ekleyerek listesini almak (ProductName, UnitPrice, UnitPriceKDV) için bir sorgu yazın
SELECT product_name , unit_price , unit_price * 1.18 AS "UnitPriceKDV"
FROM products ;
--sorguda, 'UnitPrice * 1.18' ifadesi, her bir ürünün birim fiyatına (%18'lik KDV dahil) eklenmesi gereken KDV miktarını hesaplar. Yani, her bir ürünün birim fiyatı 1.18 ile çarpılarak, KDV dahil birim fiyat elde edilir.

--10.Fiyatı 30 dan büyük kaç ürün var?
SELECT COUNT(*) 
FROM products
WHERE unit_price > 30;

--11.Ürünlerin adını tamamen küçültüp fiyat sırasına göre tersten listele
SELECT LOWER(product_name) AS product_name , unit_price
FROM products
ORDER BY unit_price DESC;
--küçük harfe lower() fonksiyonu ile çevirdim
--bir sütunu tersten sıralamak için DESC (descending) kullanılırken, normal sıralamak için ASC (ascending) kullanılır

--12.Çalışanların ad ve soyadlarını yanyana gelecek şekilde yazdır
SELECT first_name || ' ' || last_name AS full_name
FROM employees ;
--Arada bir boşluk bırakmak için ' ' kullanıyoruz.

--13.Region alanı NULL olan kaç tedarikçim var?
SELECT COUNT(*) as "NULL"
FROM suppliers
WHERE region IS NULL;

--14."Suppliers" tablosundaki Region alanı NULL olmayan tedarikçilerin sayısını bulmak için
SELECT COUNT(*) as "NOT NULL"
FROM suppliers
WHERE region IS NOT NULL;

--15.Ürün adlarının hepsinin soluna TR koy ve büyültüp olarak ekrana yazdır.
SELECT CONCAT('TR ', UPPER("product_name")) AS "ModifiedProductName"
FROM products ;
--Concat ifadesi, "TR " metni ile "ProductName" sütunundaki değeri birleştirir. UPPER fonksiyonu, "ProductName" sütunundaki değeri büyük harfe dönüştürmek için kullanılır.

--16.a.Fiyatı 20den küçük ürünlerin adının başına TR ekle
SELECT 
    CASE 
        WHEN unit_price < 20 THEN CONCAT('TR ', product_name)
        ELSE product_name
    END AS "ModifiedProductName"
FROM 
    products;
--Bu sorgu, "Products" tablosundan ürünlerin adını ve birim fiyatını kontrol eder. Birim fiyatı 20'den küçük olan ürünlerin adının başına "TR" ekler. 20 veya daha büyük olan ürünlerin adlarını değiştirmeden bırakır. Sonuçlar, "ModifiedProductName" olarak adlandırılan bir sütunda döndürülür.

--17.En pahalı ürün listesini (`ProductName` , `UnitPrice`) almak için bir sorgu yazın.
SELECT product_name , unit_price
FROM products
ORDER BY "unit_price" DESC
LIMIT 1;
--Bu sorgu, "Products" tablosundan birim fiyatı en yüksek olan ürünün adını ve birim fiyatını getirecektir. ORDER BY ifadesi ile birim fiyata göre büyükten küçüğe doğru sıralama yapıldıktan sonra LIMIT 1 ile sadece en yüksek fiyatlı ürünü alırız.

--18.En pahalı on ürünün Ürün listesini (`ProductName` , `UnitPrice`) almak için bir sorgu yazın.
SELECT product_name , unit_price
FROM products
ORDER BY "unit_price" DESC
LIMIT 10;
--ORDER BY ifadesi ile birim fiyata göre büyükten küçüğe doğru sıralama yapıldıktan sonra LIMIT 10 ile sadece ilk on ürün alınır.

--19.Ürünlerin ortalama fiyatının üzerindeki Ürün listesini (`ProductName` , `UnitPrice`) almak için bir sorgu yazın.
SELECT product_name , unit_price
FROM products
WHERE unit_price > (SELECT AVG("unit_price") FROM products);
-- İç içe sorgu olan SELECT AVG("UnitPrice") FROM "Products" ile ortalama fiyat hesaplanır ve dış sorguda bu ortalama fiyatın üzerindeki ürünler filtrelenir.

--20.Stokta olan ürünler satıldığında elde edilen miktar ne kadardır.
SELECT SUM(unit_price * units_in_stock) FROM products;

--21.Mevcut ve Durdurulan ürünlerin sayılarını almak için bir sorgu yazın.
SELECT 
    "discontinued",
    COUNT(*) AS "ProductCount"
FROM 
    products
GROUP BY 
    discontinued;
--Bu sorgu, "Products" tablosundaki ürünlerin "Discontinued" alanına göre gruplar ve her bir grup için ürün sayısını hesaplar. "Discontinued" alanı 0 ise ürün hala mevcut demektir, 1 ise ürün durdurulmuş demektir. Bu sorgu, her iki durum için ürün sayısını sağlayacaktır.

--22.Ürünleri kategori isimleriyle birlikte almak için bir sorgu yazın.
SELECT 
    p."product_name",
    c."category_name"
FROM 
    "products" p
INNER JOIN 
    "categories" c ON p."category_id" = c."category_id";
--Bu sorgu, "Products" tablosundaki her bir ürünün adını ve "Categories" tablosundaki her bir kategori adını birleştirir. "CategoryID" sütunu, "Products" ve "Categories" tablolarını birleştirmek için kullanılır. Bu sorgu, ürünleri kategori isimleriyle birlikte sağlayacaktır.

--23.Ürünlerin kategorilerine göre fiyat ortalamasını almak için bir sorgu yazın.
SELECT 
    c."category_name",
    AVG(p."unit_price") AS "AveragePrice"
FROM 
    "products" p
INNER JOIN 
    "categories" c ON p."category_id" = c."category_id"
GROUP BY 
    c."category_name";
--Bu sorgu, "Products" tablosundaki her bir ürünün fiyatını kategorilere göre gruplar ve her bir kategori için fiyatın ortalamasını hesaplar. Sonuçlar, her bir kategori için ortalama fiyatları içeren bir liste olarak dönecektir.

--24.En pahalı ürünümün adı, fiyatı ve kategorisin adı nedir?
SELECT 
    p."product_name" AS "MostExpensiveProduct",
    p."unit_price" AS "Price",
    c."category_name" AS "Category"
FROM 
    "products" p
INNER JOIN 
    "categories" c ON p."category_id" = c."category_id"
ORDER BY 
    p."unit_price" DESC
LIMIT 1;
--Bu sorgu, "Products" tablosundaki ürünleri fiyatlarına göre büyükten küçüğe doğru sıralar. Ardından, LIMIT 1 ile en yüksek fiyatlı olan ürünü seçer. Seçilen ürünün adı, fiyatı ve kategorisi görüntülenir.

--25.En çok satılan ürününün adı, kategorisinin adı ve tedarikçisinin adı
SELECT p.product_id, p.product_name, category_name, s.company_name, SUM(quantity) AS sale_amount FROM order_details AS od
INNER JOIN products AS p ON p.product_id = od.product_id
INNER JOIN categories AS c ON c.category_id = p.category_id
INNER JOIN suppliers AS s ON s.supplier_id = p.supplier_id
GROUP BY p.product_id, c.category_name, s.company_name
ORDER BY sale_amount DESC LIMIT 1;






