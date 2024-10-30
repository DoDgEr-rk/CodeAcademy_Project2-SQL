--DROP TABLE Individual;
--DROP TABLE individual_type;
--DROP TABLE Invoice;

CREATE TABLE Individual_type 
(
    Individual_type_ID VARCHAR2(45) NOT NULL PRIMARY KEY
);
/
INSERT INTO Individual_type VALUES ('Personal');
INSERT INTO Individual_type VALUES ('Moral');
/
CREATE TABLE Invoice_type 
(
    Invoice_type_ID VARCHAR2(20) NOT NULL PRIMARY KEY
);
/
INSERT INTO Invoice_type VALUES ('Interim');
INSERT INTO Invoice_type VALUES ('Recurring');
INSERT INTO Invoice_type VALUES ('Final');
INSERT INTO Invoice_type VALUES ('Collective');
INSERT INTO Invoice_type VALUES ('Credit');
INSERT INTO Invoice_type VALUES ('Debit');
/
CREATE TABLE Contact_status 
(
    Contact_status_ID VARCHAR2(10) NOT NULL PRIMARY KEY
);
/
INSERT INTO Contact_status VALUES ('Active');
INSERT INTO Contact_status VALUES ('Inactive');
/
CREATE TABLE Contact_type 
(
    Contact_type_ID VARCHAR2(20) NOT NULL PRIMARY KEY
);
/
INSERT INTO Contact_type VALUES ('Address');
INSERT INTO Contact_type VALUES ('Mail');
INSERT INTO Contact_type VALUES ('Fax');
INSERT INTO Contact_type VALUES ('Office phone');
INSERT INTO Contact_type VALUES ('Home phone');
INSERT INTO Contact_type VALUES ('Mobile');
/
CREATE TABLE Individual 
(
    Individual_ID INT NOT NULL PRIMARY KEY,
    First_Name VARCHAR2(20) NOT NULL,
    Last_Name VARCHAR2(20) NOT NULL,
    Company_Name VARCHAR2(50),
    Individual_Type_ID VARCHAR2(20) NOT NULL,
    FOREIGN KEY (Individual_Type_ID) REFERENCES Individual_Type(Individual_Type_ID)
);
--DROP TABLE Individual;
/
CREATE SEQUENCE Seq_Individual_ID;
--DROP SEQUENCE Seq_Individual_ID;
/
CREATE OR REPLACE TRIGGER Individual_ID_INSERT
BEFORE INSERT ON Individual
FOR EACH ROW
BEGIN
    SELECT Seq_Individual_ID.NEXTVAL
    INTO :NEW.Individual_ID
    FROM DUAL;
END;
/
INSERT INTO Individual VALUES (0, 'Maria', 'Asenova', 'DAHUA', 'Moral');
/
CREATE OR REPLACE PROCEDURE INSERT_Individual 
(
    FIRST_NAME VARCHAR, 
    LAST_NAME VARCHAR, 
    COMPANY_NAME VARCHAR, 
    I_TYPE VARCHAR
) 
AS
BEGIN 
    INSERT INTO Individual
    SELECT NULL, FIRST_NAME, LAST_NAME, COMPANY_NAME, IT.Individual_Type_ID 
    FROM Individual_type IT
    WHERE UPPER(IT.Individual_Type_ID) LIKE UPPER(I_TYPE);
END;
/
EXEC INSERT_Individual('Ivan', 'Dimitrov', ' ', 'P%');
EXEC INSERT_Individual('Milko', 'Ivanov', 'MILKA', 'M%');
EXEC INSERT_Individual('Jordan', 'Hristov', ' ', 'P%');
EXEC INSERT_Individual('Milena', 'Georgieva', ' ', 'P%');
EXEC INSERT_Individual('Zahari', 'Boqnov', ' ', 'P%');
EXEC INSERT_Individual('Emil', 'Kirilov', ' ', 'P%');
EXEC INSERT_Individual('Georgi', 'Simeonov', 'SIEMENS', 'M%');
EXEC INSERT_Individual('Petar', 'Petrov', ' ', 'P%');
EXEC INSERT_Individual('Ivan', 'Ivanov', ' ', 'P%');
EXEC INSERT_Individual('Georgi', 'Georgiev', 'GG', 'M%');
EXEC INSERT_Individual('Marina', 'Marinova', ' ', 'P%');
EXEC INSERT_Individual('Elena', 'Elenova', ' ', 'P%');
EXEC INSERT_Individual('Mihaela', 'Mihailova', 'MM', 'y%');
EXEC INSERT_Individual('Matea', 'Donova', 'Canon', 'M%');

