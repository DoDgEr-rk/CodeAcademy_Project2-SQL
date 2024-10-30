Let's get some fun with the DB. 
As fun as could be with accounting issues:

INVOICES  - unique reference, debtor reference, amount, type, due date, creation date
PAYMENTS - unique reference, payer reference, amount, received date, creation date
MATCHING - unique reference, invoice reference, payment reference, amount, matching date
INDIVIDUAL - unique reference, name, type (physical or not)
CONTACTS - unique reference, individual reference, type (GSM, EMAIL, ... ), contact, status (active or not) Each invoice has only one individual

One payment could have only one individual
One invoice could be matched to many payments
One payment could be matched to many invoices
Only one record could exists for the couple invoice-payment in the matching table.
One individual could be free of this to be debtor or payer
Individual could have many contact details 

SQL statements:
1. Create the structure and relations between the tables
2. List of all debtors which have open (not fully paid) invoices which are overdue
3. List all payers which have overpaid their debts
4. List of all debtors who doesn't have any active contact details
5. List all active contacts from type e-mail which are with length at least 15 symbols
6. List all invoices of individuals which don't have active contacts and due date is in the past
7. List moral individuals which have invoices created during APRIL and have contact "GSM"
8. List all good payers, try to find by yourself what it could mean

