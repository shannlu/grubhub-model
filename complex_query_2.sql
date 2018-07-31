\c grubhub;
-- As a user, I want to block the lowest rated restaurant

START TRANSACTION;
DROP FUNCTION IF EXISTS delete_lowest();

CREATE FUNCTION close_lowest()
RETURNS void
language plpgsql AS
$$
BEGIN
    UPDATE Restaurant
    SET phone_number = 'unavailable', name = 'closed', location = 'unknown'
          Where rest_id =  (Select rest_id
                              from Restaurant_Rating
                          group by rest_id
                          order by avg(rating) DESC 
                             Limit 1 ); 
END
$$;

SELECT * FROM Restaurant;
SELECT close_lowest();
SELECT * FROM Restaurant;
