-- Schema DDL
CREATE TABLE "shop" ("Shop_ID" INTEGER PRIMARY KEY, "Address" TEXT, "Num_of_staff" TEXT, "Score" REAL, "Open_Year" TEXT);

CREATE TABLE "member" ("Member_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Membership_card" TEXT, "Age" INTEGER, "Time_of_purchase" INTEGER, "Level_of_membership" INTEGER, "Address" TEXT);

CREATE TABLE "happy_hour" ("HH_ID" INTEGER, "Shop_ID" INTEGER, "Month" TEXT, "Num_of_shaff_in_charge" INTEGER, PRIMARY KEY ("HH_ID", "Shop_ID", "Month"), FOREIGN KEY ("Shop_ID") REFERENCES "shop" ("Shop_ID"));

CREATE TABLE "happy_hour_member" ("HH_ID" INTEGER, "Member_ID" INTEGER, "Total_amount" REAL, PRIMARY KEY ("HH_ID", "Member_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO shop (Shop_ID, Address, Num_of_staff, Score, Open_Year) VALUES (1, 'Zebra Ave', '10', 4.5, '2015');
INSERT INTO shop (Shop_ID, Address, Num_of_staff, Score, Open_Year) VALUES (2, 'Zebra Ave', '15', 3.8, '2018');
INSERT INTO shop (Shop_ID, Address, Num_of_staff, Score, Open_Year) VALUES (3, 'Elm St', '8', 4.0, '2020');
INSERT INTO member (Member_ID, Name, Membership_card, Age, Time_of_purchase, Level_of_membership, Address) VALUES (10, 'Alice', 'Black', 30, 5, 2, NULL);
INSERT INTO member (Member_ID, Name, Membership_card, Age, Time_of_purchase, Level_of_membership, Address) VALUES (11, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO member (Member_ID, Name, Membership_card, Age, Time_of_purchase, Level_of_membership, Address) VALUES (12, 'Bob', 'White', 25, 2, 1, 'Pine St');
INSERT INTO member (Member_ID, Name, Membership_card, Age, Time_of_purchase, Level_of_membership, Address) VALUES (13, 'Bob', 'White', 25, 2, 1, 'Pine St');
INSERT INTO member (Member_ID, Name, Membership_card, Age, Time_of_purchase, Level_of_membership, Address) VALUES (14, 'Charlie', 'Black', 40, 10, 3, 'Oak St');
INSERT INTO member (Member_ID, Name, Membership_card, Age, Time_of_purchase, Level_of_membership, Address) VALUES (15, 'David', NULL, 35, 0, 2, 'Oak St');
INSERT INTO member (Member_ID, Name, Membership_card, Age, Time_of_purchase, Level_of_membership, Address) VALUES (16, 'Eve', 'Black', 22, 4, 5, 'Zebra Ave');
INSERT INTO member (Member_ID, Name, Membership_card, Age, Time_of_purchase, Level_of_membership, Address) VALUES (17, 'Frank', 'White', 50, 8, 4, 'Apple Rd');
INSERT INTO member (Member_ID, Name, Membership_card, Age, Time_of_purchase, Level_of_membership, Address) VALUES (18, 'Grace', 'Black', 28, 3, 2, 'Apple Rd');
INSERT INTO member (Member_ID, Name, Membership_card, Age, Time_of_purchase, Level_of_membership, Address) VALUES (19, NULL, 'White', 19, 1, 1, 'Apple Rd');
INSERT INTO happy_hour (HH_ID, Shop_ID, Month, Num_of_shaff_in_charge) VALUES (100, 1, 'May', 3);
INSERT INTO happy_hour (HH_ID, Shop_ID, Month, Num_of_shaff_in_charge) VALUES (101, 2, 'June', 4);
INSERT INTO happy_hour_member (HH_ID, Member_ID, Total_amount) VALUES (100, 16, 50.0);
INSERT INTO happy_hour_member (HH_ID, Member_ID, Total_amount) VALUES (101, 16, 75.5);
INSERT INTO happy_hour_member (HH_ID, Member_ID, Total_amount) VALUES (100, 12, 20.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, address FROM (SELECT address, COUNT(*) AS n FROM member GROUP BY address) ORDER BY count___, address NULLS LAST;

/*
Gold Result:
(1, 'Zebra Ave')
(2, 'Oak St')
(2, 'Pine St')
(2, None)
(3, 'Apple Rd')
*/

-- Prediction Query
SELECT COUNT(*), address FROM member GROUP BY address;

/*
Prediction Result:
(2, None)
(3, 'Apple Rd')
(2, 'Oak St')
(2, 'Pine St')
(1, 'Zebra Ave')
*/