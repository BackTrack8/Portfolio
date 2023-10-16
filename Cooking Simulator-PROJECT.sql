--PATRICIA CITRANEGARA KUSUMA-2301863585

USE [Cooking Simulator]

--1
SELECT 
	UPPER(FoodName) AS[Food Name],
	'IDR '+CAST(FoodPrice AS varchar)AS[Price ]
FROM Food
WHERE FoodName like '%Fried%'


--2
Select 
	ChefName AS[Chef],
	CAST(ChefRating AS VARCHAR)+' stars'AS [Chef Rating],
	FoodName
from Chef as C
	JOIN Food AS F
		ON F.ChefId =C.ChefId
WHERE CHARINDEX(' ',ChefName)>0

--3
Select 
	FoodName,
	sum(IngredientsQuantity*IngredientsPrice)as[Spending]
from Food as F
	join FoodIngredientsDetail as FID
		ON FID.FoodId=F.FoodId
	join Ingredient as I
		ON I.IngredientsId=FID.IngredientsId
WHERE FoodPrice<100000 
	AND (CookDuration BETWEEN 30 AND 60)
GROUP BY FoodName
HAVING Sum(IngredientsQuantity*IngredientsPrice) BETWEEN 50000 AND 150000

--4
SELECT
	'Rating '+cast(ChefRating as varchar) as [Chef Rating],
	count(FoodId)as[Total Food ],
	sum (FoodPrice)as[Total Food Price ]
FROM Chef AS C
	JOIN FOOD AS F
		ON C.ChefId=F.ChefId
where ChefRating=5
group by ChefRating
union
SELECT
	'Rating '+cast(ChefRating as varchar) as [Chef Rating],
	count(FoodId)as[Total Food ],
	sum (FoodPrice)as[Total Food Price ]
FROM Chef AS C
	JOIN FOOD AS F
		ON C.ChefId=F.ChefId
where ChefRating=3
group by ChefRating

--5

select distinct
	IngredientsName AS [Ingredient Name]
from Ingredient I
	JOIN FoodIngredientsDetail FID 
		ON FID.IngredientsId=I.IngredientsId
	JOIN Food F 
		ON F.FoodId=FID.FoodId
where FID.FoodId IN
	( 
	select 
		FoodId 
	from Food
    where FoodPrice between 50000 and 100000
	)
--6
SELECT 
	  SUBSTRING(FoodName, CHARINDEX(' ', FoodName) + 1, LEN(FoodName)) AS [Food Name],
	  FoodPrice AS[Price] 

FROM Food ,
	(
	SELECT 
		AVG(FoodPrice)AS AVG_PRICE
	FROM Food
	WHERE FoodType LIKE 'Beverage'
	)AS[AVG_VALUE]
WHERE CHARINDEX(' ',FoodName)>0 AND
	FoodPrice>AVG_PRICE
ORDER BY FoodPrice ASC 
-- order by dibuat karena menyesuaikan screenshoot soal
--7
GO
CREATE VIEW [Show Food]
AS

SELECT 
	(
	CASE 
		WHEN ( 0 != CHARINDEX(' ', ChefName))
			THEN
		LEFT(ChefName,CHARINDEX(' ',ChefName))
			ELSE ChefName
		END
	)AS [Chef Name],
	ChefRating as[Chef Rating],
	Foodname as[Food],
	foodtype as [Type],
	cookduration as Duration,
	'IDR '+CAST(FoodPrice AS varchar)AS[Price ]
FROM CHEF AS C
	JOIN Food AS F
		ON C.ChefId=F.ChefId

-- select * from [Show Food]

--8
GO
CREATE VIEW [Chef Food Price]
AS

Select 
	ChefName,
	'Rp. '+cast (sum(foodprice)as varchar) +',00'as [Total Food Price]
from CHEF AS C
	join Food as F
		on f.ChefId=c.ChefId

group by ChefName 
having sum(foodprice)>100000

-- select * from [Chef Food Price]

--9
select * from Chef

ALTER TABLE CHEF
ADD CheffGender char (6) NOT NULL
DEFAULT 'N/A'
go
ALTER TABLE CHEF
ADD constraint CHECK_CHEF_GENDER
CHECK(CheffGender='Male'or CheffGender='Female' or CheffGender='N/A')


--10
--BEGIN TRAN
	
UPDATE Chef
	SET ChefRating=ChefRating+1
	FROM Chef AS C
		JOIN Food AS F
			ON C.ChefId=F.ChefId
		JOIN FoodIngredientsDetail AS FID
			ON FID.FoodId=F.FoodId
		JOIN Ingredient AS I
			ON I.IngredientsId=FID.IngredientsId
	WHERE IngredientsName IN ('Garlic') AND FoodPrice > 10000

--ROLLBACK
--SELECT * FROM Chef

