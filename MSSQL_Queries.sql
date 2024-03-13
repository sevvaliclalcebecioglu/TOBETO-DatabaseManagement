-- YORUM SATIRIDIR !	

SELECT * FROM Categories

SELECT * FROM Customers

SELECT CompanyName , ContactName , ContactTitle FROM Customers

--kolonlarý birleþtirebilirim
--stringler sql de '' arasýnda yazýlýr
SELECT CompanyName , ContactName + '-' + ContactTitle FROM Customers 

-- yeni kolonlara isim verebilim => as 
SELECT CompanyName , ContactName + '-' + ContactTitle AS Contact FROM Customers 

-- vereceðim isimde boþluk býrakmak istersem [] içine yazarým
SELECT CompanyName , ContactName + '-' + ContactTitle AS [Contact Info] FROM Customers 

-- Distinct => çoklayan satýrlarý teke düþürmeye yarar
-- ülkeleri tekrarlamadan bize çaðýrdý
SELECT DISTINCT Country FROM Customers

-- Select Top => sorguladýðýmýz bir sonuç kümesinden belli adette ; en yukardan 5 adet , 10 adet kaç tane istiyorsam onu çekmemize yarayan anahtar sözcüktür.
-- Baþtan 5 tanesinin tüm kolonlarýný getir
SELECT TOP 5 * FROM Categories

-- Baþtan 3 tanesinin sadece CategoryName'lerini getir
SELECT TOP 3 CategoryName FROM Categories

-- Tablonun %20'sini bana getir dediðimiz zaman 
SELECT TOP 20 PERCENT * FROM Categories

-- Where Clause => select sorgularýnda ne istediðimizi filtreleyebileceðimiz kýsýmdýr
-- Önce tablonun hepsini çaðýrdým 
SELECT * FROM Products 

-- UnitPrice = 20 olanlarý çaðýrmak için
SELECT * FROM Products 
WHERE UnitPrice = 21

-- Satýþta olmayan ürünleri çaðýrmak için 
SELECT * FROM Products 
WHERE Discontinued = 1 --true olan

-- Satýþda olanlar
SELECT * FROM Products 
WHERE Discontinued = 0  --false olan

-- ProductName = 'Chang' olan
SELECT * FROM Products 
WHERE ProductName = 'Chang'

--Customers da Country = 'Mexico' olan
SELECT * FROM Customers 
WHERE Country = 'Mexico'

--Customers da Country = 'Mexico' olanlarýn CompanyName 'lerini göster
SELECT CompanyName FROM Customers 
WHERE Country = 'Mexico'

--UnitPrice > 30 olanlarý getir
SELECT * FROM Products 
WHERE UnitPrice > 30

--UnitPrice >= 30 olanlarý getir
SELECT * FROM Products 
WHERE UnitPrice >= 30

-- NOT => true;1  false;0

-- AND(ve) , OR(veya) , NOT(deðil) WHERE CLAUSE ile baraber kullanýlýr

-- ülkesi almanya olup AND þehri berlin olan 
SELECT * FROM Customers
WHERE Country = 'Germany' AND City = 'Berlin'

-- ülkesi almanya olup AND þehri berlin veya münchen olan 
SELECT * FROM Customers
WHERE Country = 'Germany' AND (City = 'Berlin' OR City = 'München')

-- ülkesi almanya olup AND þehri berlin olmayanlar
SELECT * FROM Customers
WHERE Country = 'Germany' AND NOT City = 'Berlin'

-- order by => verileri ASC(A'dan Z'ye) veya DESC(Z'den A'ya) olarak sýralamamýzý saðlar.
-- Hiç bir þey yazmazsak varsayýlaný ASC kabul ediyor.
-- Customers tablosundaki CompanyName'i A'dan Z'ye sýralamak için
SELECT * FROM Customers
ORDER BY CompanyName ASC 

-- Customers tablosundan CompanyName , Country , City 'yi çaðýrýp , Country ASC olarak sýrala 
SELECT CompanyName , Country , City FROM Customers
ORDER BY Country ASC

-- Sýralamak istediklerimi virgül ile çoðaltabilirim 
SELECT CompanyName , Country , City FROM Customers
ORDER BY Country ASC , City ASC

-- Hangi ülkelerden müþterilerimiz var
-- Müþterilerimi sýrala , çoklayan satýrlarý yok et , tersten sýrala ve ilk 5'ini ver
SELECT DISTINCT TOP 5 COUNTRY FROM Customers
ORDER BY Country DESC

-- NULL olmayan diye de filtreleyebiliriz
-- NULL VE NOT NULL IS ile kullanýlýr
SELECT DISTINCT TOP 5 COUNTRY FROM Customers
WHERE Country IS NOT NULL 
ORDER BY Country DESC

