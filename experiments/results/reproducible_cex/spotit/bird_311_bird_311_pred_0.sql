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
INSERT INTO ATOM VALUES (4, 6, 13);
INSERT INTO ATOM VALUES (8, 6, 9);
INSERT INTO BOND VALUES (2, 5, 14);
INSERT INTO BOND VALUES (3, 5, 15);
INSERT INTO CONNECTED VALUES (4, 4, 2);
INSERT INTO CONNECTED VALUES (4, 8, 2);
INSERT INTO MOLECULE VALUES (6, 7);
INSERT INTO MOLECULE VALUES (5, 25);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T1.molecule_id) FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element <> 's' AND T2.bond_type <> '=';

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT m.molecule_id) FROM molecule AS m LEFT JOIN atom AS a ON m.molecule_id = a.molecule_id LEFT JOIN connected AS c ON a.atom_id = c.atom_id LEFT JOIN bond AS b ON c.bond_id = b.bond_id WHERE a.element <> 's' AND b.bond_type <> ' = ';

/*
Prediction Result:
(1,)
*/