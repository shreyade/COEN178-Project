CREATE OR REPLACE FUNCTION getItemsTotal (orderIdInput IN INTEGER)
RETURN NUMBER IS 
itemsTotal NUMBER; 
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

itemsTotal := itemsTotal + (priceInput*quanitityInput);

END LOOP; 

CLOSE itemIdCursor;

return itemsTotal;
END;
/
show errors

select getItemsTotal(1014) from dual;

