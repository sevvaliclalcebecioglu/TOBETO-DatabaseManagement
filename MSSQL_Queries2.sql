-- Brezil'de bulunan m��terilerimin bilgileri (�irket ad�, TemsilciAdi , Adres , �ehir , �lke)
SELECT CompanyName , ContactName , Address , City , Country
FROM Customers
WHERE Country = 'Brazil'

-- Brezilya'da olmayan m��terilerimin bilgileri (�irket Ad� , TemsilciAdi , Adres , �ehir , �lke )
-- <> ya da != �ekilde g�sterilir
SELECT CompanyName , ContactName , Address , City , Country
FROM Customers
WHERE Country <> 'Brazil'

-- �lkesi Spain ya da France ya da Germany olan m��terilerim?
SELECT CompanyName , ContactName , Address , City , Country
FROM Customers
--WHERE Country = 'Spain' OR Country = 'France' OR Country = 'Germany' 
WHERE Country IN ('Spain' , 'France' , 'Germany')  -- Bu �ekilde IN ile de kullanabilirim . ��nk� IN () biri olursa anlam�na gelir.

-- Faks numaras�n� bilmedi�im m��terilerim kimler ?
SELECT CompanyName , Fax 
FROM Customers
WHERE Fax IS NULL

-- Londra'da ya da Paris'de bulunan m��terilerim kimler ?
SELECT CompanyName , City
FROM Customers
WHERE City IN ('London' , 'Paris')

-- M��terilerimin i�inde en uzun isimli m��teri kimdir ? 
-- LENGTH => UZUNLUK HESAPLANIR
SELECT TOP 1 CompanyName , LEN(CompanyName) AS [LENGTH] 
FROM Customers
ORDER BY [LENGTH] DESC

-- Hem M�xico D.F.'da ikamet eden hem de ileti�im ki�isi �nvan�nda 'owner' olan m��terilerim kimler ? 
SELECT * 
FROM Customers
WHERE City = 'M�xico D.F.' AND ContactTitle = 'Owner'

-- C ile ba�layan �r�nlerimin isimleri ve fiyatlar� nelerdir ?
SELECT ProductName , UnitPrice 
FROM Products
WHERE ProductName LIKE 'C%'
ORDER BY UnitPrice DESC

-- Ad� (FirstName) 'A' harfiyle ba�layan �al��anlar�n (Employees); Ad , Soyad ve Do�um Tarihleri
SELECT FirstName , LastName , BirthDate 
FROM Employees
WHERE FirstName LIKE 'A%'

--1963 ve 1952 y�l�nda do�um g�n� olan �al��anlar�m kimler ?
-- YEAR => YILINI VER�R
SELECT FirstName , LastName , BirthDate 
FROM Employees
WHERE YEAR(BirthDate) IN (1963 , 1952)

-- Bug�n do�um g�n� olan �al��anlar�m kimler ?
SELECT FirstName , LastName , BirthDate 
FROM Employees
WHERE YEAR(BirthDate) = YEAR(GETDATE()) AND MONTH(BirthDate) = MONTH(GETDATE()) AND DAY(BirthDate) = DAY(GETDATE())

-- �sminde 'Restaurant' ge�en m��terilerimin �irket adlar� nelerdir ? 
SELECT CompanyName
FROM Customers
WHERE CompanyName LIKE '%RESTAURANT%'

-- 50$ ile 100$ aras�nda birim fiyat� bulunan t�m �r�nlerin adlar� ve fiyatlar� nelerdir ?
SELECT ProductName
FROM Products
WHERE UnitPrice BETWEEN 50 AND 100

-- 1 temmuz 1996 ile 31 aral�k 1996 tarihleri aras�ndaki sipari�leri ID ve Tarihleri nedir ? 
SELECT OrderID , OrderDate
FROM Orders
WHERE OrderDate BETWEEN '1996-07-01' AND '1996-12-31'

-- En pahal� �r�n�m�n ad� nedir ?
--SELECT TOP 1 ProductName , UnitPrice FROM Products ORDER BY UnitPrice DESC -- 1. Y�NTEM
SELECT ProductName , UnitPrice 
FROM Products
WHERE UnitPrice = (SELECT MAX(UnitPrice) FROM Products) -- 2. Y�NTEM

-- En ucuz 5 �r�n� getiriniz
SELECT TOP 5 ProductName , UnitPrice 
FROM Products
ORDER BY UnitPrice ASC

-- En ucuz 5 �r�n�n ortalama fiyat� nedir ?
-- SUB QUERY kullanarak yapt�m 
SELECT AVG(T.UnitPrice) AS Avarage
FROM(SELECT TOP 5 UnitPrice FROM Products ORDER BY UnitPrice ASC) AS T

-- En ucuz 5 �r�n�n toplam fiyat� nedir ?
SELECT SUM(T.UnitPrice) AS Total
FROM(SELECT TOP 5 UnitPrice FROM Products ORDER BY UnitPrice ASC) AS T

-- �r�n adlar�n�n hepsine �n ek olarak 'PR' ekleyerek ve b�y�k harf olarak ekrana yazd�r�n�z
-- UPPER => B�Y�K HARF
SELECT 'PR' + UPPER(ProductName) FROM Products

