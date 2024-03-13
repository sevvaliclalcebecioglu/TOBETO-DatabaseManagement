-- YORUM SATIRIDIR !	

SELECT * FROM Categories

SELECT * FROM Customers

SELECT CompanyName , ContactName , ContactTitle FROM Customers

--kolonlar� birle�tirebilirim
--stringler sql de '' aras�nda yaz�l�r
SELECT CompanyName , ContactName + '-' + ContactTitle FROM Customers 

-- yeni kolonlara isim verebilim => as 
SELECT CompanyName , ContactName + '-' + ContactTitle AS Contact FROM Customers 

-- verece�im isimde bo�luk b�rakmak istersem [] i�ine yazar�m
SELECT CompanyName , ContactName + '-' + ContactTitle AS [Contact Info] FROM Customers 

-- Distinct => �oklayan sat�rlar� teke d���rmeye yarar
-- �lkeleri tekrarlamadan bize �a��rd�
SELECT DISTINCT Country FROM Customers

-- Select Top => sorgulad���m�z bir sonu� k�mesinden belli adette ; en yukardan 5 adet , 10 adet ka� tane istiyorsam onu �ekmemize yarayan anahtar s�zc�kt�r.
-- Ba�tan 5 tanesinin t�m kolonlar�n� getir
SELECT TOP 5 * FROM Categories

-- Ba�tan 3 tanesinin sadece CategoryName'lerini getir
SELECT TOP 3 CategoryName FROM Categories

-- Tablonun %20'sini bana getir dedi�imiz zaman 
SELECT TOP 20 PERCENT * FROM Categories

-- Where Clause => select sorgular�nda ne istedi�imizi filtreleyebilece�imiz k�s�md�r
-- �nce tablonun hepsini �a��rd�m 
SELECT * FROM Products 

-- UnitPrice = 20 olanlar� �a��rmak i�in
SELECT * FROM Products 
WHERE UnitPrice = 21

-- Sat��ta olmayan �r�nleri �a��rmak i�in 
SELECT * FROM Products 
WHERE Discontinued = 1 --true olan

-- Sat��da olanlar
SELECT * FROM Products 
WHERE Discontinued = 0  --false olan

-- ProductName = 'Chang' olan
SELECT * FROM Products 
WHERE ProductName = 'Chang'

--Customers da Country = 'Mexico' olan
SELECT * FROM Customers 
WHERE Country = 'Mexico'

--Customers da Country = 'Mexico' olanlar�n CompanyName 'lerini g�ster
SELECT CompanyName FROM Customers 
WHERE Country = 'Mexico'

--UnitPrice > 30 olanlar� getir
SELECT * FROM Products 
WHERE UnitPrice > 30

--UnitPrice >= 30 olanlar� getir
SELECT * FROM Products 
WHERE UnitPrice >= 30

-- NOT => true;1  false;0

-- AND(ve) , OR(veya) , NOT(de�il) WHERE CLAUSE ile baraber kullan�l�r

-- �lkesi almanya olup AND �ehri berlin olan 
SELECT * FROM Customers
WHERE Country = 'Germany' AND City = 'Berlin'

-- �lkesi almanya olup AND �ehri berlin veya m�nchen olan 
SELECT * FROM Customers
WHERE Country = 'Germany' AND (City = 'Berlin' OR City = 'M�nchen')

-- �lkesi almanya olup AND �ehri berlin olmayanlar
SELECT * FROM Customers
WHERE Country = 'Germany' AND NOT City = 'Berlin'

-- order by => verileri ASC(A'dan Z'ye) veya DESC(Z'den A'ya) olarak s�ralamam�z� sa�lar.
-- Hi� bir �ey yazmazsak varsay�lan� ASC kabul ediyor.
-- Customers tablosundaki CompanyName'i A'dan Z'ye s�ralamak i�in
SELECT * FROM Customers
ORDER BY CompanyName ASC 

