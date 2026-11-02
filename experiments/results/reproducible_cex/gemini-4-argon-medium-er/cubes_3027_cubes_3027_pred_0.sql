-- Schema DDL
CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Address" TEXT, "Num_of_staff" TEXT, "Score" REAL, "Open_Year" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Membership_card" TEXT, "Age" INTEGER, "Time_of_purchase" INTEGER, "Level_of_membership" INTEGER, "Address" TEXT);

CREATE TABLE "happy_hour" ("HH_ID" INTEGER, "Shop_ID" INTEGER, "Month" TEXT, "Num_of_shaff_in_charge" INTEGER, PRIMARY KEY ("HH_ID", "Shop_ID", "Month"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "happy_hour_member" ("HH_ID" INTEGER, "Member_ID" INTEGER, "Total_amount" REAL, PRIMARY KEY ("HH_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO member (Member_ID, Name, Membership_card, Age, Time_of_purchase, Level_of_membership, Address) VALUES (1, 'Alice', 'Gold', 25, 1, 1, 'Addr1');
INSERT INTO member (Member_ID, Name, Membership_card, Age, Time_of_purchase, Level_of_membership, Address) VALUES (2, 'Bob', 'Gold', 30, 1, 1, 'Addr2');
INSERT INTO member (Member_ID, Name, Membership_card, Age, Time_of_purchase, Level_of_membership, Address) VALUES (3, 'Charlie', 'Gold', 35, 1, 1, 'Addr3');
INSERT INTO member (Member_ID, Name, Membership_card, Age, Time_of_purchase, Level_of_membership, Address) VALUES (4, 'David', 'Gold', 40, 1, 1, 'Addr4');
INSERT INTO member (Member_ID, Name, Membership_card, Age, Time_of_purchase, Level_of_membership, Address) VALUES (5, 'Eve', 'Gold', 45, 1, 1, 'Addr5');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT membership_card FROM (SELECT membership_card, COUNT(*) AS n FROM member GROUP BY membership_card) WHERE (n >= 5) ORDER BY membership_card;

/*
Gold Result:
('Gold',)
*/

-- Prediction Query
SELECT Membership_card FROM member GROUP BY Membership_card HAVING COUNT(*) > 5;

/*
Prediction Result:
*/