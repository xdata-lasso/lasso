-- Schema DDL
CREATE TABLE "MOLECULES" (
    "ID" INT,
    "NAME" TEXT,
    PRIMARY KEY ("ID")
);
CREATE TABLE "ATOMS" (
    "ID" INT,
    "MOLECULE_ID" INT,
    "ELEMENT" TEXT,
    PRIMARY KEY ("ID"),
    FOREIGN KEY ("MOLECULE_ID") REFERENCES "MOLECULES"("ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO MOLECULES VALUES (1, 10);
INSERT INTO MOLECULES VALUES (0, 11);
INSERT INTO ATOMS VALUES (1, 0, 942394183692979995);
INSERT INTO ATOMS VALUES (0, 0, 942394183692979995);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT m.id) FROM molecules AS m JOIN atoms AS a ON m.id = a.molecule_id WHERE a.element = 'Carbon';

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(a.id) FROM molecules AS m JOIN atoms AS a ON m.id = a.molecule_id WHERE a.element = 'Carbon';

/*
Prediction Result:
(0,)
*/