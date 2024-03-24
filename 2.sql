CREATE TABLE SALESMAN
(SALESMAN_ID NUMBER (4),
NAME VARCHAR2 (20),
CITY VARCHAR2 (20),
COMMISSION VARCHAR2 (20),
PRIMARY KEY (SALESMAN_ID));

CREATE TABLE CUSTOMER
(CUSTOMER_ID NUMBER (4),
CUST_NAME VARCHAR2 (20),
CITY VARCHAR2 (20),
GRADE NUMBER (3) NOT NULL CHECK(GRADE <= 10),
SALESMAN_ID NUMBER(4),
PRIMARY KEY (CUSTOMER_ID),
FOREIGN KEY (SALESMAN_ID) REFERENCES SALESMAN (SALESMAN_ID) ON DELETE CASCADE);

CREATE TABLE ORDERS
(ORD_NO NUMBER (5),
PURCHASE_AMT NUMBER (10, 2) NOT NULL,
ORD_DATE DATE NOT NULL,
SALESMAN_ID NUMBER (4),
CUSTOMER_ID NUMBER (4),
PRIMARY KEY (ORD_NO),
FOREIGN KEY (CUSTOMER_ID) REFERENCES CUSTOMER (CUSTOMER_ID) ON DELETE CASCADE,
FOREIGN KEY (SALESMAN_ID) REFERENCES SALESMAN (SALESMAN_ID) ON DELETE CASCADE);


INSERT INTO SALESMAN VALUES (1000, 'JOHN','BANGALORE','25 %');
INSERT INTO SALESMAN VALUES (2000, 'RAVI','BANGALORE','20 %');
INSERT INTO SALESMAN VALUES (3000, 'KUMAR','MYSORE','15 %');
INSERT INTO SALESMAN VALUES (4000, 'SMITH','DELHI','30 %');
INSERT INTO SALESMAN VALUES (5000, 'HARSHA','HYDRABAD','15 %');

INSERT INTO CUSTOMER VALUES (10, 'PREETHI','BANGALORE', 8.5, 4000);
INSERT INTO CUSTOMER VALUES (11, 'VIVEK','MANGALORE', 4.5, 1000);
INSERT INTO CUSTOMER VALUES (12, 'BHASKAR','CHENNAI', 7.5, 2000);
INSERT INTO CUSTOMER VALUES (13, 'CHETHAN','BANGALORE', 6, 2000);
INSERT INTO CUSTOMER VALUES (14, 'MAMATHA','BANGALORE', 2.4, 3000);

INSERT INTO ORDERS VALUES (50, 5000, '04-MAY-17', 1000, 10);
INSERT INTO ORDERS VALUES (51, 450, '20-JAN-17', 2000, 10);
INSERT INTO ORDERS VALUES (52, 1000, '24-FEB-17', 2000, 13);
INSERT INTO ORDERS VALUES (53, 3500, '13-APR-17', 3000, 14);
INSERT INTO ORDERS VALUES (54, 550, '09-MAR-17', 2000, 12);


SELECT COUNT (CUSTOMER_ID)
FROM CUSTOMER
WHERE GRADE > (SELECT AVG(GRADE)
		FROM CUSTOMER
		WHERE CITY='BANGALORE');

SELECT SALESMAN_ID, NAME
FROM SALESMAN A
WHERE (SELECT COUNT (*)
	FROM CUSTOMER C
	WHERE C.SALESMAN_ID=A.SALESMAN_ID) > 1;

SELECT SALESMAN.SALESMAN_ID, NAME, CUST_NAME, COMMISSION
FROM SALESMAN, CUSTOMER
WHERE SALESMAN.CITY = CUSTOMER.CITY
UNION
SELECT SALESMAN_ID, NAME, 'NO MATCH', COMMISSION
FROM SALESMAN
WHERE NOT SALESMAN.CITY IN (SELECT CUSTOMER.CITY FROM CUSTOMER)
ORDER by SALESMAN_ID;

CREATE VIEW HighestOrder
AS SELECT s.SALESMAN_ID, s.NAME, o.ORD_DATE, o.PURCHASE_AMT
FROM SALESMAN s, ORDERS o
WHERE (o.SALESMAN_ID = s.SALESMAN_ID) and 
	o.PURCHASE_AMT = (SELECT MAX (PURCHASE_AMT) FROM ORDERS);
						
SELECT * FROM HighestOrder;


DELETE FROM SALESMAN WHERE SALESMAN_ID=1000;

SELECT * FROM SALESMAN;

SELECT * FROM ORDERS;