-- Schema DDL
CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Address" TEXT, "Num_of_staff" TEXT, "Score" REAL, "Open_Year" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Membership_card" TEXT, "Age" INTEGER, "Time_of_purchase" INTEGER, "Level_of_membership" INTEGER, "Address" TEXT);

CREATE TABLE "happy_hour" ("HH_ID" INTEGER, "Shop_ID" INTEGER, "Month" TEXT, "Num_of_shaff_in_charge" INTEGER, PRIMARY KEY ("HH_ID", "Shop_ID", "Month"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "happy_hour_member" ("HH_ID" INTEGER, "Member_ID" INTEGER, "Total_amount" REAL, PRIMARY KEY ("HH_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests NULL handling in Address:
-- 1. Kills COUNT(Address) vs COUNT(*) (NULL group should have count 2, not 0).
-- 2. Kills WHERE Address IS NOT NULL mutants.
-- 3. Tests NULLS LAST in secondary sort (Address NULL has count 2, tying with 'Alpha' and 'Beta', and must appear after them).
-- 4. Tests empty string '' vs NULL grouping.
INSERT INTO member (Member_ID, Name, Membership_card, Age, Time_of_purchase, Level_of_membership, Address) VALUES (1, 'M1', 'Card1', 20, 1, 1, NULL);
INSERT INTO member (Member_ID, Name, Membership_card, Age, Time_of_purchase, Level_of_membership, Address) VALUES (2, 'M2', 'Card2', 21, 2, 1, NULL);
INSERT INTO member (Member_ID, Name, Membership_card, Age, Time_of_purchase, Level_of_membership, Address) VALUES (3, 'M3', 'Card3', 22, 3, 2, 'Beta');
INSERT INTO member (Member_ID, Name, Membership_card, Age, Time_of_purchase, Level_of_membership, Address) VALUES (4, 'M4', 'Card4', 23, 4, 2, 'Beta');
INSERT INTO member (Member_ID, Name, Membership_card, Age, Time_of_purchase, Level_of_membership, Address) VALUES (5, 'M5', 'Card5', 24, 5, 3, 'Alpha');
INSERT INTO member (Member_ID, Name, Membership_card, Age, Time_of_purchase, Level_of_membership, Address) VALUES (6, 'M6', 'Card6', 25, 6, 3, 'Alpha');
INSERT INTO member (Member_ID, Name, Membership_card, Age, Time_of_purchase, Level_of_membership, Address) VALUES (7, 'M7', 'Card7', 26, 7, 1, '');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, address FROM (SELECT address, COUNT(*) AS n FROM member GROUP BY address) ORDER BY count___, address NULLS LAST;

/*
Gold Result:
(1, '')
(2, 'Alpha')
(2, 'Beta')
(2, None)
*/

-- Prediction Query
SELECT COUNT(*), address FROM member GROUP BY address;

/*
Prediction Result:
(2, None)
(1, '')
(2, 'Alpha')
(2, 'Beta')
*/