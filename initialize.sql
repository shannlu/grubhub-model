\c postgres

DROP database if exists grubhub;
create database grubhub;
\c grubhub;
\i create.sql;

\copy "User"(user_id,name,phone_number,payment_id,email) from 'user.csv' with delimiter ',' csv header; 
\copy Driver(driver_id,name,car_plate,phone_number) from 'driver.csv' with delimiter ',' csv header;
\copy Restaurant(rest_id,phone_number,location,name) from 'restaurant.csv' with delimiter ',' csv header;
\copy Menu(item_id,price,rest_id) from 'menu.csv' with delimiter ',' csv header;
\copy "Order"(order_id, user_id,rest_id,driver_id) from 'order.csv' with delimiter ',' csv header;
\copy Order_Item(order_id,item_id,quantity) from 'order_item.csv' with delimiter ',' csv header;
\copy CardNumType(card_num,card_type) from 'cardnumtype.csv' with delimiter ',' csv header;
\copy Payment(payment_id,user_id) from 'payment.csv' with delimiter ',' csv header;
\copy CardPayId(card_num,payment_id) from 'cardpayid.csv' with delimiter ',' csv header;
\copy Drink(item_id,ice,type) from 'drink.csv' with delimiter ',' csv header;
\copy Food(item_id,type) from 'food.csv' with delimiter ',' csv header;
\copy StateZip(zip,state) from 'statezip.csv' with delimiter ',' csv header;
\copy Location(zip, location_id,user_id,street) from 'location.csv' with delimiter ',' csv header;
\copy Paypal(payment_id,account_num) from 'paypal.csv' with delimiter ',' csv header;
\copy Restaurant_Rating(user_id,rest_id,rating) from 'restaurant_rating.csv' with delimiter ',' csv header;