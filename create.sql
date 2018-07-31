-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2017-12-09 17:23:12.282
\c grubhub;

DROP TABLE IF EXISTS CardNumType cascade;
DROP TABLE IF EXISTS CardPayId cascade;
DROP TABLE IF EXISTS Drink cascade;
DROP TABLE IF EXISTS Driver cascade;
DROP TABLE IF EXISTS Food cascade;
DROP TABLE IF EXISTS Location cascade;
DROP TABLE IF EXISTS Menu cascade;
DROP TABLE IF EXISTS "Order" cascade;
DROP TABLE IF EXISTS Order_Item cascade;
DROP TABLE IF EXISTS Payment cascade;
DROP TABLE IF EXISTS Paypal cascade;
DROP TABLE IF EXISTS Restaurant cascade;
DROP TABLE IF EXISTS Restaurant_Rating cascade;
DROP TABLE IF EXISTS StateZip cascade;
DROP TABLE IF EXISTS "User" cascade;

-- tables
-- Table: CardNumType
CREATE TABLE CardNumType (
    card_num int  NOT NULL,
    card_type text  NOT NULL,
    CONSTRAINT CardNumType_pk PRIMARY KEY (card_num)
);

-- Table: CardPayId
CREATE TABLE CardPayId (
    card_num int  NOT NULL,
    payment_id int  NOT NULL,
    CONSTRAINT CardPayId_pk PRIMARY KEY (payment_id)
);

-- Table: Drink
CREATE TABLE Drink (
    item_id int  NOT NULL,
    ice boolean  NOT NULL,
    type text  NOT NULL,
    CONSTRAINT Drink_pk PRIMARY KEY (item_id)
);

-- Table: Driver
CREATE TABLE Driver (
    driver_id int  NOT NULL,
    name text  NOT NULL,
    car_plate text  NOT NULL,
    phone_number text  NOT NULL,
    CONSTRAINT Driver_pk PRIMARY KEY (driver_id)
);

-- Table: Food
CREATE TABLE Food (
    item_id int  NOT NULL,
    type text  NOT NULL,
    CONSTRAINT Food_pk PRIMARY KEY (item_id)
);

-- Table: Location
CREATE TABLE Location (
    zip int  NOT NULL,
    location_id int  NOT NULL,
    user_id int  NOT NULL,
    street text  NOT NULL,
    CONSTRAINT Location_pk PRIMARY KEY (location_id,user_id)
);

-- Table: Menu
CREATE TABLE Menu (
    item_id int  NOT NULL,
    price int  NOT NULL,
    rest_id int NOT NULL,
    CONSTRAINT Menu_pk PRIMARY KEY (item_id)
);

-- Table: "Order"
CREATE TABLE "Order" (
    order_id int  NOT NULL,
    user_id int  NOT NULL,
    rest_id int  NOT NULL,
    driver_id int  NOT NULL,
    CONSTRAINT Order_pk PRIMARY KEY (order_id)
);

-- Table: Order_Item
CREATE TABLE Order_Item (
    order_id int  NOT NULL,
    item_id int  NOT NULL,
    quantity int  NOT NULL,
    CONSTRAINT Order_Item_pk PRIMARY KEY (order_id,item_id)
);

-- Table: Payment
CREATE TABLE Payment (
    payment_id int  NOT NULL,
    user_id int  NOT NULL,
    CONSTRAINT Payment_pk PRIMARY KEY (payment_id)
);

-- Table: Paypal
CREATE TABLE Paypal (
    payment_id int  NOT NULL,
    account_num int  NOT NULL,
    CONSTRAINT Paypal_pk PRIMARY KEY (payment_id)
);

-- Table: Restaurant
CREATE TABLE Restaurant (
    rest_id int  NOT NULL,
    phone_number text  NOT NULL,
    location text  NOT NULL,
    name text  NOT NULL,
    CONSTRAINT Restaurant_pk PRIMARY KEY (rest_id)
);

