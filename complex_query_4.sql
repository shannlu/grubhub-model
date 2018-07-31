\c grubhub;

-- As a restaurant owner, email the most frequent customer

START TRANSACTION;

DROP FUNCTION IF EXISTS email_freq(int);

CREATE FUNCTION email_freq(restid int)
returns TEXT
language plpgsql As

$$
BEGIN
	return (
	select email
	  from "User"
	 where user_id = (select user_id 
	 	                from "Order" 
	 	               where rest_id = restid
	 	            group by user_id
	 	            order by count(user_id) DESC
	 	               limit 1)
	 );

END
$$;

SELECT email_freq(2);
