-- Brezil'de bulunan müþterilerimin bilgileri (Þirket adý, TemsilciAdi , Adres , Þehir , Ülke)
SELECT CompanyName , ContactName , Address , City , Country
FROM Customers
WHERE Country = 'Brazil'

-- Brezilya'da olmayan müþterilerimin bilgileri (Þirket Adý , TemsilciAdi , Adres , Þehir , Ülke )
-- <> ya da != þekilde gösterilir
SELECT CompanyName , ContactName , Address , City , Country
FROM Customers
WHERE Country <> 'Brazil'

-- Ülkesi Spain ya da France ya da Germany olan müþterilerim?
SELECT CompanyName , ContactName , Address , City , Country
FROM Customers
--WHERE Country = 'Spain' OR Country = 'France' OR Country = 'Germany' 
WHERE Country IN ('Spain' , 'France' , 'Germany')  -- Bu þekilde IN ile de kullanabilirim . Çünkü IN () biri olursa anlamýna gelir.

-- Faks numarasýný bilmediðim müþterilerim kimler ?
SELECT CompanyName , Fax 
FROM Customers
WHERE Fax IS NULL

-- Londra'da ya da Paris'de bulunan müþterilerim kimler ?
SELECT CompanyName , City
FROM Customers
WHERE City IN ('London' , 'Paris')

-- Müþterilerimin içinde en uzun isimli müþteri kimdir ? 
-- LENGTH => UZUNLUK HESAPLANIR
SELECT TOP 1 CompanyName , LEN(CompanyName) AS [LENGTH] 
FROM Customers
ORDER BY [LENGTH] DESC

-- Hem México D.F.'da ikamet eden hem de iletiþim kiþisi ünvanýnda 'owner' olan müþterilerim kimler ? 
SELECT * 
FROM Customers
WHERE City = 'México D.F.' AND ContactTitle = 'Owner'

-- C ile baþlayan ürünlerimin isimleri ve fiyatlarý nelerdir ?
SELECT ProductName , UnitPrice 
FROM Products
WHERE ProductName LIKE 'C%'
ORDER BY UnitPrice DESC

-- Adý (FirstName) 'A' harfiyle baþlayan çalýþanlarýn (Employees); Ad , Soyad ve Doðum Tarihleri
SELECT FirstName , LastName , BirthDate 
FROM Employees
WHERE FirstName LIKE 'A%'

--1963 ve 1952 yýlýnda doðum günü olan çalýþanlarým kimler ?
-- YEAR => YILINI VERÝR
SELECT FirstName , LastName , BirthDate 
FROM Employees
WHERE YEAR(BirthDate) IN (1963 , 1952)

-- Bugün doðum günü olan çalýþanlarým kimler ?
SELECT FirstName , LastName , BirthDate 
FROM Employees
WHERE YEAR(BirthDate) = YEAR(GETDATE()) AND MONTH(BirthDate) = MONTH(GETDATE()) AND DAY(BirthDate) = DAY(GETDATE())

-- Ýsminde 'Restaurant' geçen müþterilerimin þirket adlarý nelerdir ? 
SELECT CompanyName
FROM Customers
WHERE CompanyName LIKE '%RESTAURANT%'

-- 50$ ile 100$ arasýnda birim fiyatý bulunan tüm ürünlerin adlarý ve fiyatlarý nelerdir ?
SELECT ProductName
FROM Products
WHERE UnitPrice BETWEEN 50 AND 100

-- 1 temmuz 1996 ile 31 aralýk 1996 tarihleri arasýndaki sipariþleri ID ve Tarihleri nedir ? 
SELECT OrderID , OrderDate
FROM Orders
WHERE OrderDate BETWEEN '1996-07-01' AND '1996-12-31'

-- En pahalý ürünümün adý nedir ?
--SELECT TOP 1 ProductName , UnitPrice FROM Products ORDER BY UnitPrice DESC -- 1. YÖNTEM
SELECT ProductName , UnitPrice 
FROM Products
WHERE UnitPrice = (SELECT MAX(UnitPrice) FROM Products) -- 2. YÖNTEM

-- En ucuz 5 ürünü getiriniz
SELECT TOP 5 ProductName , UnitPrice 
FROM Products
ORDER BY UnitPrice ASC

-- En ucuz 5 ürünün ortalama fiyatý nedir ?
-- SUB QUERY kullanarak yaptým 
SELECT AVG(T.UnitPrice) AS Avarage
FROM(SELECT TOP 5 UnitPrice FROM Products ORDER BY UnitPrice ASC) AS T

-- En ucuz 5 ürünün toplam fiyatý nedir ?
SELECT SUM(T.UnitPrice) AS Total
FROM(SELECT TOP 5 UnitPrice FROM Products ORDER BY UnitPrice ASC) AS T

-- Ürün adlarýnýn hepsine ön ek olarak 'PR' ekleyerek ve büyük harf olarak ekrana yazdýrýnýz
-- UPPER => BÜYÜK HARF
SELECT 'PR' + UPPER(ProductName) FROM Products