-- Customers tablosundan CompanyName , Country , City 'yi �a��r�p , Country ASC olarak s�rala 
SELECT CompanyName , Country , City FROM Customers
ORDER BY Country ASC

-- S�ralamak istediklerimi virg�l ile �o�altabilirim 
SELECT CompanyName , Country , City FROM Customers
ORDER BY Country ASC , City ASC

-- Hangi �lkelerden m��terilerimiz var
-- M��terilerimi s�rala , �oklayan sat�rlar� yok et , tersten s�rala ve ilk 5'ini ver
SELECT DISTINCT TOP 5 COUNTRY FROM Customers
ORDER BY Country DESC

-- NULL olmayan diye de filtreleyebiliriz
-- NULL VE NOT NULL IS ile kullan�l�r
SELECT DISTINCT TOP 5 COUNTRY FROM Customers
WHERE Country IS NOT NULL 
ORDER BY Country DESC

-- Insert Into ile bir tabloya veri giri�i yap�yoruz
-- Tablonun NULL ge�mesini istedi�im zaman NULL VALUES , Varsay�lan de�er verebilmek i�in DEFAULT kullan�l�r.
SELECT * FROM Categories

INSERT INTO Categories (CategoryName , Description)
VALUES ('Cosmetics' , 'Kozmetik �r�nler')

INSERT INTO Categories (CategoryName , Description)
VALUES ('Cosmetics2' , NULL) -- NULL ge�mesini sa�lar 

INSERT INTO Categories (CategoryName , Description)
VALUES ('Cosmetics3' , DEFAULT) -- Varsay�lan verdi�im de�er yaz�l�r   

SELECT * FROM Customers

INSERT INTO Customers ([CustomerID],[CompanyName],[ContactName],[ContactTitle],[Address],[City],
[Region],[PostalCode],[Country],[Phone],[Fax])
Values ('COMPX' , 'X Company' , NULL, NULL, NULL, '�stanbul', NULL, NULL, 'T�rkiye', NULL, NULL)
 
-- UPDATE => Bir sat�rdaki veriyi g�ncellemek i�in kullan�l�r . Mutlaka Where ile Update edece�imiz sat�rlar� belirtmemiz laz�m.
SELECT * FROM Categories

UPDATE Categories SET CategoryName = 'Food' , Description = 'G�da �r�nleri'
WHERE CategoryID = 10 -- tek oldu�una eminsem CategoryName = 'Cosmetics2' diye de where belirtebilirim.

-- DELETE QUERY => Silme i�lemini yapan sorgular�m�zd�r 
SELECT * FROM Categories

-- Sonradan ekledi�imiz 'cosmetics3' sat�r�n� silecez
DELETE FROM Categories -- sadece bu sat�r� �al��t�r�rsam t�m kay�tlar silinecektir ve bunun geri d�n��� yok
WHERE CategoryID = 11

-- Truncate Table => Ayn� DELETE i�lemi gibi tablomuzdaki verileri silmemize sa�layan yap�d�r fakat DELETE den farkl� olarak tablonun yap�sal ayarlar�n� s�f�rlar.

-- M�N/MAX 
SELECT * FROM Products

-- En k���k de�erli �r�n�n ad�n� elde etmek i�in 
SELECT MIN(UnitPrice) AS "MIN" FROM Products

-- En y�ksek de�erli olan� elde etmek istedi�imiz zaman 
SELECT MAX(UnitPrice) AS "MAX" FROM Products

-- COUNT => Adet hesaplama 
-- AVG => Ortalama hesaplama
-- SUM => Toplam hesaplama

-- COUNT(*) dersem b�t�n sat�rlar� sayar . NULL sat�rlarda dahil
SELECT COUNT(*) AS [RowCount] FROM Products

-- Ama () i�inde kolon ismini belirtirsem o zaman NULL sat�rlar� saymaz 
SELECT COUNT(UnitsOnOrder) AS [RowCount] FROM Products

