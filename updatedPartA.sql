CREATE OR REPLACE PROCEDURE addToCart(orderIdInput IN INTEGER, itemIdInput IN INTEGER, custIdInput IN INTEGER, dateOrderedInput IN DATE, quantityInput IN INTEGER)
AS
    aboveMaximum EXCEPTION; 
    qtyInStock INTEGER; 
    qtyInStockAfter INTEGER;
    custType VARCHAR(15);
    shippedDateInput DATE; 
    shippingFeeInput NUMERIC(10,2);
    orderStarted INTEGER; 
    alreadyOrderedItem INTEGER; /* row count that just changes
    qty if in orderHas table already */

BEGIN 
    shippedDateInput := NULL; 

    SELECT qtyInStock INTO qtyInStock
    FROM storeItems
    WHERE itemId = itemIdInput;

    SELECT custType INTO custType
    FROM customerAll
    WHERE custId = custIdInput;

    SELECT count(*) INTO orderStarted
    FROM orderHas
    WHERE orderId = orderIdInput;

    SELECT count(*) INTO alreadyOrderedItem
    FROM orderHas
    WHERE orderId = orderIdInput AND itemId = itemIdInput;

    IF quantityInput > qtyInStock THEN 
        RAISE aboveMaximum;
    ELSE 
        DBMS_OUTPUT.PUT_LINE('BYE');
        qtyInStockAfter := qtyInStock - quantityInput; 
        UPDATE storeItems
        SET qtyInStock = qtyInStockAfter
        WHERE itemId = itemIdInput;
    END IF; 

    IF custType = 'Gold' THEN
        shippingFeeInput := 0.00; 
        DBMS_OUTPUT.PUT_LINE(shippingFeeInput);
    ELSE
        shippingFeeInput := 10.00;
        DBMS_OUTPUT.PUT_LINE(shippingFeeInput);
    END IF; 

    IF orderStarted = 0 THEN 
     INSERT INTO itemOrder Values (orderIdInput, custIdInput, dateOrderedInput, shippingFeeInput,shippedDateInput);
    END IF;

    IF alreadyOrderedItem = 0 THEN 
        INSERT INTO orderHas Values (orderIdInput, itemIdInput, quantityInput);
    ELSE
        UPDATE orderHas
        SET quantity = quantity + quantityInput
        WHERE orderId = orderIdInput AND itemId = itemIdInput;
    END IF; 

EXCEPTION
    WHEN aboveMaximum THEN
        raise_application_error (-20001,'We do not have that many of that item in stock, sorry!');
END; 
/
show errors

/* execute addToCart(1016, 1, 111, DATE '18-03-05', 1); */
/* execute addToCart(1017, 3, 111, DATE '18-03-05', 1); */
/* execute addToCart(1020, 3, 111, DATE '18-03-05', 1); */