--2: List of all debtors which have open (not fully paid) invoices which are overdue
--CREATE VIEW View_2 AS
SELECT CL.Individual_ID, CL.First_name, CL.Last_name, CL.Company_name, INV.invoice_id, INV.Invoice_amount,
    SUM(M.Amount) AS Payed_Amount, INV.Due_date
FROM Invoice INV
INNER JOIN Individual CL
ON CL.Individual_ID = INV.Individual_ID
LEFT JOIN Matching M
ON INV.Invoice_ID = M.Invoice_ID
GROUP BY CL.Individual_ID, CL.First_name, CL.Last_name, CL.Company_name, INV.invoice_id, INV.Invoice_amount, INV.Due_date
HAVING INV.Invoice_amount > SUM(M.Amount) AND INV.Due_date < SYSDATE;

--DROP TABLE View_2;
SELECT * FROM View_2;

--3: List all payers which have overpaid their debts
--CREATE VIEW View_3 AS
SELECT CL.Individual_ID, CL.First_name, CL.Last_name, CL.Company_name,Inv.Invoice_amount, P.Payment_amount--, SUM(M.Amount) AS SUM_AMOUNT--, P.Payment_amount-SUM(M.Amount) AS Overpayed
FROM Individual CL
LEFT JOIN Payment P
ON CL.Individual_ID = P.Individual_ID
--INNER JOIN Matching M
--ON P.Payment_ID = M.Payment_ID
LEFT JOIN Invoice INV
ON INV.Individual_ID = P.Individual_ID
GROUP BY CL.Individual_ID, CL.First_name, CL.Last_name, CL.Company_name,Inv.Invoice_amount,  P.Payment_amount
HAVING P.Payment_amount > Inv.Invoice_amount
ORDER BY CL.Individual_ID;

--DROP VIEW View_3;
SELECT * FROM View_3;

--4: List of all debtors who doesn't have any active contact details
--CREATE VIEW View_4 AS
SELECT CL.Individual_ID, CL.First_name, CL.Last_name, CL.Company_name, CONT.Contact_status_ID, CONT.Contact_info
FROM Individual CL
INNER JOIN Invoice INV
ON CL.Individual_ID = INV.Individual_ID
INNER JOIN Contacts CONT
ON CL.Individual_ID = CONT.Individual_ID
WHERE INV.Individual_ID NOT IN (SELECT CL.Individual_ID
                                FROM Individual CL
                                INNER JOIN Contacts CONT
                                ON CONT.Individual_ID = CL.Individual_ID
                                WHERE CONT.Contact_status_ID LIKE 'Active')
GROUP BY CL.Individual_ID, CL.First_name, CL.Last_name, CL.Company_name, CONT.Contact_status_ID, CONT.Contact_info
ORDER BY 1;

--DROP VIEW View_4;
SELECT * FROM View_4;

--5: List all active contacts from type e-mail which are with length at least 15 symbols
--CREATE VIEW View_5 AS
SELECT CONT.contact_type_id, CONT.contact_status_id, CONT.contact_info, LENGTH(CONT.contact_info) AS LENGTH
FROM Contacts CONT
WHERE CONT.Contact_type_ID LIKE 'Mail' AND CONT.Contact_status_ID LIKE 'Active'
    AND LENGTH(CONT.contact_info) >= 15;
    
--DROP VIEW View_5;
SELECT * FROM View_5;

--6: List all invoices of individuals which don't have active contacts and due date is in the past
--CREATE VIEW View_6 AS
SELECT INV.Invoice_ID, INV.Invoice_Amount||' BGN' AS Amount, INV.Due_date, CL.Individual_ID, CL.First_name, CL.Last_name, CL.Company_name, 
    CONT.Contact_status_ID, CONT.Contact_type_ID, CONT.Contact_info
FROM Invoice INV
INNER JOIN Individual CL
ON CL.Individual_ID = INV.Individual_ID
INNER JOIN Contacts CONT
ON CL.Individual_ID = CONT.Individual_ID
WHERE INV.Due_date < SYSDATE AND INV.Individual_ID NOT IN (SELECT CL.Individual_ID
                                                            FROM Individual CL
                                                            INNER JOIN Contacts CONT
                                                            ON CONT.Individual_ID = CL.Individual_ID
                                                            WHERE CONT.Contact_status_ID LIKE 'Active')
GROUP BY  INV.Invoice_ID, INV.Invoice_Amount||' BGN', INV.Due_date, CL.Individual_ID, CL.First_name, CL.Last_name, CL.Company_name, 
    CONT.Contact_status_ID, CONT.Contact_type_ID, CONT.Contact_info
ORDER BY 1;

--DROP VIEW View_6;
SELECT * FROM View_6;

