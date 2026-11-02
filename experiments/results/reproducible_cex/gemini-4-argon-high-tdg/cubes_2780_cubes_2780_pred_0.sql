-- Schema DDL
CREATE TABLE "entrepreneur" ("Entrepreneur_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Company" TEXT, "Money_Requested" REAL, "Investor" TEXT, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Date_of_Birth" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO people (People_ID, Name, Height, Weight, Date_of_Birth) VALUES (1, 'Alice Smith', 165.0, 60.0, '1985-04-12');
INSERT INTO people (People_ID, Name, Height, Weight, Date_of_Birth) VALUES (2, 'Bob Jones', 180.0, 82.5, '1979-11-23');
INSERT INTO people (People_ID, Name, Height, Weight, Date_of_Birth) VALUES (3, 'Charlie Day', 172.0, 70.0, '1990-01-05');
INSERT INTO people (People_ID, Name, Height, Weight, Date_of_Birth) VALUES (4, 'Diana Prince', 175.0, 65.0, '1988-07-19');
INSERT INTO entrepreneur (Entrepreneur_ID, People_ID, Company, Money_Requested, Investor) VALUES (1, 4, 'ZetaTech', 500000.0, 'Sequoia');
INSERT INTO entrepreneur (Entrepreneur_ID, People_ID, Company, Money_Requested, Investor) VALUES (2, 3, 'BetaWorks', 300000.0, 'Zoe Angels');
INSERT INTO entrepreneur (Entrepreneur_ID, People_ID, Company, Money_Requested, Investor) VALUES (10, 1, 'BetaWorks', 100000.0, 'Alpha Ventures');
INSERT INTO entrepreneur (Entrepreneur_ID, People_ID, Company, Money_Requested, Investor) VALUES (5, 2, 'AlphaCorp', 250000.0, 'Horizon');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT company, investor FROM entrepreneur ORDER BY company, entrepreneur.entrepreneur_id NULLS LAST;

/*
Gold Result:
('AlphaCorp', 'Horizon')
('BetaWorks', 'Zoe Angels')
('BetaWorks', 'Alpha Ventures')
('ZetaTech', 'Sequoia')
*/

-- Prediction Query
SELECT Company, Investor FROM entrepreneur;

/*
Prediction Result:
('ZetaTech', 'Sequoia')
('BetaWorks', 'Zoe Angels')
('AlphaCorp', 'Horizon')
('BetaWorks', 'Alpha Ventures')
*/