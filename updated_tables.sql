CREATE TABLE storeItems(
    itemId INTEGER PRIMARY KEY,
    itemType VARCHAR(15) NOT NULL, 
    price NUMERIC(10,2) NOT NULL,
    qtyInStock INTEGER NOT NULL,
    CONSTRAINT chkItem CHECK(qtyInStock >= 0 AND (itemType = 'Comic Book'OR itemType = 'T-Shirt'))
);

CREATE TABLE comicBook(
    itemId INTEGER PRIMARY KEY,
    IBSN VARCHAR(20) UNIQUE,
    title VARCHAR(30),
    publishedDate DATE,
    FOREIGN KEY (itemId) REFERENCES storeItems (itemId) 
);

CREATE TABLE tShirt(
    itemId INTEGER PRIMARY KEY,
    shirtSize VARCHAR(5),
    FOREIGN KEY (itemId) REFERENCES storeItems (itemId),
    CONSTRAINT chkSize CHECK (shirtSize = 'XS' OR shirtSize = 'S' OR shirtSize = 'M' OR shirtSize = 'L' OR shirtSize = 'XL' OR shirtSize = 'XXL')
);

CREATE TABLE customerAll(
    custId INTEGER PRIMARY KEY,
    custName VARCHAR(20),
    phoneEmail VARCHAR(30) NOT NULL UNIQUE,
    custAddress VARCHAR(30) NOT NULL,
    custType VARCHAR(15) NOT NULL, 
    CONSTRAINT chkCustType CHECK (custType = 'Regular' OR custType = 'Gold')
);

CREATE OR REPLACE TRIGGER goldCustAdd
AFTER insert on customerAll
for each row
when (New.custType = 'Gold')
begin
INSERT INTO customerGold VALUES(:New.custId, SYSDATE);
End; 
/
show errors

CREATE TABLE customerGold(
    custId INTEGER PRIMARY KEY, 
    dateJoined DATE, 
    FOREIGN KEY (custId) REFERENCES customerAll (custId)
);

CREATE TABLE itemOrder(
    orderId INTEGER PRIMARY KEY, 
    custId INTEGER, 
    orderDate DATE, 
    shippingFee NUMERIC(10,2), 
    shippedDate DATE, 
    FOREIGN KEY (custId) REFERENCES customerAll (custId)
);

CREATE TABLE orderHas(
    orderId INTEGER, 
    itemId INTEGER, 
    quantity INTEGER,
    PRIMARY KEY(orderId, itemId),
    FOREIGN KEY (itemId) REFERENCES storeItems (itemId)
);