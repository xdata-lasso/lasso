-- Schema DDL
CREATE TABLE badges (Id INTEGER NOT NULL PRIMARY KEY, UserId INTEGER NULL, Name TEXT NULL, Date DATETIME NULL, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE comments (Id INTEGER NOT NULL PRIMARY KEY, PostId INTEGER NULL, Score INTEGER NULL, Text TEXT NULL, CreationDate DATETIME NULL, UserId INTEGER NULL, UserDisplayName TEXT NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE postHistory (Id INTEGER NOT NULL UNIQUE PRIMARY KEY, PostHistoryTypeId INTEGER NULL, PostId INTEGER NULL, RevisionGUID TEXT NULL, CreationDate DATETIME NULL, UserId INTEGER NULL, Text TEXT NULL, Comment TEXT NULL, UserDisplayName TEXT NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE postLinks (Id INTEGER NOT NULL PRIMARY KEY, CreationDate DATETIME NULL, PostId INTEGER NULL, RelatedPostId INTEGER NULL, LinkTypeId INTEGER NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (RelatedPostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE posts (Id INTEGER NOT NULL UNIQUE PRIMARY KEY, PostTypeId INTEGER NULL, AcceptedAnswerId INTEGER NULL, CreaionDate DATETIME NULL, Score INTEGER NULL, ViewCount INTEGER NULL, Body TEXT NULL, OwnerUserId INTEGER NULL, LasActivityDate DATETIME NULL, Title TEXT NULL, Tags TEXT NULL, AnswerCount INTEGER NULL, CommentCount INTEGER NULL, FavoriteCount INTEGER NULL, LastEditorUserId INTEGER NULL, LastEditDate DATETIME NULL, CommunityOwnedDate DATETIME NULL, ParentId INTEGER NULL, ClosedDate DATETIME NULL, OwnerDisplayName TEXT NULL, LastEditorDisplayName TEXT NULL, FOREIGN KEY (LastEditorUserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (OwnerUserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE tags (Id INTEGER NOT NULL PRIMARY KEY, TagName TEXT NULL, Count INTEGER NULL, ExcerptPostId INTEGER NULL, WikiPostId INTEGER NULL, FOREIGN KEY (ExcerptPostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE users (Id INTEGER NOT NULL UNIQUE PRIMARY KEY, Reputation INTEGER NULL, CreationDate DATETIME NULL, DisplayName TEXT NULL, LastAccessDate DATETIME NULL, WebsiteUrl TEXT NULL, Location TEXT NULL, AboutMe TEXT NULL, Views INTEGER NULL, UpVotes INTEGER NULL, DownVotes INTEGER NULL, AccountId INTEGER NULL, Age INTEGER NULL, ProfileImageUrl TEXT NULL);

CREATE TABLE votes (Id INTEGER NOT NULL PRIMARY KEY, PostId INTEGER NULL, VoteTypeId INTEGER NULL, CreationDate DATE NULL, UserId INTEGER NULL, BountyAmount INTEGER NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1100, 1104, '1977-04-14', 'Erin Johnson', '1981-08-18', 'https://www.estes.biz/', '484 Nguyen Square
Angelaborough, MT 87654', 'popular', 1108, 1112, 1116, 1120, 1124, 'https://johnston.biz/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1101, 1109.0, '1977-04-15', 'Erin Johnson', '1981-08-19', 'https://obrien-dixon.biz/', 'USNS Gilbert
FPO AA 53726', 'to', 1127.0, 1133.0, 1139.0, 1145.0, 1151.0, 'http://www.watts.com/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1102, 1114.0, '1977-04-16', 'Erin Johnson', '1981-08-20', 'http://fletcher.net/', '4369 Marshall Mills
New Thomas, MH 96964', 'special', 1146.0, 1154.0, 1162.0, 1170.0, 1178.0, 'https://www.brock.net/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1103, 1119.0, '1977-04-17', 'Erin Johnson', '1981-08-21', 'http://jones-beck.com/', '8951 Emily Fork
East Andrew, IA 62778', 'baby', 1165.0, 1175.0, 1185.0, 1195.0, 1205.0, 'https://www.wright.info/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1196, 1200, NULL, 'Lisa Gibbs', '1988-11-08', 'http://kerr-evans.org/', '713 French Road Apt. 618
Lake Edward, KY 19144', 'book', 1204, 1208, 1212, 1216, 1220, 'https://bates-morales.net/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1197, 1205.0, NULL, 'Lisa Gibbs', '1988-11-09', 'https://oliver.com/', '9947 Taylor Hollow
Benderhaven, ND 65223', 'toward', 1223.0, 1229.0, 1235.0, 1241.0, 1247.0, 'http://edwards.com/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1198, 1210.0, NULL, 'Lisa Gibbs', '1988-11-10', 'http://miller.com/', '5940 Jeremy Spring
Port Emilyview, OK 05774', 'college', 1242.0, 1250.0, 1258.0, 1266.0, 1274.0, 'https://www.booth.net/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1199, 1215.0, NULL, 'Lisa Gibbs', '1988-11-11', 'http://norris-harrison.com/', '8742 Walters Overpass
South Michaelmouth, MD 88336', 'girl', 1261.0, 1271.0, 1281.0, 1291.0, 1301.0, 'https://ramos.com/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1228, 1232, '1996-08-16', 'Lisa Gibbs', '1971-01-20', 'http://holland.info/', '499 Grimes Mission Suite 558
Gibsonmouth, VI 25228', 'also', 1236, 1240, 1244, 1248, 1252, 'https://www.davis.com/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1229, 1237.0, '1996-08-17', 'Lisa Gibbs', '1971-01-21', 'https://davenport-baird.com/', 'Unit 3963 Box 6057
DPO AP 50469', 'prepare', 1255.0, 1261.0, 1267.0, 1273.0, 1279.0, 'https://www.evans.com/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1230, 1242.0, '1996-08-18', 'Lisa Gibbs', '1971-01-22', 'https://www.lee-greene.com/', '0289 Kane Well
Garciamouth, AL 95193', 'easy', 1274.0, 1282.0, 1290.0, 1298.0, 1306.0, 'https://jordan-sanchez.biz/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1231, 1247.0, '1996-08-19', 'Lisa Gibbs', '1971-01-23', 'http://morgan-french.com/', '74596 Melissa Walk
Finleyfort, VI 71413', 'program', 1293.0, 1303.0, 1313.0, 1323.0, 1333.0, 'http://www.miller.org/');
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (1128, 1100, 'Victoria Larson', '1985-01-22');
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (1129, 1100, 'Stephanie Salazar', '1985-01-23');
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (1130, 1100, 'Kathy Rivas', '1985-01-24');
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (1131, 1100, 'Stephanie Manning', '1985-01-25');
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (1224, 1196, 'Jessica Wolfe', '1992-04-12');
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (1225, 1196, 'William Lynch', '1992-04-13');
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (1226, 1196, 'Christopher Pierce', '1992-04-14');
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (1227, 1196, 'Anna Gay', '1992-04-15');
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (1256, 1228, 'Kathleen Aguilar', '1975-05-01');
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (1257, 1228, 'Mark Stevens', '1975-05-02');
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (1258, 1228, 'Stephanie Marshall', '1975-05-03');
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (1259, 1228, 'Joshua Jones', '1975-05-04');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.DisplayName FROM users AS T1 INNER JOIN badges AS T2 ON T1.Id = T2.UserId GROUP BY T1.DisplayName ORDER BY COUNT(T1.Id) DESC, T1.DisplayName NULLS LAST LIMIT 1;

/*
Gold Result:
('Lisa Gibbs',)
*/

-- Prediction Query
SELECT "users"."displayname" FROM "users" INNER JOIN "badges" ON "users"."id" = "badges"."userid" GROUP BY "badges"."userid" ORDER BY COUNT("badges"."name") DESC, "users"."displayname" NULLS LAST LIMIT 1;

/*
Prediction Result:
('Erin Johnson',)
*/