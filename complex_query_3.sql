\c grubhub;
START TRANSACTION;

-- As a restaurant owner, I want to update my overall item price depending on my average rating 

DROP FUNCTION IF EXISTS change_price(text);

CREATE FUNCTION change_price(rest_name text)
RETURNS VOID
language plpgsql AS
$$
BEGIN
    IF (select avg(rating) 
          from Restaurant_Rating
         where rest_id = (select rest_Id 
                            from Restaurant
                           where name = rest_name)) > 4
      THEN
        UPDATE Menu set 
        price = price + 1
        where rest_id = (select rest_Id 
                           from Restaurant
                          where name = rest_name);
    ELSE 
      IF (select avg(rating) 
               from Restaurant_Rating
              where rest_id = (select rest_Id 
                                 from Restaurant
                                where name = rest_name)) < 3
      THEN UPDATE Menu set
        price = price - 1
        where rest_id = (select rest_Id 
                           from Restaurant
                          where name = rest_name);
      END IF;
    END IF;
END
$$;

SELECT * FROM Menu;
SELECT change_price('Chipotle');
SELECT * FROM Menu;