/
CREATE TABLE Contacts
(
    Contact_ID INT NOT NULL PRIMARY KEY,
    Individual_ID INT NOT NULL,
    Contact_status_ID VARCHAR2(20) NOT NULL,
    Contact_type_ID VARCHAR2(20) NOT NULL,
    Contact_info VARCHAR2(300) NOT NULL,
    FOREIGN KEY (Individual_ID) REFERENCES Individual(Individual_ID),
    FOREIGN KEY (Contact_status_ID) REFERENCES Contact_status(Contact_status_ID),
    FOREIGN KEY (Contact_type_ID) REFERENCES Contact_type(Contact_type_ID)
);
--DROP TABLE Contacts;
/
CREATE SEQUENCE Seq_Contact_ID;
--DROP SEQUENCE Seq_Contact_ID;
/
CREATE OR REPLACE TRIGGER Contact_ID_INSERT
BEFORE INSERT ON Contacts
FOR EACH ROW
BEGIN
    SELECT Seq_Contact_ID.NEXTVAL
    INTO :NEW.Contact_ID
    FROM DUAL;
END;
/
INSERT INTO Contacts VALUES (0, 1, 'Active', 'Address', 'Bulgaria, Sofia, Center, Vasil Levski blv. 45');
/
CREATE OR REPLACE PROCEDURE INSERT_Contact 
(
    INDIVID INT, 
    C_STATUS VARCHAR,
    C_TYPE VARCHAR, 
    INFO VARCHAR
) 
AS
BEGIN 
    INSERT INTO Contacts
    SELECT NULL, I.Individual_ID, CS.Contact_status_ID, CT.Contact_type_ID, INFO
    FROM Individual I, Contact_status CS, Contact_type CT
    WHERE I.Individual_ID = INDIVID AND UPPER(CS.Contact_status_ID) LIKE UPPER(C_STATUS) AND UPPER(CT.Contact_type_ID) LIKE UPPER(C_TYPE);
END;
/
EXEC INSERT_Contact (1, 'Active', 'Mobile', '0888000001');
EXEC INSERT_Contact (1, 'Inactive', 'Mobile', '0888000002');
EXEC INSERT_Contact (2, 'Active', 'Address', 'Bulgaria, Plovdiv, Kapana, Ivan Vazov str. 12');
EXEC INSERT_Contact (2, 'Active', 'Mobile', '0888000003');
EXEC INSERT_Contact (3, 'Inactive', 'Mail', 'user3@yahoo.com');
EXEC INSERT_Contact (4, 'Active', 'Mobile', '0898123123');
EXEC INSERT_Contact (5, 'Active', 'Mobile', '0898000000');
EXEC INSERT_Contact (6, 'Inactive', 'Mail', 'long_string_user6@yahoo.com');
EXEC INSERT_Contact (6, 'Inactive', 'Mobile', '0888000005');
EXEC INSERT_Contact (7, 'Active', 'Mobile', '0888000006');
EXEC INSERT_Contact (7, 'Active', 'Home phone', '029584758');
EXEC INSERT_Contact (7, 'Inactive', 'Address', 'England, London, 90-92 Blackfriars Rd');
EXEC INSERT_Contact (8, 'Active', 'Mobile', '0888000007');
EXEC INSERT_Contact (8, 'Inactive', 'Address', 'Bulgaria,Varna, Izgrev  str. 187');
EXEC INSERT_Contact (9, 'Active', 'Mail', 'new_mail_user9@yahoo.com');
EXEC INSERT_Contact (10, 'Active', 'Address', 'Germany,  Berlin, Grunerstrase 20');
EXEC INSERT_Contact (11, 'Active', 'Mail', 'new_mail_user11@yahoo.com');
EXEC INSERT_Contact (12, 'Active', 'Mobile', '0888000008');
EXEC INSERT_Contact (12, 'Inactive', 'Home phone', '029531456');
EXEC INSERT_Contact (13, 'Active', 'Mobile', '0888000009');
EXEC INSERT_Contact (13, 'Inactive', 'Mail', 'old_mail_user14@yahoo.com');
EXEC INSERT_Contact (13, 'Inactive', 'Mail', 'old_mail_user14@gmail.com');
EXEC INSERT_Contact (14, 'Inactive', 'Mail', 'long_string_user14@yahoo.com');
EXEC INSERT_Contact (15, 'Active', 'Mobile', '0888586214');

