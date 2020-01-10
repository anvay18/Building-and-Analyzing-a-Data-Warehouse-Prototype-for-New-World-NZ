set serveroutput on;

--Here I have created star-schema

DROP TABLE D_SUPPLIERS; 
DROP TABLE D_PRODUCTS;
DROP TABLE D_CUSTOMERS;
DROP TABLE W_FACTS;
DROP TABLE D_STORES;
DROP TABLE D_TIME;

--Table D_PRODUCTS
CREATE TABLE  D_PRODUCTS(
PRODUCT_ID VARCHAR2(6)NOT NULL, 
PRODUCT_NAME VARCHAR2(30)NOT NULL,
CONSTRAINT id_product PRIMARY KEY(PRODUCT_ID)ENABLE);
 
 
--Table D_SUPPLIERS
CREATE TABLE D_SUPPLIERS(
SUPPLIER_ID VARCHAR2(5)NOT NULL, 
SUPPLIER_NAME VARCHAR2(30)NOT NULL,
CONSTRAINT id_supplier PRIMARY KEY(SUPPLIER_ID)ENABLE);   
  
--Table D_CUSTOMERS     
CREATE TABLE D_CUSTOMERS(
CUSTOMER_ID VARCHAR2(4)NOT NULL, 
CUSTOMER_NAME VARCHAR2(30)NOT NULL,
CONSTRAINT id_customer PRIMARY KEY(CUSTOMER_ID)ENABLE); 

--Table D_STORES    
CREATE TABLE D_STORES(
STORE_ID VARCHAR2(4)NOT NULL,
STORE_NAME VARCHAR2(30)NOT NULL,
CONSTRAINT id_store PRIMARY KEY(STORE_ID)ENABLE);

--Table D_TIME
CREATE TABLE D_TIME(
TIME_ID VARCHAR2(8)NOT NULL,
CAL_DATE  DATE NOT NULL,
CAL_DAY VARCHAR2(9)NOT NULL,
CAL_MONTH VARCHAR2(9)NOT NULL,
CAL_QUARTER VARCHAR2(1)NOT NULL,
CAL_YEAR NUMBER(4,0)NOT NULL,
CONSTRAINT id_time1 PRIMARY KEY(TIME_ID)ENABLE);

--Table W_FACTS
CREATE TABLE W_FACTS(
TRANSCATION_ID NUMBER(8,0)NOT NULL,
CUSTOMER_ID VARCHAR2(5)NOT NULL,
PRODUCT_ID VARCHAR2(8)NOT NULL,
STORE_ID VARCHAR2(4)NOT NULL,
SUPPLIER_ID VARCHAR2(5)NOT NULL,
TIME_ID VARCHAR2(8)NOT NULL,
QUANTITY NUMBER(2,0)NOT NULL,
PRICE NUMBER(5,2)NOT NULL,
SALE NUMBER(6,2)NOT NULL,
CONSTRAINT "Tran_id" PRIMARY KEY(TRANSCATION_ID)ENABLE,
CONSTRAINT "Cust_id" FOREIGN KEY(CUSTOMER_ID) REFERENCES D_CUSTOMERS(CUSTOMER_ID) ENABLE,
CONSTRAINT "Prod_id" FOREIGN KEY(PRODUCT_ID) REFERENCES D_PRODUCTS(PRODUCT_ID)ENABLE,
CONSTRAINT "St_id" FOREIGN KEY(STORE_ID) REFERENCES D_STORES(STORE_ID)ENABLE,
CONSTRAINT "Supp_id" FOREIGN KEY(SUPPLIER_ID) REFERENCES D_SUPPLIERS(SUPPLIER_ID)ENABLE,
CONSTRAINT "Time_id" FOREIGN KEY(TIME_ID) REFERENCES D_TIME(TIME_ID)ENABLE);   

