-- INNER JOIN
-- Hangi ürün hangi katagoride

-- Tüm tabloyu getirir.
SELECT * FROM Products; 

-- Sadece product_name ve product_id getirir.
SELECT product_name , product_id FROM Products;

-- INNER JOIN yapmak istediğimizde
SELECT product_name , products.category_id , categories.category_id , category_name FROM Products
INNER JOIN categories ON products.category_id=categories.category_id;

-- Yukarıdaki örneği bu şekilde de yapabiliriz.
SELECT product_name , category_name FROM Products
INNER JOIN categories ON products.category_id=categories.category_id;

-- Hangi sipariş hangi kargo şirketi ile ne zaman gönderilmiş
-- orders --shippers
SELECT orders.order_id , shippers.company_name , orders.order_date , orders.shipped_date
FROM orders 
INNER JOIN shippers ON orders.ship_via = shippers.shipper_id;

-- Hangi siparişi hangi çalışan almış 
-- orders --employees  
SELECT o.order_id , e.first_name , e.last_name 
FROM orders o   
INNER JOIN employees e ON o.employee_id=e.employee_id;

-- Hangi siparişi hangi çalışan almış hangi müşteri vermiş
-- orders --employees --customers
SELECT o.order_id , e.first_name , e.last_name , c.company_name
FROM orders o   
INNER JOIN employees e ON o.employee_id=e.employee_id
INNER JOIN customers c ON o.customer_id=c.customer_id;

-- Genelde FK ile join yaparız

-- LEFT JOIN
-- Birincil tablodaki her kaydı , ikincil tablodaki eşleşen kayıtlarla birlikte getirir.
-- Eğer eşleşen kayıt yoksa ikinci tablodaki sütunlar NULL değer gelir .
-- Çalışanlarımın müşterilerden aldığı siparişler
SELECT e.employee_id , o.employee_id , e.first_name ,  o.order_id , o.order_date 
FROM employees e
LEFT JOIN orders o ON e.employee_id=o.employee_id;

-- RIGHT JOIN
-- Hiç sipariş vermemiş müşterilerimizi görmek 
SELECT o.customer_id , c.customer_id , c.company_name
FROM orders o 
RIGHT JOIN customers c ON o.customer_id=c.customer_id
WHERE order_id ISNULL ; -- Yaptığım filtrelemelerden bana sadece NULL olanları getir demektir.

-- FULL OUTER JOIN 
SELECT order_id , company_name , cs.customer_id , o.customer_id
FROM customers cs 
FULL OUTER JOIN orders o ON cs.customer_id=o.customer_id
WHERE o.customer_id ISNULL ;

-- GROUP BY
-- product_id üzerinden toplam miktarını almak için grupladım ve onları da product_id'sine göre sıraladım.
SELECT product_id , SUM(quantity) AS "Toplam Miktar"
FROM order_details
GROUP BY product_id
ORDER BY product_id;

-- Hangi kategoride toplam kaç ürün var ?
SELECT category_id , COUNT(product_id) AS "Toplam Ürün"
FROM products
GROUP BY category_id;


SELECT category_name,COUNT(product_id) AS "Toplam Ürün"
FROM products p 
INNER JOIN categories ct ON ct.category_id = p.category_id
GROUP BY category_name;

-- Hangi ülkeye ne kadarlık bir satış yapılmıştır.
SELECT cs.country , SUM(od.quantity*od.unit_price) AS "Toplam Satış"
FROM customers cs
INNER JOIN orders o ON o.customer_id=cs.customer_id
INNER JOIN order_details od ON o.order_id=od.order_id
GROUP BY cs.country
ORDER BY "Toplam Satış" DESC;

-- HAVING
-- Filtreleme

SELECT product_id , SUM(quantity) AS "Toplam Miktar"
FROM order_details
GROUP BY product_id
HAVING SUM(quantity)>1000
ORDER BY product_id;

-- WHERE => Tabloda bulunan bir sütuna göre filtreleme uyguluyor.
-- HAVING => Ram tarafında hesaplanan bir değere göre filtreleme yapıyor.


-- Stok sayısı 12'den fazla olan -- Toplam ürün sayısı 3'den fazla olan kategoriler
SELECT category_id , COUNT(*)
FROM products
WHERE units_in_stock > 12
GROUP BY category_id
HAVING COUNT(*)>3;

-- 120 adetten fazla olan ürünler
SELECT * 
FROM products
WHERE units_in_stock>120;

-- 120 adetten fazla satılan ürünler
SELECT product_name , SUM(quantity) 
FROM order_details od
INNER JOIN products pd ON od.product_id=pd.product_id
GROUP BY product_name
HAVING SUM(quantity)>120;






