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
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1001, 1014, '1970-01-01', 'Allison Hill', '1983-03-14', 'http://www.stanley.com/', 'Unit 2814 Box 8932
DPO AA 21675', 'point', 1027, 1040, 1053, 1066, 1079, 'http://www.henderson.com/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1002, 1019.0, '1970-01-02', 'Noah Rhodes', '1983-03-15', 'http://www.ramirez-reid.com/', '570 Sarah Wells
Johnbury, FM 74865', 'develop', 1046.0, 1061.0, 1076.0, 1091.0, 1106.0, 'https://www.ramos.com/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1003, 1024.0, '1970-01-03', 'Angie Henderson', '1983-03-16', 'http://clark-adams.com/', 'USS Dennis
FPO AE 70323', 'series', 1065.0, 1082.0, 1099.0, 1116.0, 1133.0, 'http://www.johnson.biz/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1004, 1029.0, '1970-01-04', 'Daniel Wagner', '1983-03-17', 'http://www.ford.net/', '782 Rose Rest
Brandtside, WV 96174', 'gun', 1084.0, 1103.0, 1122.0, 1141.0, 1160.0, 'http://www.diaz-fitzpatrick.com/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1005, 1034.0, '1970-01-05', 'Cristian Santos', '1983-03-18', 'http://perez.com/', '5787 John Circles Suite 098
New Jeffrey, CA 93279', 'Democrat', 1103.0, 1124.0, 1145.0, 1166.0, 1187.0, 'https://www.wright.biz/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1006, 1039.0, '1970-01-06', 'Connie Lawrence', '1983-03-19', 'https://clark.com/', '05183 Caldwell Forest
Lake Selena, OK 76026', 'right', 1122.0, 1145.0, 1168.0, 1191.0, 1214.0, 'http://www.cherry.biz/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1007, 1044.0, '1970-01-07', 'Abigail Shaffer', '1983-03-20', 'http://wilkerson-day.com/', '3116 Henderson Mountain Apt. 106
Laurenville, IA 25613', 'protect', 1141.0, 1166.0, 1191.0, 1216.0, 1241.0, 'http://www.middleton.com/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1008, 1049.0, '1970-01-08', 'Gina Moore', '1983-03-21', 'https://www.mcgee.com/', '62473 Scott Wall Apt. 080
Port Melindaburgh, MT 64154', 'tonight', 1160.0, 1187.0, 1214.0, 1241.0, 1268.0, 'https://www.rodriguez.com/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1009, 1054.0, '1970-01-09', 'Gabrielle Davis', '1983-03-22', 'https://robinson-bright.net/', '26064 Mitchell Square Suite 234
North Beth, ND 08490', 'everything', 1179.0, 1208.0, 1237.0, 1266.0, 1295.0, 'http://torres-pope.com/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1010, 1059.0, '1970-01-10', 'Ryan Munoz', '1983-03-23', 'https://www.callahan.com/', '97882 Susan Common
North Brooke, TX 31329', 'mouth', 1198.0, 1229.0, 1260.0, 1291.0, 1322.0, 'http://www.lee.com/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1011, 1064.0, '1970-01-11', 'Monica Herrera', '1983-03-24', 'https://www.james-ferrell.net/', '909 Robert Prairie
Sarahborough, TN 94373', 'middle', 1217.0, 1250.0, 1283.0, 1316.0, 1349.0, 'https://zavala.com/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1012, 1069.0, '1970-01-12', 'Jamie Arnold', '1983-03-25', 'https://www.le.com/', '2475 Albert Road Apt. 183
Davidstad, FM 09517', 'enter', 1236.0, 1271.0, 1306.0, 1341.0, 1376.0, 'https://www.estes.biz/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1013, 1074.0, '1970-01-13', 'Lisa Hensley', '1983-03-26', 'https://www.graham-chavez.com/', '2784 Elizabeth Plaza Suite 124
North Juliaberg, KY 37431', 'western', 1255.0, 1292.0, 1329.0, 1366.0, 1403.0, 'https://obrien-dixon.biz/');
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (1092, 1001, 'Necromancer', '1996-05-04');
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (1093, 1002, 'Necromancer', '1996-05-05');
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (1094, 1003, 'Necromancer', '1996-05-06');
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (1095, 1004, 'Necromancer', '1996-05-07');
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (1096, 1005, 'Necromancer', '1996-05-08');
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (1097, 1006, 'Necromancer', '1996-05-09');
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (1098, 1007, 'Necromancer', '1996-05-10');
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (1099, 1008, 'Necromancer', '1996-05-11');
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (1100, 1009, 'Necromancer', '1996-05-12');
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (1101, 1010, 'Necromancer', '1996-05-13');
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (1102, 1011, 'Necromancer', '1996-05-14');
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (1103, 1012, 'Necromancer', '1996-05-15');
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (1104, 1013, 'Necromancer', '1996-05-16');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.DisplayName FROM users AS T1 INNER JOIN badges AS T2 ON T1.Id = T2.UserId WHERE T2.Name = 'Necromancer' LIMIT 10;

/*
Gold Result:
('Allison Hill',)
('Noah Rhodes',)
('Angie Henderson',)
('Daniel Wagner',)
('Cristian Santos',)
('Connie Lawrence',)
('Abigail Shaffer',)
('Gina Moore',)
('Gabrielle Davis',)
('Ryan Munoz',)
*/

-- Prediction Query
SELECT DISTINCT T1.DisplayName FROM users AS T1 JOIN badges AS T2 ON T1.Id = T2.UserId WHERE T2.Name = 'Necromancer';

/*
Prediction Result:
('Allison Hill',)
('Noah Rhodes',)
('Angie Henderson',)
('Daniel Wagner',)
('Cristian Santos',)
('Connie Lawrence',)
('Abigail Shaffer',)
('Gina Moore',)
('Gabrielle Davis',)
('Ryan Munoz',)
('Monica Herrera',)
('Jamie Arnold',)
('Lisa Hensley',)
*/