/* write a plsql function that takes an orderid, computes the total for that order and returns the total.
The function should consider the customer type, tax, shipping fee etc to compute the total */

/* is the order ID an integer? */
Create or Replace Function computeTotal2(orderID in Integer)
RETURN NUMBER IS 
    total Integer;

DECLARE 
    /* variables: price, quantity, member */
    price NUMBER;
    quantity NUMBER;
    custType VARCHAR2;
    tax NUMBER;
    shippingFee NUMBER;
    discount NUMBER;

BEGIN

/* customer type: if regular member, shipping fee 10.00, if gold member 10.00 */

    /* tax is flat, check the customer type first:
    - shipping fee: based on customer type
    - discount: based on customer type, if over 100 $, 10% off
    */

    /* select custid which is gold and setting it to the member variable */
    select custType
    into custType
    from Customer 
    where custId = (Select custId FROM itemOrder where itemOrder.orderId = orderId);

     /* issue with selecting price from storeItems for each and every itemid
     price := (Select price from storeItems where */

    quantity := (Select quantity from orderHas where orderHas.orderId = orderId);
    total := price * quantity;

    /* If member variable == gold then we do special cases */
    IF custType = 'Gold' then
        shippingFee := 0;
       /* discount :=  */
    ELSE 
        shippingFee := 10.00;
        discount := 0;
    END IF;
 
    tax := total * 0.05;
    total := total + shippingFee + tax - discount;
END;
/
show errors