-- 1997 y�l� �ubat ay�nda ka� sipari�im var ?
SELECT COUNT(*) AS OrderCountBy1997Feb
FROM Orders
WHERE YEAR(OrderDate) = 1997 AND MONTH(OrderDate) = 02

-- 1997 y�l�nda sipari� veren m��terilerimin contactname ve telefon numaras� nelerdir ?
SELECT DISTINCT C.ContactName , C.Phone 
FROM Orders AS O
	INNER JOIN Customers AS C ON C.CustomerID = O.CustomerID
WHERE YEAR(O.OrderDate) = 1997

-- Ta��ma �creti 40 ve �zeri olan sipari�lerimin �ehri , m��terisinin ad� nedir ?
SELECT DISTINCT C.CompanyName , C.Country , C.City
FROM Orders AS O
	INNER JOIN Customers AS C ON C.CustomerID = O.CustomerID
WHERE O.Freight >= 40

-- Geciken sipari�lerim ?
SELECT * 
FROM Orders 
WHERE ShippedDate >= RequiredDate

-- Geciken sipari�lerimin tarihi , m��terisinin ad� nedir ?
SELECT O.OrderDate , C.CompanyName 
FROM Orders AS O
		INNER JOIN Customers AS C ON C.CustomerID = O.CustomerID
WHERE O.ShippedDate >= O.RequiredDate

-- 10248 nolu sipari�te sat�lan �r�nlerin ad� , kategorisinin ad� , adedi ( category , product , orderDetails )
SELECT P.ProductName , C.CategoryName , OD.Quantity
FROM Orders AS O
	INNER JOIN [Order Details] AS OD ON OD.OrderID = O.OrderID
	INNER JOIN Products AS P ON P.ProductID = OD.ProductID
	INNER JOIN Categories AS C ON C.CategoryID = P.CategoryID
WHERE O.OrderID = 10248
 
-- 3 numaral� ID'ye sahip �al��an�n 1997 y�l�nda satt��� �r�nlerin ad� ve adedi nedir ?
SELECT P.ProductName , OD.Quantity
FROM Orders AS O
 	INNER JOIN [Order Details] AS OD ON OD.OrderID = O.OrderID
	INNER JOIN Products AS P ON P.ProductID = OD.ProductID
WHERE O.EmployeeID = 3 AND YEAR(O.OrderDate) = 1997

-- 1997 y�l�nda bir defas�nda en �ok sat�� yapan �al��an�m�n ID , ad , soyad , toplam sat��� 
SELECT TOP 1 O.OrderID , E.EmployeeID , E.FirstName , E.LastName , SUM(OD.Quantity * OD.UnitPrice) AS TOPLAM
FROM Orders AS O
 	INNER JOIN [Order Details] AS OD ON OD.OrderID = O.OrderID
	INNER JOIN Employees AS E ON E.EmployeeID = O.EmployeeID
WHERE YEAR(O.OrderDate) = 1997
GROUP BY O.OrderID , E.EmployeeID , E.FirstName , E.LastName
ORDER BY TOPLAM DESC
-- En �ok sat�� yapan �al��an dedi�i i�in TOP 1 diye belirttim.

-- En pahal� �r�n�m�n ad� , fiyat� ve kategorisinin ad� nedir?
SELECT TOP 1 P.ProductName , P.UnitPrice , C.CategoryName
FROM Products AS P
	INNER JOIN Categories AS C ON C.CategoryID = P.CategoryID
ORDER BY P.UnitPrice DESC

-- Sipari�i alan personelin ad� , soyad� , sipari� tarihi , sipari� ID (S�ralama sipari� tarihine g�re)
SELECT E.FirstName , E.LastName , O.OrderID , O.OrderDate
FROM Orders AS O
	INNER JOIN Employees AS E ON E.EmployeeID = O.EmployeeID
ORDER BY O.OrderDate

-- Son 5 sipari�imin ortalama fiyat� ve orderID nedir? (sepet toplam� ortalamas�)
SELECT T.OrderID , SUM(T.Quantity * T.UnitPrice) / SUM(T.Quantity) AS ProductAvarage FROM 

(SELECT O.OrderID , O.OrderDate , OD.Quantity , OD.UnitPrice
FROM Orders AS O
	INNER JOIN [Order Details] AS OD ON OD.OrderID = O.OrderID
	WHERE O.OrderID IN (SELECT TOP 5 OrderID FROM Orders ORDER BY OrderDate DESC)
) AS T

GROUP BY T.OrderID

-- En �ok sat�lan �r�n�m�n (adet baz�nda) ad�, kategorisinin ad� ve tedarik�isinin ad�
SELECT P.ProductName , OD.Quantity , C.CategoryName , S.CompanyName AS SupplierName
FROM [Order Details] AS OD
	INNER JOIN Products AS P ON P.ProductID = OD.ProductID
	INNER JOIN Categories AS C ON C.CategoryID = P.CategoryID
	INNER JOIN Suppliers AS S ON S.SupplierID = P.SupplierID
WHERE Quantity = (SELECT MAX(Quantity) FROM [Order Details])











































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