-- Insert Into ile bir tabloya veri giriþi yapýyoruz
-- Tablonun NULL geçmesini istediðim zaman NULL VALUES , Varsayýlan deðer verebilmek için DEFAULT kullanýlýr.
SELECT * FROM Categories

INSERT INTO Categories (CategoryName , Description)
VALUES ('Cosmetics' , 'Kozmetik Ürünler')

INSERT INTO Categories (CategoryName , Description)
VALUES ('Cosmetics2' , NULL) -- NULL geçmesini saðlar 

INSERT INTO Categories (CategoryName , Description)
VALUES ('Cosmetics3' , DEFAULT) -- Varsayýlan verdiðim deðer yazýlýr   

SELECT * FROM Customers

INSERT INTO Customers ([CustomerID],[CompanyName],[ContactName],[ContactTitle],[Address],[City],
[Region],[PostalCode],[Country],[Phone],[Fax])
Values ('COMPX' , 'X Company' , NULL, NULL, NULL, 'Ýstanbul', NULL, NULL, 'Türkiye', NULL, NULL)
 
-- UPDATE => Bir satýrdaki veriyi güncellemek için kullanýlýr . Mutlaka Where ile Update edeceðimiz satýrlarý belirtmemiz lazým.
SELECT * FROM Categories

UPDATE Categories SET CategoryName = 'Food' , Description = 'Gýda Ürünleri'
WHERE CategoryID = 10 -- tek olduðuna eminsem CategoryName = 'Cosmetics2' diye de where belirtebilirim.

-- DELETE QUERY => Silme iþlemini yapan sorgularýmýzdýr 
SELECT * FROM Categories

-- Sonradan eklediðimiz 'cosmetics3' satýrýný silecez
DELETE FROM Categories -- sadece bu satýrý çalýþtýrýrsam tüm kayýtlar silinecektir ve bunun geri dönüþü yok
WHERE CategoryID = 11

-- Truncate Table => Ayný DELETE iþlemi gibi tablomuzdaki verileri silmemize saðlayan yapýdýr fakat DELETE den farklý olarak tablonun yapýsal ayarlarýný sýfýrlar.

-- MÝN/MAX 
SELECT * FROM Products

-- En küçük deðerli ürünün adýný elde etmek için 
SELECT MIN(UnitPrice) AS "MIN" FROM Products

-- En yüksek deðerli olaný elde etmek istediðimiz zaman 
SELECT MAX(UnitPrice) AS "MAX" FROM Products

-- COUNT => Adet hesaplama 
-- AVG => Ortalama hesaplama
-- SUM => Toplam hesaplama

-- COUNT(*) dersem bütün satýrlarý sayar . NULL satýrlarda dahil
SELECT COUNT(*) AS [RowCount] FROM Products

-- Ama () içinde kolon ismini belirtirsem o zaman NULL satýrlarý saymaz 
SELECT COUNT(UnitsOnOrder) AS [RowCount] FROM Products

-- Satýþta olmayan ürünleri bana ver 
SELECT COUNT(*) AS [RowCount] FROM Products
WHERE Discontinued = 1

-- Satýþda olmayanlarýn ortalama birim fiyatýný ver 
SELECT AVG(UnitPrice) AS [DiscontinuedAvarage] FROM Products
WHERE Discontinued = 1

-- Satýþda olanlarýn birim fiyatýnýn toplamlarýný bana ver 
SELECT SUM(UnitPrice) AS [ContinuedTotal] FROM Products
WHERE Discontinued = 0

--LIKE & WÝLDCARDS
--LIKE => nvarchar olan tablolarda filtreleme yapmamýzý saðlar
SELECT * FROM Customers
WHERE CompanyName LIKE 'Alfreds Futterkiste' -- Eðer like dan sonra '' içine direk deðer yazarsam LIKE "=" ile ayný görevi yapmýþ olur.

-- Þirket isminde a harfi ile baþlayanlarý getir
SELECT * FROM Customers
WHERE CompanyName LIKE 'a%'  

-- % ifadesi a ile baþlayýp sonrasýnda ne olursa olsun demektir. Tam terside olabilirdi.
SELECT * FROM Customers
WHERE CompanyName LIKE '%a' 

-- Ýki tarafýnada koyabilirim . Mesela saðda ve solda ne olursa olsun içinde or geçenler dersem ;
SELECT * FROM Customers
WHERE CompanyName LIKE '%or%' 

-- "_r%" birinci harf ne olursa olsun ikincisi r olsun sonrakiler de ne olursa olsun
SELECT * FROM Customers
WHERE CompanyName LIKE '_r%' 

-- 'Fran__%' baþý fran olsun sonraki iki harf ne olursa olsun sonrakilerde ne olursa olsun 
SELECT * FROM Customers
WHERE CompanyName LIKE 'Fran__%' -- ' ' arasýnda boþluk býrakýrsam algýlar

