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
INSERT INTO ATOM VALUES (3, 7, 981284751058366166);
INSERT INTO ATOM VALUES (4, 8, NULL);
INSERT INTO BOND VALUES (5, 7, 0);
INSERT INTO BOND VALUES (6, 8, 0);
INSERT INTO CONNECTED VALUES (3, 3, 5);
INSERT INTO CONNECTED VALUES (4, 4, 6);
INSERT INTO MOLECULE VALUES (8, 1380862087252160199);
INSERT INTO MOLECULE VALUES (7, 1380862087252160199);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(DISTINCT CASE WHEN T1.element <> 'f' THEN T2.molecule_id ELSE NULL END) AS REAL) * 100 / COUNT(DISTINCT T2.molecule_id) FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T2.label = '+';

/*
Gold Result:
(None,)
*/

-- Prediction Query
WITH CarcinogenicMolecules AS (SELECT DISTINCT molecule_id FROM molecule WHERE label = '+'), MoleculesWithFluorine AS (SELECT DISTINCT molecule_id FROM atom WHERE element = 'f'), CarcinogenicMoleculesWithoutFluorine AS (SELECT cm.molecule_id FROM CarcinogenicMolecules AS cm LEFT JOIN MoleculesWithFluorine AS mf ON cm.molecule_id = mf.molecule_id WHERE mf.molecule_id IS NULL) SELECT (CAST(COUNT(*) AS REAL) * 100) / (SELECT COUNT(*) FROM CarcinogenicMolecules) AS percentage FROM CarcinogenicMoleculesWithoutFluorine;

/*
Prediction Result:
(None,)
*/