-- Schema DDL
CREATE TABLE "NATION" (
    "N_ID" INT,
    "N_NAME" TEXT,
    PRIMARY KEY ("N_ID")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO NATION VALUES (-1, 926859456926065540);
INSERT INTO NATION VALUES (0, 926859456926065540);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n1.n_name, n2.n_name FROM nation AS n1 CROSS JOIN nation AS n2 WHERE n1.n_name = 'FRANCE' AND n2.n_name = 'ARGENTINA';

/*
Gold Result:
*/

-- Prediction Query
SELECT n1.n_name, n2.n_name FROM nation AS n1 CROSS JOIN nation AS n2 WHERE n1.n_name = 'FRANCE' AND n2.n_name = 'FRANCE';

/*
Prediction Result:
*/