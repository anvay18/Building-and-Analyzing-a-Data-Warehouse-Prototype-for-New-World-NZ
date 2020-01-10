set serveroutput on size 10000;
DECLARE
  initial_1 NUMBER; initial_2 NUMBER;  initial_3 NUMBER;
 
  sl1 varchar2(6);  sl2 varchar2(4); sl3 varchar2(5);  sl4 varchar2(4);  sl5 varchar2(8); sl6 NUMBER(8,0);
 
  CURSOR ab (int1 NUMBER, int2 NUMBER) IS 
  SELECT *
  FROM Transactions WHERE transaction_id BETWEEN int1 AND int2;
  
  CURSOR cd (int3 NUMBER) IS 
  SELECT products.product_id, products.product_name, products.supplier_id, products.supplier_name, products.price, customers.customer_id, customers.customer_name, (quantity*price) as sales
  FROM TRANSACTIONS INNER JOIN PRODUCTS ON transactions.product_id = products.product_id 
  INNER JOIN CUSTOMERS ON transactions.customer_id = customers.customer_id 
  WHERE transactions.transaction_id = int3;    
  
  CURSOR ef (int4  VARCHAR2) IS
  SELECT product_id FROM D_PRODUCTS WHERE product_ID = int4;
  CURSOR kl (int7  VARCHAR2) IS
  SELECT store_id FROM D_STORES WHERE store_ID = int7;
  CURSOR gh (int5  VARCHAR2) IS
  SELECT customer_id FROM D_CUSTOMERS WHERE customer_ID = int5;  
  CURSOR mn (int8  varchar2) IS
  SELECT time_id FROM D_TIME WHERE time_id = int8;
  CURSOR ij (int6  VARCHAR2) IS
  SELECT supplier_id FROM D_SUPPLIERS WHERE supplier_ID = int6; 
  CURSOR op (int9  NUMBER) IS
  SELECT transaction_id FROM W_FACTS WHERE transaction_id = int9;
  
  Ttransaction_id transactions.transaction_id%TYPE;
  Pproduct_id products.product_id%type;
  Tcustomer_id transactions.customer_id%type;
  Ttime_id transactions.time_id%type;
  Tstore_id transactions.store_id%type;
  Tstore_name transactions.store_name%type;
  Tdate transactions.t_date%type;
  Tquantity transactions.quantity%type;
  Pproduct_name products.product_name%type;
  Psupplier_id products.supplier_id%type;
  Psupplier_name products.supplier_name%type;
  Pprice products.price%type;
  Ccustomer_name customers.customer_name%type;
  Tsale NUMBER(6,2);
  
BEGIN
  initial_1 := 1;
  initial_2 := 100;
  initial_3 := 1;
    FOR j IN 1..100
      LOOP    
        FOR i IN ab (initial_1,initial_2) 
          LOOP
            FOR k IN cd (initial_3)
              LOOP
               
                              Ttransaction_id := i.transaction_id;
                                   Pproduct_id := i.product_id;
                                  Tcustomer_id := i.customer_id;
                                  Ttime_id := i.time_id;
                                 Tstore_id := i.store_id;
                                 Tstore_name := i.store_name;
                                  Tdate := i.t_date;
                                  Tquantity := i.quantity;
                                  Pproduct_name := k.product_name;
                                  Psupplier_id := k.supplier_id;
                                 Psupplier_name := k.supplier_name;
                                  Pprice := k.price;
                                  Ccustomer_name := k.customer_name;
                                  Tsale := k.sales;
             
       OPEN ef(Pproduct_id);
      FETCH ef INTO sl1;  
      close ef;
      IF sl1 != Pproduct_id OR sl1 IS NULL THEN
      INSERT INTO D_PRODUCTS(product_id, product_name) VALUES (Pproduct_id,Pproduct_name);
COMMIT;
END IF;
                
       OPEN gh(Tcustomer_id);
       FETCH gh INTO sl2;  
       close gh;
      IF sl2 != Tcustomer_id OR sl2 IS NULL THEN
       INSERT INTO D_CUSTOMERS(customer_id,customer_name) VALUES(Tcustomer_id,Ccustomer_name);
COMMIT;
END IF;
                
       OPEN ij(Psupplier_id);
       FETCH ij INTO sl3;  
       close ij;
       IF sl3 != Psupplier_id OR sl3 IS NULL THEN
      INSERT INTO D_SUPPLIERS(supplier_id,supplier_name) VALUES(Psupplier_id, Psupplier_name);
COMMIT;
END IF;
                
       OPEN kl( Tstore_id);
       FETCH kl INTO sl4;  
       close kl;
       IF sl4 !=  Tstore_id OR sl4 IS NULL THEN
       INSERT INTO D_STORES(store_id,store_name) VALUES( Tstore_id,Tstore_name);
COMMIT;
END IF;
                
       OPEN mn(Ttime_id);
       FETCH mn INTO sl5;  
       close mn;
       IF sl5 != Ttime_id OR sl5 IS NULL THEN
      INSERT INTO 
      D_TIME(time_id,cal_date,cal_day,cal_month,cal_quarter,cal_year) VALUES(Ttime_id,tdate,to_char(tdate,'DAY'),to_char(tdate,'MONTH'),to_char(tdate,'Q'),to_char(tdate,'YYYY'));
COMMIT;
END IF;
                
      OPEN op(Ttransaction_id);
      FETCH op INTO sl6;  
      close op;
      IF sl6 != Ttransaction_id OR sl6 IS NULL THEN
      INSERT INTO 
      W_FACTS(transaction_id,customer_id,product_id,store_id,supplier_id,time_id,quantity,price,sale) VALUES(Ttransaction_id,Tcustomer_id,Pproduct_id,Tstore_id,Psupplier_id, Ttime_id,Tquantity,Pprice,Tsale);
 COMMIT;
END IF;
               
initial_3 := initial_3 + 1;
END LOOP;
END LOOP;
        
  initial_1 := initial_1 + 100;
  initial_2 :=initial_2 + 100;
END LOOP;
 
END;



