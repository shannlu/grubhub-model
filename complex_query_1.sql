\c grubhub;
--As a user, I want to see the cheapest drink in a certain restaurant.

START TRANSACTION;

DROP FUNCTION IF EXISTS list_rest(text);

CREATE FUNCTION list_rest(rest_name text)
RETURNS TABLE(type text, price int)
language plpgsql AS
$$
BEGIN
	return query(select D.type, M.price
		           from Menu as M
		           join Drink as D
		             on M.item_id = D.item_id
		          where rest_id = (select rest_id
		          	                 from Restaurant
		          	                where name = rest_name)
		       order by M.price ASC
		          limit 1);
END
$$;

SELECT list_rest('Noodlehead');