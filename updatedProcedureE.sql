CREATE OR REPLACE PROCEDURE printInfo (custIdInput IN INTEGER, startDateInput IN DATE)
AS

startDate DATE; 

custIdLocal INTEGER; 
custNameLocal VARCHAR(20); 
phoneEmailLocal VARCHAR(30); 
custAddressLocal VARCHAR(30); 

orderIdLocal INTEGER; 
itemIdLocal INTEGER; 
itemTypeLocal VARCHAR(15); 
priceLocal NUMERIC(10,2); 
orderDateLocal DATE; 
shippedDateLocal DATE;

CURSOR orderIdCursor IS 
SELECT orderId 
FROM itemOrder
WHERE custId = custIdInput AND orderDate >= startDateInput;

CURSOR itemIdCursor IS 
SELECT itemId 
FROM orderHas
WHERE orderId = orderIdLocal;

totalPrice NUMERIC(10,2);
itemsTotal NUMERIC(10,2);
orderTotal NUMERIC(10,2);
tax NUMERIC(10,2); 
shippingFee NUMERIC(10,2);
discount NUMERIC(10,2); 
grandTotal NUMERIC(10,2); 

BEGIN

custIdLocal := custIdInput; 
grandTotal := 0;
itemsTotal := 0; 

SELECT custName INTO custNameLocal
FROM customerAll
WHERE custId = custIdLocal; 

SELECT phoneEmail INTO phoneEmailLocal
FROM customerAll
WHERE custId = custIdLocal; 

SELECT custAddress INTO custAddressLocal
FROM customerAll
WHERE custId = custIdLocal; 

DBMS_OUTPUT.PUT_LINE('Customer Id: ' || custIdLocal);
DBMS_OUTPUT.PUT_LINE('Customer Name: ' || custNameLocal);
DBMS_OUTPUT.PUT_LINE('Customer Phone or Email: ' || phoneEmailLocal);
DBMS_OUTPUT.PUT_LINE('Customer Address: ' || custAddressLocal);
dbms_output.put_line(chr(10));

OPEN orderIdCursor;

LOOP
FETCH orderIdCursor INTO orderIdLocal;
EXIT WHEN orderIdCursor%NOTFOUND;

DBMS_OUTPUT.PUT_LINE('Order Id: ' || orderIdLocal); 

SELECT orderDate INTO orderDateLocal
FROM itemOrder 
WHERE orderId = orderIdLocal; 

SELECT shippedDate INTO shippedDateLocal
FROM itemOrder 
WHERE orderId = orderIdLocal; 

DBMS_OUTPUT.PUT_LINE('Order Date: ' || orderDateLocal); 
DBMS_OUTPUT.PUT_LINE('Shipped Date: ' || shippedDateLocal); 
dbms_output.put_line(chr(10));

    OPEN itemIdCursor;
    LOOP
    FETCH itemIdCursor INTO itemIdLocal;
    EXIT WHEN itemIdCursor%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('Item Id: ' || itemIdLocal);

    SELECT itemType into itemTypeLocal
    FROM storeItems
    WHERE itemId = itemIdLocal;

    SELECT price into priceLocal
    FROM storeItems
    WHERE itemId = itemIdLocal;

    DBMS_OUTPUT.PUT_LINE('Item Name: ' || itemTypeLocal);
    DBMS_OUTPUT.PUT_LINE('Item Price: ' || priceLocal);
    dbms_output.put_line(chr(10));

    END LOOP;
    CLOSE itemIdCursor;

    SELECT getItemsTotal(orderIdLocal) INTO totalPrice
    FROM dual;

    SELECT getTotal(orderIdLocal) INTO orderTotal
    FROM dual;

    SELECT getTax(orderIdLocal) INTO tax
    FROM dual;

    SELECT getDiscount(orderIdLocal) INTO discount
    FROM dual;
 
itemsTotal := itemsTotal + totalPrice;
grandTotal := grandTotal + orderTotal;


DBMS_OUTPUT.PUT_LINE('Items Total: ' || itemsTotal);
DBMS_OUTPUT.PUT_LINE('Grand Total: ' || grandTotal);
DBMS_OUTPUT.PUT_LINE('Tax: ' || tax);
DBMS_OUTPUT.PUT_LINE('Discount: ' || discount);

END LOOP; 
CLOSE orderIdCursor;




startDate := startDateInput; 

END; 
/
show errors; 





/* so you need to get the orderIds where cust id = input and orderDate > startdate */

/* that would be a cursor */

/* then for each thing in that you would have to have a loop inside
printing each item */

execute printInfo(111, DATE '12-12-12');