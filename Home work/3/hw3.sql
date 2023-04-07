question #1

select * from hotel where hotelname like '__t%' order by hotelname desc;

---------------------------------------------------------------------------------------------------------------------------------

question #2

select h.hotelname,r.roomno,g.guestno,g.guestname,g.guestaddress from guest as g 
natural join booking as b   
natural join hotel as h     
natural join room as r      
where (g.guestaddress like '% Glasgow') and (g.guestname like 'Tony %' or g.guestname like '% Farrel');


---------------------------------------------------------------------------------------------------------------------------------

question #3

SELECT h.hotelno , h.hotelname ,  r.price FROM room as r natural join hotel as h
WHERE price = (SELECT MAX(price) FROM room WHERE price < (SELECT MAX(price) FROM room));


---------------------------------------------------------------------------------------------------------------------------------


question #4

SELECT h.hotelno , h.hotelname , r.roomno FROM room as r natural join hotel as h natural join booking as b
WHERE b.datefrom between '2005-01-01' and '2010-01-01';

---------------------------------------------------------------------------------------------------------------------------------

question #5

select h.hotelno, h.hotelname, r.price FROM room as r natural join hotel as h

where price = (select min(price) from room where price > (select min(price) from room where price > (select min(price) from room))) and r.type like '%single%';



---------------------------------------------------------------------------------------------------------------------------------

question #6


select hotelname from hotel as h where h.hotelno in (select r1.hotelno from room r1 , room r2 where r1.hotelno = r2.hotelno and r1.type = "double" and r2.type = "family");


---------------------------------------------------------------------------------------------------------------------------------

question #7


select hotelname from hotel as h where h.hotelno in (select table1.hotelno from room table1 , room table2 where table1.hotelno = table2.hotelno and table1.type = "single" and table2.type = "double" and table1.hotelno not in (select hotelno from
room where type = "family"));


---------------------------------------------------------------------------------------------------------------------------------

question #8

select h.hotelno, h.hotelname, r.roomno , r.type , r.price FROM room as r natural join hotel as h

where r.price < 40 and (r.type like '%double%' or r.type like '%family%') ORDER BY r.price ASC;


---------------------------------------------------------------------------------------------------------------------------------

question #9

select r.price , r.type FROM room as r natural join hotel as h

where h.hotelname like '%Grosvenor%';



---------------------------------------------------------------------------------------------------------------------------------

question #10



select g.guestname FROM guest as g natural join booking as b natural join hotel as h

where h.hotelname like '%Watergate%';


---------------------------------------------------------------------------------------------------------------------------------

question #11


select h.hotelname , count(r.hotelno) FROM hotel as h natural join room as r 

GROUP BY h.hotelname having count(r.hotelno) > 2;


select h.hotelname FROM hotel as h natural join room as r GROUP BY h.hotelname having count(r.hotelno) > 2;


---------------------------------------------------------------------------------------------------------------------------------

question #12


select count(*) FROM room as r natural join hotel as h where h.city = 'London';



---------------------------------------------------------------------------------------------------------------------------------





