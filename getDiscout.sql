CREATE OR REPLACE FUNCTION getDiscount (orderIdInput IN INTEGER)
RETURN NUMBER IS 
itemsTotal NUMBER; 
custTypeInput VARCHAR(15);
shippingFeeInput NUMBER; 
discount NUMBER; 
priceInput NUMBER; 
quanitityInput NUMBER;  
itemIdInput INTEGER; 

CURSOR itemIdCursor IS 
SELECT itemId 
FROM orderHas
WHERE orderId = orderIdInput;

BEGIN
itemsTotal := 0.00;
OPEN itemIdCursor;

LOOP
FETCH itemIdCursor INTO itemIdInput;
EXIT WHEN itemIdCursor%NOTFOUND;

SELECT price INTO priceInput
FROM storeItems
WHERE itemId = itemIdInput;

SELECT quantity INTO quanitityInput 
FROM orderHas
WHERE orderId = orderIdInput AND itemId = itemIdInput;

SELECT shippingFee INTO shippingFeeInput
FROM itemOrder
WHERE orderId = orderIdInput;

SELECT custType INTO custTypeInput
FROM customerAll
WHERE custId = (SELECT custId FROM itemOrder WHERE orderId = orderIdInput);

itemsTotal := itemsTotal + (priceInput*quanitityInput);

END LOOP; 

CLOSE itemIdCursor;

discount := 0;

IF custTypeInput = 'Gold' AND itemsTotal >= 100.00 THEN
    discount := itemsTotal * .1;
END IF;


return discount;
END;
/
show errors

select getDiscount(1014) from dual;