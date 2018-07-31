\c grubhub;

-- as a user, browse menu of a particular restaurant
DROP FUNCTION IF EXISTS browse_menu(text);

CREATE FUNCTION browse_menu(rest_name text)
RETURNS table(item_id int, price int)
LANGUAGE plpgsql AS
$$
BEGIN
    return query
    (SELECT m.item_id, m.price
       FROM Menu as m
      WHERE m.rest_id = (SELECT rest_id
                           FROM Restaurant
                          WHERE name = rest_name));
END
$$;

SELECT browse_menu('Chipotle');


-- as a driver, get the phone number to contact the customer 
DROP FUNCTION IF EXISTS get_number(int);

CREATE FUNCTION get_number(order_num int) 
RETURNS text
LANGUAGE plpgsql AS 
$$
BEGIN
    return
    (SELECT u.phone_number
       FROM "User" as u
       JOIN "Order" as o on o.user_id = u.user_id
      WHERE o.order_id = order_num);
END
$$;

SELECT get_number(3);


-- as a restaurant owner, get emails of customers
DROP FUNCTION IF EXISTS get_emails(text);

CREATE FUNCTION get_emails(rest_name text)
RETURNS table(email text)
LANGUAGE plpgsql AS
$$
BEGIN
    return query
    (SELECT DISTINCT(u.email)
      FROM "User" as u
      JOIN "Order" as o on o.user_id = u.user_id
      JOIN Restaurant as r on r.rest_id = o.rest_id
      GROUP BY r.rest_id, u.email
      HAVING r.name = rest_name);
END
$$;

SELECT get_emails('Chipotle');


-- as a restaurant owner, get average menu item price
DROP FUNCTION IF EXISTS price_point(text);

CREATE FUNCTION price_point(rest_name text)
RETURNS decimal
LANGUAGE plpgsql AS
$$
BEGIN
    return 
    (SELECT avg(m.price)
       FROM Menu as m
       JOIN Restaurant as r on m.rest_id = r.rest_id
      WHERE r.name = rest_name);
END
$$;

SELECT price_point('Chipotle');


-- as a user, i only want to see the drink menu
DROP FUNCTION IF EXISTS drink_menu(text);

CREATE FUNCTION drink_menu(rest_name text)
RETURNS table(item_id int, price int)
LANGUAGE plpgsql AS
$$
BEGIN
    return query
    (SELECT m.item_id, m.price
     FROM Menu as m
     JOIN Restaurant as r on r.rest_id = m.rest_id
     JOIN Drink as d on d.item_id = m.item_id
    WHERE d.item_id IN (SELECT m.item_id FROM Menu) and r.name = rest_name);
END
$$;

SELECT drink_menu('Sushi Fuku');


-- as a user, i want to see the card type linked to my account
DROP FUNCTION IF EXISTS show_card_type(text);

CREATE FUNCTION show_card_type(user_name text)
RETURNS text
LANGUAGE plpgsql AS
$$
BEGIN
    return 
    (SELECT CNT.card_type
        FROM "User" as U
        JOIN Payment as P on P.payment_id = U.payment_id
        JOIN CardPayID as CPI on CPI.payment_id = P.payment_id
        JOIN CardNumType as CNT on CNT.card_num = CPI.card_num
        WHERE U.name = user_name);
END
$$;

SELECT show_card_type('Ruilin Feng');