-- '[a-d]%' a ve d arasýndaki bi harf ile baþlayýp sonrasý ne olursa olsun getir
SELECT * FROM Customers
WHERE CompanyName LIKE '[a-d]%' 

-- '[^a-d]%' a ve d arasýndaki bi harf ile baþlamayanlarý getir demektir.
SELECT * FROM Customers
WHERE CompanyName LIKE '[^a-d]%' 
ORDER BY CompanyName

-- '[adx]%' aralarýna - koymadýðýmýz zaman adx ile baþlayan demektir
SELECT * FROM Customers
WHERE CompanyName LIKE '[adx]%' 

--'[^adx]%' aralarýna - koymadýðýmýz zaman adx ile baþlayan demektir . ^ eklersek içermeyenleri getir demektir
SELECT * FROM Customers
WHERE CompanyName LIKE '[^adx]%' 
ORDER BY CompanyName

-- IN => WHERE CLAUSE içinde kullandýðýmýz ifadelerdir . Ýçinde belli ifadeler geçen þu verileri getir diye filtreleme yapar.
SELECT * FROM Customers
WHERE Country IN ('Mexico' , 'UK' , 'Türkiye') -- nvarchar olduðu için ' ' arasýnda yazýlýr.

SELECT * FROM Categories
WHERE CategoryID IN (4,7,10) -- int olduðu için direk yazarým.

-- BETWEEN => Belli aralýktaki deðerleri bana getir diyebildiðimiz ifadedir.
SELECT * FROM Products
WHERE UnitPrice BETWEEN 18 AND 29
ORDER BY UnitPrice

-- BETWEEN ile tarih aralýklarýnýda filtreleyebilirim.
SELECT * FROM Employees
WHERE BirthDate BETWEEN '1948-01-01' AND '1962-12-31'
ORDER BY BirthDate 

-- Denormalizasyon => Normal olanýn tersi bir tablodur
-- Normalizasyon => Veri tabaný üzerinde verilerin doðru bir þekilde daðýlmasýný saðlar.
-- Normalizasyonun Avantajlarý : 1- Veri bütünlüðünü saðlar 2- Verimli bir veri yapýsý sunar 3- Gereksiz veri tekrarýný engeller , minimum alan kullanýr 4- Saklanan veri daha anlaþýlýr hale gelir 5- Hýzlý sorgulama imkaný verir

-- Önemli 3 normalizasyon kuralý
--1NF; 1-Her kolonda yalnýzca bir deðer bulunabilir 2-Ayný tablo içinde tekrarlayan kolonlar bulunamaz .
--2NF; 1-1NF'ye uygun olmalýdýr. 2- Her satýr eþsiz bir anahtarla tanýnmalýdýr.(PrimaryKey-UniqueKey) 3- Herhangi bir veri alt kümesi birden çok satýrda tekrarlanmamalýdýr. bu tür veri alt kümeleri için yeni tablolar oluþturulmalýdýr. 4- Ana tablolar ile yeni tablolar arasýnda dýþ anahtarlar (foreignKey) kullanýlarak iliþkiler tanýmlanmalýdýr.
--3NF; 1-Veri tabaný 2NF olmalýdýr. 2- Anahtar olmayan hiç bir kolon bir diðeriine baðlý olmamalý ya da geçiþken fonksiyonel bir baðýmlýlýðý(transitional functional depency)olmamalýdýr. Diðer bir deðiþle her kolon anahtara tam baðlý olmak zorundadýr.


-- JOIN KAVRAMI => 2 veya daha fazla tablonun verisiyle çalýþýrken yardýmcý olan anahtar kelimedir. JOIN ile 2 tablonun versini tek bir sonuç olarak ekrana döküp sorgulayabiliriz.
-- JOIN yan tümcesi, aralarýnda ilgili bir sütuna (Primary Key - Foreign Key) dayalý olarak iki veya daha fazla tablodaki satýrlarý birleþtirmek için kullanýlýr.

-- INNER JOIN => Her iki tabloda da eþleþen deðerlere sahip kayýtlarý döndürür.
SELECT P.ProductID , P.ProductName , S.CompanyName , C.CategoryName , P.UnitPrice
FROM Products AS P
	INNER JOIN Categories AS C ON C.CategoryID = P.CategoryID
	INNER JOIN Suppliers AS S ON S.SupplierID = P.SupplierID

-- LEFT JOIN => Soldaki tablodaki tüm kayýtlarý ve saðdaki tablodaki eþleþen kayýtlarý döndürür.
-- Categories - Products
SELECT P.ProductName , P.CategoryID , C.CategoryName
FROM Categories AS C
	LEFT JOIN Products AS P ON P.CategoryID = C.CategoryID

