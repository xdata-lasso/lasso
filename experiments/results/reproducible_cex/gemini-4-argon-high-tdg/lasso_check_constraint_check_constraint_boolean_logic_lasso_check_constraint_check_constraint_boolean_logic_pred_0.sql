-- Schema DDL
CREATE TABLE Contacts (id INTEGER PRIMARY KEY, email TEXT(50), phone TEXT(20), CHECK (NOT email IS NULL OR NOT phone IS NULL));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Contacts (id, email, phone) VALUES (1, 'test@example.com', '123-456-7890');
INSERT INTO Contacts (id, email, phone) VALUES (2, 'test@example.com', NULL);
INSERT INTO Contacts (id, email, phone) VALUES (3, 'a@example.com', '111-222-3333');
INSERT INTO Contacts (id, email, phone) VALUES (4, 'z@example.com', NULL);
INSERT INTO Contacts (id, email, phone) VALUES (5, NULL, '999-888-7777');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id FROM Contacts WHERE email = 'test@example.com';

/*
Gold Result:
(1,)
(2,)
*/

-- Prediction Query
SELECT id FROM Contacts WHERE email = 'other@example.com';

/*
Prediction Result:
*/