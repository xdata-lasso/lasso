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
INSERT INTO ATOM VALUES (8, 13, 22);
INSERT INTO ATOM VALUES (9, 13, 23);
INSERT INTO BOND VALUES (11, 14, 20);
INSERT INTO BOND VALUES (12, 14, 21);
INSERT INTO CONNECTED VALUES (8, 9, 11);
INSERT INTO CONNECTED VALUES (9, 8, 11);
INSERT INTO MOLECULE VALUES (14, 8684987632690798013);
INSERT INTO MOLECULE VALUES (13, 15);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(single_bond_count) FROM (SELECT T3.molecule_id, COUNT(T1.bond_type) AS single_bond_count FROM bond AS T1 INNER JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id INNER JOIN molecule AS T3 ON T3.molecule_id = T2.molecule_id WHERE T1.bond_type = '-' AND T3.label = '+' GROUP BY T3.molecule_id) AS subquery;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT CAST(SUM(IIF(bond.bond_type = '-', 1, 0)) AS REAL) / COUNT(DISTINCT molecule.molecule_id) AS average_single_bonded_carcinogenic_molecules FROM molecule INNER JOIN bond ON molecule.molecule_id = bond.molecule_id WHERE molecule.label = '+';

/*
Prediction Result:
(None,)
*/