-- Table: Restaurant_Rating
CREATE TABLE Restaurant_Rating (
    user_id int  NOT NULL,
    rest_id int  NOT NULL,
    rating decimal(2,1)  NOT NULL,
    CONSTRAINT Restaurant_Rating_pk PRIMARY KEY (user_id,rest_id)
);

-- Table: StateZip
CREATE TABLE StateZip (
    zip int  NOT NULL,
    state text  NOT NULL,
    CONSTRAINT StateZip_pk PRIMARY KEY (zip)
);

-- Table: "User"
CREATE TABLE "User" (
    user_id int  NOT NULL,
    name text  NOT NULL,
    phone_number text  NOT NULL,
    payment_id int  NOT NULL,
    email text  NOT NULL,
    CONSTRAINT User_pk PRIMARY KEY (user_id)
);

-- foreign keys
-- Reference: CardPayId_CardNumType (table: CardPayId)
ALTER TABLE CardPayId ADD CONSTRAINT CardPayId_CardNumType
    FOREIGN KEY (card_num)
    REFERENCES CardNumType (card_num)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: CardPayId_Payment (table: CardPayId)
ALTER TABLE CardPayId ADD CONSTRAINT CardPayId_Payment
    FOREIGN KEY (payment_id)
    REFERENCES Payment (payment_id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Drink_Menu (table: Drink)
ALTER TABLE Drink ADD CONSTRAINT Drink_Menu
    FOREIGN KEY (item_id)
    REFERENCES Menu (item_id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Food_Menu (table: Food)
ALTER TABLE Food ADD CONSTRAINT Food_Menu
    FOREIGN KEY (item_id)
    REFERENCES Menu (item_id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Loaction_User (table: Location)
ALTER TABLE Location ADD CONSTRAINT Location_User
    FOREIGN KEY (user_id)
    REFERENCES "User" (user_id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Location_StateZip (table: Location)
ALTER TABLE Location ADD CONSTRAINT Location_StateZip
    FOREIGN KEY (zip)
    REFERENCES StateZip (zip)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Order_Driver (table: "Order")
ALTER TABLE "Order" ADD CONSTRAINT Order_Driver
    FOREIGN KEY (driver_id)
    REFERENCES Driver (driver_id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Order_Item_Menu (table: Order_Item)
ALTER TABLE Order_Item ADD CONSTRAINT Order_Item_Menu
    FOREIGN KEY (item_id)
    REFERENCES Menu (item_id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Order_Item_Order (table: Order_Item)
ALTER TABLE Order_Item ADD CONSTRAINT Order_Item_Order
    FOREIGN KEY (order_id)
    REFERENCES "Order" (order_id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Order_Restaurant (table: "Order")
ALTER TABLE "Order" ADD CONSTRAINT Order_Restaurant
    FOREIGN KEY (rest_id)
    REFERENCES Restaurant (rest_id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Order_User (table: "Order")
ALTER TABLE "Order" ADD CONSTRAINT Order_User
    FOREIGN KEY (user_id)
    REFERENCES "User" (user_id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Payment_User (table: Payment)
ALTER TABLE Payment ADD CONSTRAINT Payment_User
    FOREIGN KEY (user_id)
    REFERENCES "User" (user_id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Paypal_Payment (table: Paypal)
ALTER TABLE Paypal ADD CONSTRAINT Paypal_Payment
    FOREIGN KEY (payment_id)
    REFERENCES Payment (payment_id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Restaurant_Rating_Restaurant (table: Restaurant_Rating)
ALTER TABLE Restaurant_Rating ADD CONSTRAINT Restaurant_Rating_Restaurant
    FOREIGN KEY (rest_id)
    REFERENCES Restaurant (rest_id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- Reference: Restaurant_Rating_User (table: Restaurant_Rating)
ALTER TABLE Restaurant_Rating ADD CONSTRAINT Restaurant_Rating_User
    FOREIGN KEY (user_id)
    REFERENCES "User" (user_id)  
    NOT DEFERRABLE 
    INITIALLY IMMEDIATE
;

-- End of file.

