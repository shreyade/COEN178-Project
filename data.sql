INSERT INTO storeItems VALUES(1,'Comic Book',5.00, 10);
INSERT INTO storeItems VALUES(2,'Comic Book',6.00, 10);
INSERT INTO storeItems VALUES(3,'Comic Book',4.00, 10);
INSERT INTO storeItems VALUES(4,'Comic Book',3.00, 20);
INSERT INTO storeItems VALUES(5,'Comic Book',5.00, 20);
INSERT INTO storeItems VALUES(6,'T-Shirt',25.00, 10);
INSERT INTO storeItems VALUES(7,'T-Shirt',15.00, 10);
INSERT INTO storeItems VALUES(8,'T-Shirt',20.00, 10);
INSERT INTO storeItems VALUES(9,'T-Shirt',15.00, 20);
INSERT INTO storeItems VALUES(10,'T-Shirt',30.00, 20);


INSERT INTO comicBook VALUES(1, '12-34', 'Spiderwoman', DATE '2015-12-7');
INSERT INTO comicBook VALUES(2, '12-35', 'Batwoman', DATE '2016-10-15');
INSERT INTO comicBook VALUES(3, '12-36', 'Ant Man', DATE '2014-05-12');
INSERT INTO comicBook VALUES(4, '12-37', 'The Hulk', DATE '2019-11-5');
INSERT INTO comicBook VALUES(5, '12-38', 'The Spider', DATE '2018-12-1');

INSERT INTO tShirt VALUES(6, 'XS');
INSERT INTO tShirt VALUES(7, 'S');
INSERT INTO tShirt VALUES(8, 'M');
INSERT INTO tShirt VALUES(9, 'L');
INSERT INTO tShirt VALUES(10, 'XL');

INSERT INTO customerAll VALUES(101, 'Abby', 'abby@mail.com', '123 Brush Way', 'Regular');
INSERT INTO customerAll VALUES(102, 'Billy', '313-222-1574', '145 Tree Street', 'Regular');
INSERT INTO customerAll VALUES(103, 'Carol', 'carol@mail.com', '267 Leaf Lane', 'Regular');
INSERT INTO customerAll VALUES(104, 'Dean', 'dean@mail.com', '111 Flower Court', 'Gold');
INSERT INTO customerAll VALUES(105, 'Eddy', '402-515-9857', '333 Rose Drive', 'Gold');

<<<<<<< HEAD
INSERT INTO customerAll VALUES(106, 'Fiona', 'fiona@mail.com', '415 Tulip Way', 'Regular'); 
INSERT INTO customerAll VALUES(107, 'George', 'george@mail.com', '522 Oak Street', 'Regular');
INSERT INTO customerAll VALUES(108, 'Harry', '655-313-7270', '677 Pine Lane', 'Regular'); 
INSERT INTO customerAll VALUES(109, 'Isaac', 'isaac@mail.com', '555 Christmas Tree Court', 'Regular'); 
INSERT INTO customerAll VALUES(110, 'Jenny', 'jenny@mail.com', '622 Violet Drive', 'Regular'); 
INSERT INTO customerAll VALUES(111, 'Kali', 'kali@mail.com', '833 Maple Drive', 'Regular'); 
INSERT INTO customerAll VALUES(112, 'Lucy', 'luct@mail.com', '839 Willow Drive', 'Regular'); 


CREATE OR REPLACE PROCEDURE addOrderItem
=======

INSERT INTO itemOrder VALUES(201, 101, DATE '2015-12-7', 25.00, DATE '2016-10-15');
INSERT INTO itemOrder VALUES(204, 102, DATE '2016-10-15', 26.00, DATE '2015-12-7');