-- Sat��ta olmayan �r�nleri bana ver 
SELECT COUNT(*) AS [RowCount] FROM Products
WHERE Discontinued = 1

-- Sat��da olmayanlar�n ortalama birim fiyat�n� ver 
SELECT AVG(UnitPrice) AS [DiscontinuedAvarage] FROM Products
WHERE Discontinued = 1

-- Sat��da olanlar�n birim fiyat�n�n toplamlar�n� bana ver 
SELECT SUM(UnitPrice) AS [ContinuedTotal] FROM Products
WHERE Discontinued = 0

--LIKE & W�LDCARDS
--LIKE => nvarchar olan tablolarda filtreleme yapmam�z� sa�lar
SELECT * FROM Customers
WHERE CompanyName LIKE 'Alfreds Futterkiste' -- E�er like dan sonra '' i�ine direk de�er yazarsam LIKE "=" ile ayn� g�revi yapm�� olur.

-- �irket isminde a harfi ile ba�layanlar� getir
SELECT * FROM Customers
WHERE CompanyName LIKE 'a%'  

-- % ifadesi a ile ba�lay�p sonras�nda ne olursa olsun demektir. Tam terside olabilirdi.
SELECT * FROM Customers
WHERE CompanyName LIKE '%a' 

-- �ki taraf�nada koyabilirim . Mesela sa�da ve solda ne olursa olsun i�inde or ge�enler dersem ;
SELECT * FROM Customers
WHERE CompanyName LIKE '%or%' 

-- "_r%" birinci harf ne olursa olsun ikincisi r olsun sonrakiler de ne olursa olsun
SELECT * FROM Customers
WHERE CompanyName LIKE '_r%' 

-- 'Fran__%' ba�� fran olsun sonraki iki harf ne olursa olsun sonrakilerde ne olursa olsun 
SELECT * FROM Customers
WHERE CompanyName LIKE 'Fran__%' -- ' ' aras�nda bo�luk b�rak�rsam alg�lar

-- '[a-d]%' a ve d aras�ndaki bi harf ile ba�lay�p sonras� ne olursa olsun getir
SELECT * FROM Customers
WHERE CompanyName LIKE '[a-d]%' 

-- '[^a-d]%' a ve d aras�ndaki bi harf ile ba�lamayanlar� getir demektir.
SELECT * FROM Customers
WHERE CompanyName LIKE '[^a-d]%' 
ORDER BY CompanyName

-- '[adx]%' aralar�na - koymad���m�z zaman adx ile ba�layan demektir
SELECT * FROM Customers
WHERE CompanyName LIKE '[adx]%' 

--'[^adx]%' aralar�na - koymad���m�z zaman adx ile ba�layan demektir . ^ eklersek i�ermeyenleri getir demektir
SELECT * FROM Customers
WHERE CompanyName LIKE '[^adx]%' 
ORDER BY CompanyName

-- IN => WHERE CLAUSE i�inde kulland���m�z ifadelerdir . ��inde belli ifadeler ge�en �u verileri getir diye filtreleme yapar.
SELECT * FROM Customers
WHERE Country IN ('Mexico' , 'UK' , 'T�rkiye') -- nvarchar oldu�u i�in ' ' aras�nda yaz�l�r.

SELECT * FROM Categories
WHERE CategoryID IN (4,7,10) -- int oldu�u i�in direk yazar�m.

-- BETWEEN => Belli aral�ktaki de�erleri bana getir diyebildi�imiz ifadedir.
SELECT * FROM Products
WHERE UnitPrice BETWEEN 18 AND 29
ORDER BY UnitPrice

-- BETWEEN ile tarih aral�klar�n�da filtreleyebilirim.
SELECT * FROM Employees
WHERE BirthDate BETWEEN '1948-01-01' AND '1962-12-31'
ORDER BY BirthDate 

