CREATE TABLE Individual_Type (
Individual_type_ID INT NOT NULL PRIMARY KEY,
Individual_type VARCHAR2(45) NOT NULL
);
/
INSERT INTO Individual_type VALUES (1, 'Person');
INSERT INTO Individual_type VALUES (2, 'Company');
CREATE TABLE Individual (
Individual_ID INT NOT NULL PRIMARY KEY,
First_Name VARCHAR2(20) NOT NULL,
Last_Name VARCHAR2(20) NOT NULL,
Company_Name VARCHAR2(50),
Individual_Type_ID NUMBER NOT NULL,
FOREIGN KEY (Individual_Type_ID)
    REFERENCES Individual_Type (Individual_Type_ID)
);
INSERT INTO Individual VALUES(1, 'Ivan', 'Dimitrov', 'Hitachi', 1);
INSERT INTO Individual VALUES(2, 'Петър', 'Георгиев', 'Аз, Брато и аверите ООД', 2);

SELECT I.Individual_ID, I.First_Name, I.Last_Name, I.Company_Name, IT.Individual_type
FROM individual I
INNER JOIN Individual_Type IT ON I.Individual_type_ID = IT.Individual_type_ID;
/
UPDATE individual_type
SET Individual_type = 'Proba'
WHERE Individual_type = 'Person';
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
BEGIN
    INSERT INTO Matching
    SELECT NULL, P.Payment_ID, INV.Invoice_ID, func_min( SELECT  P.Payment_amount-SUM(M.Amount) AS Amount_balance
                                                        FROM Payment P
                                                        INNER JOIN Matching M
                                                        ON P.Payment_ID = M.Payment_ID
                                                        LEFT JOIN Invoice INV
                                                        ON INV.Invoice_ID = M.Invoice_ID
                                                        GROUP BY P.Payment_ID
                                                        HAVING P.Payment_ID = PAYMENT);
                                                        
FROM Invoice INV, Payment P
WHERE P.Payment_ID = PAYMENT AND INV.Invoice_ID =  INVOICE;
END;