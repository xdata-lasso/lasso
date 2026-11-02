-- Schema DDL
CREATE TABLE Contacts (id INTEGER PRIMARY KEY, email TEXT(50), phone TEXT(20), CHECK (NOT email IS NULL OR NOT phone IS NULL));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: contacts --
INSERT INTO "contacts" ("id", "email", "phone") VALUES (1, 'test@example.com', 'con_6f8976');

INSERT INTO "contacts" ("id", "email", "phone") VALUES (2, 'con_ed351f', 'con_6f8976');

INSERT INTO "contacts" ("id", "email", "phone") VALUES (3, NULL, 'con_6f8976');
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
*/