SELECT O.OrderID , O.OrderDate , O.EmployeeID , E.FirstName + ' ' + E.LastName AS Employee
FROM Orders AS O
	LEFT JOIN Employees AS E ON E.EmployeeID = O.EmployeeID

-- RIGHT JOIN => Saðdaki tablodaki tüm kayýtlarý ve soldaki tablodaki eþleþen kayýtlarý döndürür.
SELECT O.OrderID , O.OrderDate , O.EmployeeID , E.FirstName + ' ' + E.LastName AS Employee
FROM Orders AS O
	RIGHT JOIN Employees AS E ON E.EmployeeID = O.EmployeeID
  --WHERE O.OrderID IS NULL => Bunu da eklersem bana sadece null olanlarý ver demiþ olurum .

SELECT P.ProductName , P.SupplierID , S.CompanyName
FROM Products AS P
	RIGHT JOIN Suppliers AS S ON S.SupplierID = P.SupplierID

-- FULL OUTER JOIN => Sol veya sað tabloda bir eþleþme olduðunda tüm kayýtlarý döndürür.
SELECT P.ProductName , C.CategoryID , C.CategoryName
FROM Products AS P
	FULL OUTER JOIN Categories AS C ON C.CategoryID = P.CategoryID
WHERE P.ProductName IS NULL -- ProductName NULL olanlarý verir.

-- UNION => Ýki farklý select sorgusunun birleþtirme amacý ile kullanýlýr. Tek bir tablo olarak döndürür. Otomatik olarak distinct'leyerek çoklayan satýrlarý kaldýrýr.
SELECT City FROM Customers -- Customers
UNION 
SELECT City FROM Suppliers -- Suppliers
ORDER BY City

-- UNION ALL => Çoklayan satýrlarýn da gelmesini saðlar.
SELECT City FROM Customers -- Customers
UNION ALL
SELECT City FROM Suppliers -- Suppliers
ORDER BY City

-- SUB QUERY => Bir sorgunun içinde baþka bir sorgunun da yer almasý 
-- Birden çok kayýtta kesinlikle IN kullanmam lazým . Tek kayýtlarda = de kullanabilirim.
-- Tedarikçilerimin olduðu ülkelerdeki müþterilerimi elde etmek istiyorum 
SELECT *
FROM Customers
WHERE Country IN (SELECT DISTINCT Country FROM Suppliers) -- IN içinde olan demektir , içeren .

SELECT *
FROM Customers
WHERE Country = (SELECT TOP 1 Country FROM Suppliers ORDER BY Country DESC)

-- GROUP BY KAVRAMI 
-- Ayný deðerlere sahip satýrlarý özetleyerek satýrlarý gruplandýrýr. Ve bu satýrlar üzerinde bazý toplu fonksiyonlar gerçekleþtirmemizi saðlar.

-- AGGREGATE FUNCTIONS KULLANIMI 
-- COUNT
SELECT Country , City , COUNT(CustomerID) AS [Count] FROM Customers 
GROUP BY Country , City  -- Ülkeye göre grupla + þehir ve ülkeleri ayný olanlarý grupla 
ORDER BY Country , City
  
-- OrderDteails => Sipariþin detaylarýný veren tablomuz
-- SUM
SELECT OrderID , SUM(Quantity * UnitPrice) AS TOTAL
FROM [Order Details]
GROUP BY OrderID   -- Çoklayan satýrlarý teke düþürür.
ORDER BY TOTAL DESC

-- AVG
-- Birim bazýnda deðil de satýr bazýnda ortama için 
-- Her bir ürün ortama ne kadara gelmiþtir
-- Ürün bazlý ortama fiyat
SELECT OrderID , AVG(Quantity * UnitPrice) AS AvarageByProduct
FROM [Order Details]
GROUP BY OrderID  
ORDER BY AvarageByProduct DESC

-- Ürün adedi bazlý ortalama fiyat 
SELECT OrderID , SUM(Quantity * UnitPrice) / SUM(Quantity) AS AvarageByQuantity
FROM [Order Details]
GROUP BY OrderID   
ORDER BY AvarageByQuantity DESC

-- HAVING => GROUP BY ifadesinde filtreleme için kullanýlýr. WHERE deðil HAVING kullanýlýr.
SELECT Country , City , COUNT(CustomerID) AS [Count] FROM Customers 
GROUP BY Country , City 
HAVING  COUNT(CustomerID) > 2  -- 2'den büyük olanlarý getir diye filtreleme yaptým .
ORDER BY [Count] ASC

SELECT Country , City , COUNT(CustomerID) AS [Count] FROM Customers 
GROUP BY Country , City 
HAVING  COUNT(CustomerID) > 2 AND Country IN ('Brazil' , 'France') -- 2'den büyük olanlarý ve Ülkesi ... içerenleri getir diye filtreleme yaptým .
ORDER BY [Count] DESC







