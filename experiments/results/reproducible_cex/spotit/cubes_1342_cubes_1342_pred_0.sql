-- Schema DDL
CREATE TABLE "PERSON" (
    "NAME" TEXT,
    "AGE" INT,
    "CITY" TEXT,
    "GENDER" TEXT,
    "JOB" TEXT,
    PRIMARY KEY ("NAME")
);
CREATE TABLE "PERSONFRIEND" (
    "FRIEND" TEXT,
    "NAME" TEXT,
    "YEAR" INT,
    FOREIGN KEY ("FRIEND") REFERENCES "PERSON"("NAME"),
    FOREIGN KEY ("NAME") REFERENCES "PERSON"("NAME")
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO PERSON VALUES (1, 30, 8, 9, 10);
INSERT INTO PERSON VALUES (0, 0, 11, 12, 13);
INSERT INTO PERSONFRIEND VALUES (1, 1, 0);
INSERT INTO PERSONFRIEND VALUES (1, 0, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT friend AS name FROM (SELECT LHS.name AS name, LHS.age AS age, LHS.city AS city, LHS.gender AS gender, LHS.job AS job, RHS.friend AS friend, RHS.year AS YEAR FROM (SELECT * FROM person WHERE (age < 40 AND age <= 30)) AS LHS INNER JOIN personfriend AS RHS ON (LHS.name = RHS.name)) ORDER BY name;

/*
Gold Result:
('1',)
('1',)
*/

-- Prediction Query
SELECT T1.name FROM Person AS T1 JOIN PersonFriend AS T2 ON T1.name = T2.name WHERE T2.friend IN (SELECT name FROM Person WHERE age > 40) EXCEPT SELECT T1.name FROM Person AS T1 JOIN PersonFriend AS T2 ON T1.name = T2.name WHERE T2.friend IN (SELECT name FROM Person WHERE age < 30);

/*
Prediction Result:
*/