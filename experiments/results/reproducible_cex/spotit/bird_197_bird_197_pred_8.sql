-- Schema DDL
CREATE TABLE "ATOM" (
    "ATOM_ID" TEXT,
    "MOLECULE_ID" TEXT,
    "ELEMENT" TEXT,
    PRIMARY KEY ("ATOM_ID"),
    FOREIGN KEY ("MOLECULE_ID") REFERENCES "MOLECULE"("MOLECULE_ID")
);
CREATE TABLE "BOND" (
    "BOND_ID" TEXT,
    "MOLECULE_ID" TEXT,
    "BOND_TYPE" TEXT,
    PRIMARY KEY ("BOND_ID"),
    FOREIGN KEY ("MOLECULE_ID") REFERENCES "MOLECULE"("MOLECULE_ID")
);
CREATE TABLE "CONNECTED" (
    "ATOM_ID" TEXT,
    "ATOM_ID2" TEXT,
    "BOND_ID" TEXT,
    PRIMARY KEY ("ATOM_ID", "ATOM_ID2"),
    FOREIGN KEY ("ATOM_ID") REFERENCES "ATOM"("ATOM_ID"),
    FOREIGN KEY ("ATOM_ID2") REFERENCES "ATOM"("ATOM_ID"),
    FOREIGN KEY ("BOND_ID") REFERENCES "BOND"("BOND_ID")
);
CREATE TABLE "MOLECULE" (
    "MOLECULE_ID" TEXT,
    "LABEL" TEXT,
    PRIMARY KEY ("MOLECULE_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO ATOM VALUES (4, 7, 17);
INSERT INTO ATOM VALUES (6, 7, 18);
INSERT INTO BOND VALUES (5, 7, 994006540256129101);
INSERT INTO BOND VALUES (9, 8, 994006540256129101);
INSERT INTO CONNECTED VALUES (4, 6, 9);
INSERT INTO CONNECTED VALUES (4, 4, 5);
INSERT INTO MOLECULE VALUES (8, 0);
INSERT INTO MOLECULE VALUES (7, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(oxygen_count) FROM (SELECT T1.molecule_id, COUNT(T1.element) AS oxygen_count FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.bond_type = '-' AND T1.element = 'o' GROUP BY T1.molecule_id) AS oxygen_counts;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT AVG(CASE WHEN a.element = 'o' THEN 1 ELSE 0 END) AS average_oxygen_atoms FROM atom AS a JOIN connected AS c ON a.atom_id = c.atom_id JOIN bond AS b ON c.bond_id = b.bond_id WHERE b.bond_type = '-';

/*
Prediction Result:
(None,)
*/