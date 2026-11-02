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
INSERT INTO ATOM VALUES (2, 5, 11);
INSERT INTO ATOM VALUES (3, 6, 2030660236280310965);
INSERT INTO BOND VALUES (7, 6, 8);
INSERT INTO BOND VALUES (4, 6, 2107187707987441574);
INSERT INTO CONNECTED VALUES (3, 3, 7);
INSERT INTO CONNECTED VALUES (3, 2, 7);
INSERT INTO MOLECULE VALUES (6, 10);
INSERT INTO MOLECULE VALUES (5, 12);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.molecule_id FROM atom AS T1 INNER JOIN bond AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 's' AND T2.bond_type = '=';

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT molecule.molecule_id FROM molecule JOIN atom ON molecule.molecule_id = atom.molecule_id JOIN connected ON atom.atom_id = connected.atom_id OR atom.atom_id = connected.atom_id2 JOIN bond ON connected.bond_id = bond.bond_id WHERE atom.element = 's' AND bond.bond_type = '=';

/*
Prediction Result:
*/