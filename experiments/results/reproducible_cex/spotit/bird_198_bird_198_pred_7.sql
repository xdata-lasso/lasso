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
INSERT INTO ATOM VALUES (14, 12, 15);
INSERT INTO ATOM VALUES (16, 12, 17);
INSERT INTO BOND VALUES (8, 13, 1466606607550866037);
INSERT INTO BOND VALUES (9, 13, 1466606607550866037);
INSERT INTO CONNECTED VALUES (16, 16, 9);
INSERT INTO CONNECTED VALUES (16, 14, 8);
INSERT INTO MOLECULE VALUES (12, 6258538508038456766);
INSERT INTO MOLECULE VALUES (13, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(single_bond_count) FROM (SELECT T3.molecule_id, COUNT(T1.bond_type) AS single_bond_count FROM bond AS T1 INNER JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id INNER JOIN molecule AS T3 ON T3.molecule_id = T2.molecule_id WHERE T1.bond_type = '-' AND T3.label = '+' GROUP BY T3.molecule_id) AS subquery;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT CAST(COUNT(CASE WHEN B.bond_type = '-' THEN A.atom_id ELSE NULL END) AS REAL) / COUNT(A.atom_id) AS avg_single_bonded_atoms FROM molecule AS M INNER JOIN atom AS A ON M.molecule_id = A.molecule_id INNER JOIN connected AS C ON A.atom_id = C.atom_id OR A.atom_id = C.atom_id2 INNER JOIN bond AS B ON C.bond_id = B.bond_id WHERE M.label = '+';

/*
Prediction Result:
(None,)
*/