-- 1997 yýlý þubat ayýnda kaç sipariþim var ?
SELECT COUNT(*) AS OrderCountBy1997Feb
FROM Orders
WHERE YEAR(OrderDate) = 1997 AND MONTH(OrderDate) = 02

-- 1997 yýlýnda sipariþ veren müþterilerimin contactname ve telefon numarasý nelerdir ?
SELECT DISTINCT C.ContactName , C.Phone 
FROM Orders AS O
	INNER JOIN Customers AS C ON C.CustomerID = O.CustomerID
WHERE YEAR(O.OrderDate) = 1997

-- Taþýma ücreti 40 ve üzeri olan sipariþlerimin þehri , müþterisinin adý nedir ?
SELECT DISTINCT C.CompanyName , C.Country , C.City
FROM Orders AS O
	INNER JOIN Customers AS C ON C.CustomerID = O.CustomerID
WHERE O.Freight >= 40

-- Geciken sipariþlerim ?
SELECT * 
FROM Orders 
WHERE ShippedDate >= RequiredDate

-- Geciken sipariþlerimin tarihi , müþterisinin adý nedir ?
SELECT O.OrderDate , C.CompanyName 
FROM Orders AS O
		INNER JOIN Customers AS C ON C.CustomerID = O.CustomerID
WHERE O.ShippedDate >= O.RequiredDate

-- 10248 nolu sipariþte satýlan ürünlerin adý , kategorisinin adý , adedi ( category , product , orderDetails )
SELECT P.ProductName , C.CategoryName , OD.Quantity
FROM Orders AS O
	INNER JOIN [Order Details] AS OD ON OD.OrderID = O.OrderID
	INNER JOIN Products AS P ON P.ProductID = OD.ProductID
	INNER JOIN Categories AS C ON C.CategoryID = P.CategoryID
WHERE O.OrderID = 10248
 
-- 3 numaralý ID'ye sahip çalýþanýn 1997 yýlýnda sattýðý ürünlerin adý ve adedi nedir ?
SELECT P.ProductName , OD.Quantity
FROM Orders AS O
 	INNER JOIN [Order Details] AS OD ON OD.OrderID = O.OrderID
	INNER JOIN Products AS P ON P.ProductID = OD.ProductID
WHERE O.EmployeeID = 3 AND YEAR(O.OrderDate) = 1997

-- 1997 yýlýnda bir defasýnda en çok satýþ yapan çalýþanýmýn ID , ad , soyad , toplam satýþý 
SELECT TOP 1 O.OrderID , E.EmployeeID , E.FirstName , E.LastName , SUM(OD.Quantity * OD.UnitPrice) AS TOPLAM
FROM Orders AS O
 	INNER JOIN [Order Details] AS OD ON OD.OrderID = O.OrderID
	INNER JOIN Employees AS E ON E.EmployeeID = O.EmployeeID
WHERE YEAR(O.OrderDate) = 1997
GROUP BY O.OrderID , E.EmployeeID , E.FirstName , E.LastName
ORDER BY TOPLAM DESC
-- En çok satýþ yapan çalýþan dediði için TOP 1 diye belirttim.

-- En pahalý ürünümün adý , fiyatý ve kategorisinin adý nedir?
SELECT TOP 1 P.ProductName , P.UnitPrice , C.CategoryName
FROM Products AS P
	INNER JOIN Categories AS C ON C.CategoryID = P.CategoryID
ORDER BY P.UnitPrice DESC

-- Sipariþi alan personelin adý , soyadý , sipariþ tarihi , sipariþ ID (Sýralama sipariþ tarihine göre)
SELECT E.FirstName , E.LastName , O.OrderID , O.OrderDate
FROM Orders AS O
	INNER JOIN Employees AS E ON E.EmployeeID = O.EmployeeID
ORDER BY O.OrderDate

-- Son 5 sipariþimin ortalama fiyatý ve orderID nedir? (sepet toplamý ortalamasý)
SELECT T.OrderID , SUM(T.Quantity * T.UnitPrice) / SUM(T.Quantity) AS ProductAvarage FROM 

(SELECT O.OrderID , O.OrderDate , OD.Quantity , OD.UnitPrice
FROM Orders AS O
	INNER JOIN [Order Details] AS OD ON OD.OrderID = O.OrderID
	WHERE O.OrderID IN (SELECT TOP 5 OrderID FROM Orders ORDER BY OrderDate DESC)
) AS T

GROUP BY T.OrderID

-- En çok satýlan ürünümün (adet bazýnda) adý, kategorisinin adý ve tedarikçisinin adý
SELECT P.ProductName , OD.Quantity , C.CategoryName , S.CompanyName AS SupplierName
FROM [Order Details] AS OD
	INNER JOIN Products AS P ON P.ProductID = OD.ProductID
	INNER JOIN Categories AS C ON C.CategoryID = P.CategoryID
	INNER JOIN Suppliers AS S ON S.SupplierID = P.SupplierID
WHERE Quantity = (SELECT MAX(Quantity) FROM [Order Details])











































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































