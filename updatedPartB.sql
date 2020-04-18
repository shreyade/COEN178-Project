CREATE OR REPLACE TRIGGER custTypeUpdate
AFTER UPDATE on customerAll
for each row
WHEN (New.custType = 'Gold')
DECLARE 

CURSOR orderIdCursor IS 
SELECT orderId 
FROM itemOrder
WHERE custId = :New.custId;

orderIdInput INTEGER; 

BEGIN
OPEN orderIdCursor; 
LOOP
FETCH orderIdCursor INTO orderIdInput;
EXIT WHEN orderIdCursor%NOTFOUND;

UPDATE itemOrder
SET shippingFee = 0.00
WHERE orderId = orderIdInput AND shippedDate IS NULL; 


DBMS_OUTPUT.PUT_LINE('No Of rows fetched: ' || orderIdInput);
END LOOP; 
CLOSE orderIdCursor;

INSERT INTO customerGold VALUES(:New.custId, SYSDATE);
END; 
/
show errors

/* UPDATE customerAll
SET custType = 'Gold'
WHERE custId = 111; */


/* You should make another trigger to remove the customer from the gold table if they are updated to regular */