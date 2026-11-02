-- Schema DDL
CREATE TABLE "entrepreneur" ("Entrepreneur_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Company" TEXT, "Money_Requested" REAL, "Investor" TEXT, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Date_of_Birth" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO people (People_ID, Name, Height, Weight, Date_of_Birth) VALUES (1, 'John Doe', 180.0, 75.0, '1990-01-01');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT AVG(money_requested) OVER () AS avg_money_requested_ FROM entrepreneur ORDER BY avg_money_requested_;

/*
Gold Result:
*/

-- Prediction Query
SELECT AVG(Money_Requested) FROM entrepreneur;

/*
Prediction Result:
(None,)
*/