-- Denormalizasyon => Normal olan�n tersi bir tablodur
-- Normalizasyon => Veri taban� �zerinde verilerin do�ru bir �ekilde da��lmas�n� sa�lar.
-- Normalizasyonun Avantajlar� : 1- Veri b�t�nl���n� sa�lar 2- Verimli bir veri yap�s� sunar 3- Gereksiz veri tekrar�n� engeller , minimum alan kullan�r 4- Saklanan veri daha anla��l�r hale gelir 5- H�zl� sorgulama imkan� verir

-- �nemli 3 normalizasyon kural�
--1NF; 1-Her kolonda yaln�zca bir de�er bulunabilir 2-Ayn� tablo i�inde tekrarlayan kolonlar bulunamaz .
--2NF; 1-1NF'ye uygun olmal�d�r. 2- Her sat�r e�siz bir anahtarla tan�nmal�d�r.(PrimaryKey-UniqueKey) 3- Herhangi bir veri alt k�mesi birden �ok sat�rda tekrarlanmamal�d�r. bu t�r veri alt k�meleri i�in yeni tablolar olu�turulmal�d�r. 4- Ana tablolar ile yeni tablolar aras�nda d�� anahtarlar (foreignKey) kullan�larak ili�kiler tan�mlanmal�d�r.
--3NF; 1-Veri taban� 2NF olmal�d�r. 2- Anahtar olmayan hi� bir kolon bir di�eriine ba�l� olmamal� ya da ge�i�ken fonksiyonel bir ba��ml�l���(transitional functional depency)olmamal�d�r. Di�er bir de�i�le her kolon anahtara tam ba�l� olmak zorundad�r.


-- JOIN KAVRAMI => 2 veya daha fazla tablonun verisiyle �al���rken yard�mc� olan anahtar kelimedir. JOIN ile 2 tablonun versini tek bir sonu� olarak ekrana d�k�p sorgulayabiliriz.
-- JOIN yan t�mcesi, aralar�nda ilgili bir s�tuna (Primary Key - Foreign Key) dayal� olarak iki veya daha fazla tablodaki sat�rlar� birle�tirmek i�in kullan�l�r.

-- INNER JOIN => Her iki tabloda da e�le�en de�erlere sahip kay�tlar� d�nd�r�r.
SELECT P.ProductID , P.ProductName , S.CompanyName , C.CategoryName , P.UnitPrice
FROM Products AS P
	INNER JOIN Categories AS C ON C.CategoryID = P.CategoryID
	INNER JOIN Suppliers AS S ON S.SupplierID = P.SupplierID

-- LEFT JOIN => Soldaki tablodaki t�m kay�tlar� ve sa�daki tablodaki e�le�en kay�tlar� d�nd�r�r.
-- Categories - Products
SELECT P.ProductName , P.CategoryID , C.CategoryName
FROM Categories AS C
	LEFT JOIN Products AS P ON P.CategoryID = C.CategoryID

SELECT O.OrderID , O.OrderDate , O.EmployeeID , E.FirstName + ' ' + E.LastName AS Employee
FROM Orders AS O
	LEFT JOIN Employees AS E ON E.EmployeeID = O.EmployeeID

-- RIGHT JOIN => Sa�daki tablodaki t�m kay�tlar� ve soldaki tablodaki e�le�en kay�tlar� d�nd�r�r.
SELECT O.OrderID , O.OrderDate , O.EmployeeID , E.FirstName + ' ' + E.LastName AS Employee
FROM Orders AS O
	RIGHT JOIN Employees AS E ON E.EmployeeID = O.EmployeeID
  --WHERE O.OrderID IS NULL => Bunu da eklersem bana sadece null olanlar� ver demi� olurum .

SELECT P.ProductName , P.SupplierID , S.CompanyName
FROM Products AS P
	RIGHT JOIN Suppliers AS S ON S.SupplierID = P.SupplierID