--7: List moral individuals which have invoices created during APRIL and have contact "GSM"
--CREATE VIEW View_7 AS
SELECT CL.Individual_ID, CL.Company_name AS Company, CL.First_name||' '||CL.Last_name AS Contact_name, CL.Individual_type_ID, INV.Invoice_ID, INV.Creation_date, 
    CONT.Contact_type_ID, CONT.Contact_info
FROM Individual CL
INNER JOIN Invoice INV
ON CL.Individual_ID = INV.Individual_ID
INNER JOIN Contacts CONT
ON CL.Individual_ID = CONT.Individual_ID
WHERE CL.Individual_type_ID LIKE 'Moral' AND UPPER(CONT.Contact_type_ID) LIKE UPPER('Mobile') AND 
    EXTRACT(MONTH FROM INV.Creation_date) = 4;
    
--Drop view View_7;
SELECT * FROM View_7;
/
--8: List all good payers
--CREATE VIEW View_8 AS


DROP VIEW View_Proba;
/
SELECT Ind.Individual_ID, Inv.Invoice_ID , Ind.First_Name
FROM Individual Ind
INNER JOIN Invoice Inv
ON Ind.Individual_ID = Inv.Individual_ID
--WHERE SYSDATE < Inv.Due_Date
GROUP BY Ind.Individual_ID, Inv.Invoice_ID, Ind.First_Name
ORDER BY Ind.Individual_ID;
/
--CREATE VIEW View_Proba AS
SELECT Ind.Individual_ID, M.Match_ID, Ind.First_Name, M.Amount, M.Match_Date
FROM Individual Ind
LEFT JOIN Invoice Inv
ON Ind.Individual_ID = Inv.Individual_ID
LEFT JOIN Matching M
ON Ind.Individual_ID = M.Invoice_ID
--WHERE SYSDATE < Inv.Due_Date
GROUP BY Ind.Individual_ID, M.Match_ID, Ind.First_Name, M.Amount, M.Match_Date
ORDER BY Ind.Individual_ID;
/
SELECT INV.Invoice_ID, INV.Invoice_amount, INV.Due_date, M.Payment_ID, P.Payment_amount, INV.Individual_ID, P.Individual_ID--, SUM(M.Amount)
from Invoice INV
LEFT JOIN Matching M
ON INV.Invoice_ID = M.Invoice_ID
lEFT JOIN Payment P
ON P.Payment_ID = M.Payment_ID;

GROUP BY CL.Individual_ID, CL.First_name, CL.Last_name, CL.Company_name, INV.Invoice_ID, INV.Invoice_amount, INV.Due_date;
--WHERE P.Received_date < INV.Due_date AND 

време на плащане:
селект INV.Invoice_amount = SUM(M.Amount) and P.Received_day < INV.Due_date,    --за Payed и Overpayed
селект SUM(M.Amount)= 0 and Sysdate < Invoice.Due_date    --за Not_payed и Partially_pаyed

SELECT CL.Individual_ID, CL.First_name, CL.Last_name, CL.Company_name, INV.Invoice_ID, INV.Invoice_amount, INV.Due_date, M.Amount--, P.Payment_ID, P.Payment_amount
FROM Individual CL
INNER JOIN Invoice INV
ON CL.Individual_ID = INV.Individual_ID
LEFT JOIN Matching M
ON INV.Invoice_ID = M.Invoice_ID;
Right join Payment P
On P.Payment_ID = M.Payment_ID;
WHERE

--Drop view View_8;
SELECT * FROM View_8;


select INV.Invoice_ID, INV.Invoice_amount, M.Amount
from Invoice INV
Left join Matching M
ON M.Invoice_ID = INV.Invoice_ID
order by 1;

where
/
SELECT CL.Individual_ID, INV.Invoice_ID, INV.Invoice_amount, SUM(M.Amount), INV.Due_date, P.Received_date
FROM Individual CL
INNER JOIN Invoice INV
ON CL.Individual_ID = INV.Individual_ID
LEFT JOIN Matching M
ON INV.Invoice_ID = M.Invoice_ID
LEFT JOIN Payment P
ON P.Payment_ID = M.Payment_ID
GROUP BY CL.Individual_ID, INV.Invoice_ID, INV.Invoice_amount, INV.Due_date, P.Received_date
HAVING (INV.Invoice_amount = SUM(M.Amount) AND P.Received_date <= INV.Due_date)
    OR (INV.Invoice_amount > NVL(SUM(M.Amount),0) AND SYSDATE < INV.Due_date)
ORDER BY CL.Individual_ID;
/
SELECT * FROM INVOICE
order by Individual_ID;
SELECT * FROM PAYMENT
order by Individual_ID;