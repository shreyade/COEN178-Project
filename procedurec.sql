/* procedure:  Write a PLSQL procedure that given an orderid and shipping date as parameters, 
sets the shippingDate.
*/

Create or Replace Procedure setShippingDate(orderIdInput IN Integer, shippedDateInput IN date)

AS
	shippedDate DATE; 
    orderDate DATE; 
    beforeOrdered EXCEPTION;   
 
BEGIN
    SELECT orderDate INTO orderDate
    FROM itemOrder
    WHERE orderId = orderIdInput;

    DBMS_OUTPUT.PUT_LINE(orderDate);


    IF shippedDateInput < orderDate THEN
        RAISE beforeOrdered;
    ELSE 
        DBMS_OUTPUT.PUT_LINE('BYE');

        UPDATE itemOrder
        SET shippedDate = shippedDateInput
        WHERE orderId = orderIdInput; 

    END IF; 

EXCEPTION
    WHEN beforeOrdered THEN
        raise_application_error (-20002,'That shipping date is before the ordered date.');

END;
/
Show errors

execute setShippingDate(1017, DATE '19-12-12');