/
CREATE TABLE Payment 
(
    Payment_ID INT NOT NULL PRIMARY KEY,
    Individual_ID INT NOT NULL,
    Payment_amount NUMBER(10,2) NOT NULL,
    Received_date DATE NOT NULL,
    Creation_date DATE NOT NULL,
    FOREIGN KEY (Individual_ID) REFERENCES Individual(Individual_ID)
);
--DROP TABLE PAYMENT;
/
CREATE SEQUENCE Seq_Payment_ID;
--DROP SEQUENCE Seq_Payment_ID;
/
CREATE OR REPLACE TRIGGER Payment_ID_INSERT
BEFORE INSERT ON Payment
FOR EACH ROW
BEGIN
    SELECT Seq_Payment_ID.NEXTVAL
    INTO :NEW.Payment_ID
    FROM DUAL;
END;
/
INSERT INTO Payment VALUES (0, 2, 3000, '10-01-2023', SYSDATE);
/
CREATE OR REPLACE PROCEDURE INSERT_Payment 
(
    INDIVID INT, 
    AMOUNT VARCHAR, 
    RECEIVED_DATE DATE
) 
AS
BEGIN 
    INSERT INTO Payment
    SELECT NULL, IND.Individual_ID, AMOUNT, RECEIVED_DATE, SYSDATE 
    FROM Individual IND
    WHERE IND.Individual_ID = INDIVID;
END;
/
EXEC INSERT_Payment(3, 65000, '15-01-2023');
EXEC INSERT_Payment(5, 300, '28-01-2023');
EXEC INSERT_Payment(5, 300, '29-01-2023');
EXEC INSERT_Payment(7, 140.55, '30-01-2023');
EXEC INSERT_Payment(3, 600, '30-01-2023');
EXEC INSERT_Payment(3, 600, '02-02-2023');
EXEC INSERT_Payment(1, 1200, '01-02-2023');
EXEC INSERT_Payment(4, 1000, '2-2-2023');
EXEC INSERT_Payment(2, 1200, '14-2-2023');
EXEC INSERT_Payment(9, 300, '17-2-2023');
EXEC INSERT_Payment(11, 780, '25-3-2023');
EXEC INSERT_Payment(6, 700, '25-3-2023');
EXEC INSERT_Payment(14, 800, '25-3-2023');
EXEC INSERT_Payment(10, 1000, '10-01-2023');
/
CREATE TABLE Invoice
(
    Invoice_ID INT NOT NULL PRIMARY KEY,
    Individual_ID INT NOT NULL,
    Invoice_amount NUMBER(10,2) NOT NULL,
    Invoice_type_ID VARCHAR2(20) NOT NULL,
    Due_date DATE NOT NULL,
    Creation_date DATE NOT NULL,
    FOREIGN KEY (Individual_ID) REFERENCES Individual(Individual_ID),
    FOREIGN KEY (Invoice_type_ID) REFERENCES Invoice_type(Invoice_type_ID)
);
--DROP TABLE Invoice;
/
CREATE SEQUENCE Seq_Invoice_ID;
--DROP SEQUENCE Seq_Invoice_ID;
/
CREATE OR REPLACE TRIGGER Invoice_ID_INSERT
BEFORE INSERT ON Invoice
FOR EACH ROW
BEGIN
    SELECT Seq_Invoice_ID.NEXTVAL
    INTO :NEW.Invoice_ID
    FROM DUAL;
END;
/
INSERT INTO Invoice VALUES (0, 2, 1200, 'Recurring', '14-01-2023', SYSDATE);
/
CREATE OR REPLACE PROCEDURE INSERT_Invoice 
(
    INDIVID INT, 
    AMOUNT VARCHAR, 
    I_TYPE VARCHAR,
    DUE_DATE DATE, 
    CREATE_DATE DATE
) 
AS
BEGIN 
    INSERT INTO Invoice
    SELECT NULL, I.Individual_ID, AMOUNT, INT.Invoice_type_ID, DUE_DATE, CREATE_DATE 
    FROM Individual I, Invoice_type INT
    WHERE I.Individual_ID = INDIVID AND UPPER(INT.Invoice_type_ID) LIKE UPPER(I_TYPE);
