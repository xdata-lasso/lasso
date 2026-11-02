-- Schema DDL
CREATE TABLE Contacts (id INTEGER PRIMARY KEY, email TEXT(50), phone TEXT(20), CHECK (NOT email IS NULL OR NOT phone IS NULL));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Contacts (id, email, phone) VALUES (1, 'test@example.com', '555-0100');
INSERT INTO Contacts (id, email, phone) VALUES (2, 'other@example.com', '555-0101');
INSERT INTO Contacts (id, email, phone) VALUES (3, NULL, '555-0102');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id FROM Contacts WHERE email = 'test@example.com';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT id FROM Contacts WHERE email = 'other@example.com';

/*
Prediction Result:
(2,)
*/