-- FULL OUTER JOIN => Sol veya sa� tabloda bir e�le�me oldu�unda t�m kay�tlar� d�nd�r�r.
SELECT P.ProductName , C.CategoryID , C.CategoryName
FROM Products AS P
	FULL OUTER JOIN Categories AS C ON C.CategoryID = P.CategoryID
WHERE P.ProductName IS NULL -- ProductName NULL olanlar� verir.

-- UNION => �ki farkl� select sorgusunun birle�tirme amac� ile kullan�l�r. Tek bir tablo olarak d�nd�r�r. Otomatik olarak distinct'leyerek �oklayan sat�rlar� kald�r�r.
SELECT City FROM Customers -- Customers
UNION 
SELECT City FROM Suppliers -- Suppliers
ORDER BY City

-- UNION ALL => �oklayan sat�rlar�n da gelmesini sa�lar.
SELECT City FROM Customers -- Customers
UNION ALL
SELECT City FROM Suppliers -- Suppliers
ORDER BY City

-- SUB QUERY => Bir sorgunun i�inde ba�ka bir sorgunun da yer almas� 
-- Birden �ok kay�tta kesinlikle IN kullanmam laz�m . Tek kay�tlarda = de kullanabilirim.
-- Tedarik�ilerimin oldu�u �lkelerdeki m��terilerimi elde etmek istiyorum 
SELECT *
FROM Customers
WHERE Country IN (SELECT DISTINCT Country FROM Suppliers) -- IN i�inde olan demektir , i�eren .

SELECT *
FROM Customers
WHERE Country = (SELECT TOP 1 Country FROM Suppliers ORDER BY Country DESC)

-- GROUP BY KAVRAMI 
-- Ayn� de�erlere sahip sat�rlar� �zetleyerek sat�rlar� grupland�r�r. Ve bu sat�rlar �zerinde baz� toplu fonksiyonlar ger�ekle�tirmemizi sa�lar.

-- AGGREGATE FUNCTIONS KULLANIMI 
-- COUNT
SELECT Country , City , COUNT(CustomerID) AS [Count] FROM Customers 
GROUP BY Country , City  -- �lkeye g�re grupla + �ehir ve �lkeleri ayn� olanlar� grupla 
ORDER BY Country , City
  
-- OrderDteails => Sipari�in detaylar�n� veren tablomuz
-- SUM
SELECT OrderID , SUM(Quantity * UnitPrice) AS TOTAL
FROM [Order Details]
GROUP BY OrderID   -- �oklayan sat�rlar� teke d���r�r.
ORDER BY TOTAL DESC

-- AVG
-- Birim baz�nda de�il de sat�r baz�nda ortama i�in 
-- Her bir �r�n ortama ne kadara gelmi�tir
-- �r�n bazl� ortama fiyat
SELECT OrderID , AVG(Quantity * UnitPrice) AS AvarageByProduct
FROM [Order Details]
GROUP BY OrderID  
ORDER BY AvarageByProduct DESC

-- �r�n adedi bazl� ortalama fiyat 
SELECT OrderID , SUM(Quantity * UnitPrice) / SUM(Quantity) AS AvarageByQuantity
FROM [Order Details]
GROUP BY OrderID   
ORDER BY AvarageByQuantity DESC

-- HAVING => GROUP BY ifadesinde filtreleme i�in kullan�l�r. WHERE de�il HAVING kullan�l�r.
SELECT Country , City , COUNT(CustomerID) AS [Count] FROM Customers 
GROUP BY Country , City 
HAVING  COUNT(CustomerID) > 2  -- 2'den b�y�k olanlar� getir diye filtreleme yapt�m .
ORDER BY [Count] ASC

SELECT Country , City , COUNT(CustomerID) AS [Count] FROM Customers 
GROUP BY Country , City 
HAVING  COUNT(CustomerID) > 2 AND Country IN ('Brazil' , 'France') -- 2'den b�y�k olanlar� ve �lkesi ... i�erenleri getir diye filtreleme yapt�m .
ORDER BY [Count] DESC