END;
/
EXEC INSERT_Invoice(2, 1400, 'Final', '17-1-2023', SYSDATE);
EXEC INSERT_Invoice(3, 65000, 'Interim', '22-1-2023', SYSDATE);
EXEC INSERT_Invoice(5, 750.5, 'Recurring', '28-1-2023', SYSDATE);
EXEC INSERT_Invoice(7, 140.55, 'Final', '30-1-2023', SYSDATE);
EXEC INSERT_Invoice(8, 1200.25, 'Final', '1-2-2023', SYSDATE);
EXEC INSERT_Invoice(3, 1200, 'Final', '2-2-2023', SYSDATE);
EXEC INSERT_Invoice(1, 1110, 'Final', '3-2-2023', SYSDATE);
EXEC INSERT_Invoice(4, 2233, 'Final', '2-2-2023', SYSDATE);
EXEC INSERT_Invoice(2, 1200, 'Recurring', '14-2-2023', SYSDATE);
EXEC INSERT_Invoice(5, 750.5, 'Recurring', '28-2-2023', SYSDATE);
EXEC INSERT_Invoice(9, 500, 'Final', '23-3-2023', SYSDATE);
EXEC INSERT_Invoice(11, 780, 'Final', '25-3-2023', SYSDATE);
EXEC INSERT_Invoice(2, 1200, 'Recurring', '14-3-2023', SYSDATE);
EXEC INSERT_Invoice(5, 750.5, 'Recurring', '28-3-2023', SYSDATE);
EXEC INSERT_Invoice(6, 666, 'Final', '8-4-2023', SYSDATE);
EXEC INSERT_Invoice(14, 789, 'Final', '10-4-2023', SYSDATE);
EXEC INSERT_Invoice(2, 1200, 'Recurring', '14-4-2023', SYSDATE);
EXEC INSERT_Invoice(13, 65000, 'Final', '12-4-2023', SYSDATE);
EXEC INSERT_Invoice(5, 750.5, 'Recurring', '28-4-2023', SYSDATE);
EXEC INSERT_Invoice(15, 120, 'Final', '14-1-2023', SYSDATE);

/
CREATE TABLE Matching
(
    Match_ID INT NOT NULL PRIMARY KEY,
    Payment_ID INT NOT NULL,
    Invoice_ID INT NOT NULL,
    Amount NUMBER(10,2) NOT NULL,
    Match_date DATE NOT NULL,
    FOREIGN KEY (Payment_ID) REFERENCES Payment(Payment_ID),
    FOREIGN KEY (Invoice_ID) REFERENCES Invoice(Invoice_ID)
);
--DROP TABLE Matching;
/
CREATE SEQUENCE Seq_Match_ID;
--DROP SEQUENCE Seq_Match_ID;
/
CREATE OR REPLACE TRIGGER Match_ID_INSERT
BEFORE INSERT ON Matching
FOR EACH ROW
BEGIN
    SELECT Seq_Match_ID.NEXTVAL
    INTO :NEW.Match_ID
    FROM DUAL;
END;
/
INSERT INTO Matching VALUES (0, 1, 1, 1200, SYSDATE);
/
CREATE OR REPLACE FUNCTION func_min(var1 IN NUMBER, var2 IN NUMBER)
RETURN NUMBER
AS
    varMin NUMBER:=0.00;
BEGIN
    IF var1 <= var2 THEN 
        varMin:= var1;
    ELSE 
        varMin:= var2;
    END IF;
    RETURN varMin;
END;
/
CREATE OR REPLACE PROCEDURE INSERT_Matching
(
    PAYMENT INT, 
    INVOICE INT
) 
AS
VAR1 NUMBER:= 0;
VAR2 NUMBER:= 0; 
BEGIN 
    SELECT  (SELECT P.Payment_amount-NVL(SUM(M.Amount),0) AS Amount_balance
                FROM Payment P
                LEFT JOIN Matching M   
                ON P.Payment_ID = M.Payment_ID
                LEFT JOIN Invoice INV
                ON INV.Invoice_ID = M.Invoice_ID
                WHERE P.Payment_ID = PAYMENT
                GROUP BY P.Payment_ID, P.Payment_amount)
    INTO VAR1 FROM DUAL;     
    SELECT (SELECT INV.Invoice_amount-NVL(SUM(M.Amount), 0) AS Amount_balance
                FROM Invoice INV
                LEFT JOIN Matching M
                ON INV.Invoice_ID = M.Invoice_ID
                WHERE inV.Invoice_ID = INVOICE
                GROUP BY INV.Invoice_ID, INV.Invoice_amount)
    INTO VAR2 FROM DUAL;
    INSERT INTO Matching
    SELECT NULL, P.Payment_ID, INV.Invoice_ID, func_min(VAR1, VAR2), SYSDATE 
    FROM Invoice INV, Payment P
    WHERE P.Payment_ID = PAYMENT AND INV.Invoice_ID =  INVOICE;
END;
/
EXEC INSERT_Matching(1, 2);
EXEC INSERT_Matching(2, 3);
EXEC INSERT_Matching(4, 4);
EXEC INSERT_Matching(5, 5);
EXEC INSERT_Matching(6, 7);
EXEC INSERT_Matching(7, 7);
EXEC INSERT_Matching(8, 8);
EXEC INSERT_Matching(9, 9);
EXEC INSERT_Matching(10, 10);
EXEC INSERT_Matching(11, 12);
EXEC INSERT_Matching(12, 13);
EXEC INSERT_Matching(13, 16);
EXEC INSERT_Matching(14, 17);
/