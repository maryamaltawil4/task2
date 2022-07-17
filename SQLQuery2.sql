
create database todo;
use database todo;
----------- table and insert -------------------------------
---Resturant,categories ,categories_Res,items--- 
create table Resturant_1( r_id int NOT NULL , r_name varchar(70) NOT NULL,  primary key (r_id) );
INSERT INTO Resturant_1 VALUES (1, 'Chinese_Restaurant'),(2,'Orgado'),(3,'vanilla');
create table categories_1(c_id int   NOT NULL    IDENTITY  , c_name varchar(70) NOT NULL,  primary key (c_id) );
INSERT INTO categories_1 VALUES ('salads'),('hot drinks'),('fruit drinks');
INSERT INTO categories_1 VALUES ('soup '),('sweet'),('chicken chinese'),('burgers');
create table categories_Res( r_id  int   NOT NULL,c_id int NOT NULL ,primary key (c_id,r_id), FOREIGN KEY (c_id)
      REFERENCES categories_1 (c_id),FOREIGN KEY (r_id)   REFERENCES Resturant_1 (r_id));
iNSERT INTO categories_Res VALUES (2,1),(1,3),(2,4),(2,5),(2,7),(1,1),(1,2),(1,4),(1,5),(1,6),(3,1),(3,3),(3,5);
create table items_1(i_id int   NOT NULL    IDENTITY ,c_id  int ,  i_name varchar(70) NOT NULL , price float ,primary key (i_id) );
iNSERT INTO items_1 VALUES(1,'tossed salad',17) ,( 1,' tomato salad' ,10 ) , (1,'chef salad' , 32), ( 1,' creek salad ' , 21 )
,(2,'tea', 8) , (2,'coffee', 10 ) , (2,'Nescafe' ,15 ), (2,' hot chocolate' , 17 ) , (3,'Lemon juice', 15 ) ,(3,'Orange juice' , 16) 
,( 3,'cocktail' ,21 ),(4,'tomato soup' , 21) , (4,'potato soup ' , 22) , (4,'chicken soup' ,32 ),(5,'banana cupcakes',30),
(5,'chocolate cookies', 40 ) , (5,'lemon cake',21),(6,'chicken hot ',30) ,( 6,'chicken tomato' , 15) , 
(6,'chicken chinese behl ',40 ),(1,'chicken salad' ,20 ),(7,'fish burger',52) 
,(7,'cheese burger',50 ) ,( 7,' chicken burger',56) , ( 7,'big burger',67); 
--------------------------------------------------------------------------------------------------

 ---1) view Resturant name and items name :

 CREATE VIEW viewResturant_items  as 
 SELECT r.r_name ,i.i_name
 from Resturant_1 r inner join categories_Res c
 on  r.r_id= c.r_id
 inner join items_1 i
 on c.c_id=i.c_id;

SELECT * from viewResturant_items ;

----------------------------------------------------------------------------------------------------------
-----2)number items per Resturant 
   SELECT count( i.i_id ),r.r_name
 from Resturant_1 r inner join categories_Res c
 on  r.r_id= c.r_id
 inner join items_1 i
 on c.c_id=i.c_id group by r.r_id,r.r_name ;

 -----------------------------------------------------------------------------------------------------------
 ----3)avg number items per categories 
 SELECT avg (Cast(count1 as Float) ) as avg1 ,sum(count1)sum_items ,count (count1)as number_categories
 from (select count (i.i_id) as count1 ,c.c_name
 from categories_1 c inner join items_1 i
 on c.c_id=i.c_id group by c.c_id ,c.c_name) as count_1 ;


 -------------------------------------------------------------------------------------------------------------
 -----4)H/L avg price item per Resturant
SELECT  max (avg_price) AS H_avg_price ,min (avg_price) AS L_avg_price
from(
SELECT avg (price ) as avg_price, r.r_name 
from Resturant_1 r inner join categories_Res c
 on  r.r_id= c.r_id
 inner join items_1 i
 on c.c_id=i.c_id group by r.r_id,r.r_name) as avg1  ;

  -------------------------------------------------------------------------------------------------------------
  ----5) 3 th higest price item per Resturant
  SELECT i.price 
  FROM items_1 i
  ORDER BY price DESC OFFSET 2 ROWS FETCH NEXT 1 ROWS ONLY;

  --------------------------------------------------------------------------------------------------------------
  -----6)Resturant has more than 5 categories

  SELECT count ( c.c_id) as number_of_categories, r.r_name 
 from Resturant_1 r inner join categories_Res c
 on  r.r_id= c.r_id group by r.r_id,r.r_name having count ( c.c_id) >5;

 ----------------------------------------------------------------------------------------------------------------
 ---7)index price 
 CREATE INDEX idx_items_1_price
 ON items_1 (price);