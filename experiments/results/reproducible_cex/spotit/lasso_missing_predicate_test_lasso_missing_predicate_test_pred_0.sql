-- Schema DDL
CREATE TABLE "SCHOOLS" (
    "ID" INT,
    "DOC" INT,
    "STATUSTYPE" TEXT,
    "COUNTY" TEXT,
    PRIMARY KEY ("ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO SCHOOLS VALUES (0, NULL, 463900477537936112, 812121566114515646);
INSERT INTO SCHOOLS VALUES (1, 0, 4, 812121566114515646);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(DOC) FROM schools WHERE StatusType = 'Merged' AND County = 'Orange';

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT SUM(DOC) FROM schools WHERE County = 'Orange';

/*
Prediction Result:
(None,)
*/