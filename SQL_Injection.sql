-- SQL INJECTION 
SELECT 2; -- 2 verir

SELECT 2-2; -- 0 verir

SELECT 2+1; -- 3 verir

SELECT '2-1'; -- 2-1 verir -- string olduğu için

SELECT '2' - '1' ; -- hata verir. 
--mysql'de sonuç değişir. 1 verir . Kendisi integer olarak çevirir.

-- postgresql de ise şu şekilde yaparız
SELECT CAST('2' AS integer) - CAST('1' AS integer); -- 1 verir

-- '2' + 'b'  => mysql => 2 çünkü b'yi 0 olarak algılar 
SELECT CAST('2' AS integer) + 'b' ;

SELECT '2' '1' ;  -- mysql => 21
SELECT '2' || '1' ; -- postgresql => 21


SELECT * FROM products WHERE product_id=2-1
-- sen burda matematiksel işlem yapmışsın . 2 - 1 = 1 yapar. id=1 getiriyim der . Ve sonuç olarak onu verir.

-- UNION SQL 














