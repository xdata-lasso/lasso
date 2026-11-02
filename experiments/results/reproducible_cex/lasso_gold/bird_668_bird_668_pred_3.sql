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
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1099, 1103, '1977-04-14', 'Brian Hamilton', '1981-08-18', 'https://joyce.com/', '236 Byrd Extensions Suite 680
Justinchester, WY 76520', 'operation', 1107, 1111, 1115, 1119, 1123, 'https://griffin.info/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1100, 1108.0, '1977-04-15', 'Brian Hamilton', '1981-08-19', 'https://www.graham.com/', '7738 Leon Underpass Apt. 148
Clarencebury, TX 41188', 'physical', 1126.0, 1132.0, 1138.0, 1144.0, 1150.0, 'https://www.ramirez.com/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1101, 1113.0, '1977-04-16', 'Brian Hamilton', '1981-08-20', 'https://rush.org/', '00379 Stanley Roads
Lake Heather, NM 52884', 'free', 1145.0, 1153.0, 1161.0, 1169.0, 1177.0, 'https://reeves.com/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1102, 1118.0, '1977-04-17', 'Brian Hamilton', '1981-08-21', 'https://www.mccullough.com/', '63287 Angela Vista
South Dennismouth, TN 70117', 'someone', 1164.0, 1174.0, 1184.0, 1194.0, 1204.0, 'https://miller.com/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1131, 1135, '1989-05-03', 'Aaron Bell', '1993-09-07', 'https://adkins.com/', '46537 Rogers Light
Karenchester, KS 11236', 'growth', 1139, 1143, 1147, 1151, 1155, 'https://www.yu-reid.info/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1132, 1140.0, '1989-05-04', 'Aaron Bell', '1993-09-08', 'https://www.graham-johnson.com/', '3100 James Brooks
East David, TN 15494', 'actually', 1158.0, 1164.0, 1170.0, 1176.0, 1182.0, 'http://gross.com/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1133, 1145.0, '1989-05-05', 'Aaron Bell', '1993-09-09', 'https://www.calhoun-hooper.net/', '4529 Kimberly Estates
Danieltown, ME 75971', 'time', 1177.0, 1185.0, 1193.0, 1201.0, 1209.0, 'https://petersen-vargas.com/');
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1134, 1150.0, '1989-05-06', 'Aaron Bell', '1993-09-10', 'http://elliott.com/', '3193 Heidi Hollow Apt. 905
Stanleyland, NY 85375', 'kitchen', 1196.0, 1206.0, 1216.0, 1226.0, 1236.0, 'http://www.keith-sanchez.info/');
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (1127, 1099, 'Amy Russell', '1985-01-22');
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (1128, 1099, 'Jennifer Clark', '1985-01-23');
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (1129, 1099, 'Taylor Silva', '1985-01-24');
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (1130, 1099, 'Shannon Cannon', '1985-01-25');
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (1159, 1131, NULL, '1997-02-11');
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (1160, 1131, NULL, '1997-02-12');
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (1161, 1131, NULL, '1997-02-13');
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (1162, 1131, NULL, '1997-02-14');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.DisplayName FROM users AS T1 INNER JOIN badges AS T2 ON T1.Id = T2.UserId GROUP BY T1.DisplayName ORDER BY COUNT(T1.Id) DESC, T1.DisplayName NULLS LAST LIMIT 1;

/*
Gold Result:
('Aaron Bell',)
*/

-- Prediction Query
SELECT T2.DisplayName FROM badges AS T1 INNER JOIN users AS T2 ON T1.UserId = T2.Id GROUP BY T2.DisplayName ORDER BY COUNT(T1.Name) DESC, T2.DisplayName NULLS LAST LIMIT 1;

/*
Prediction Result:
('Brian Hamilton',)
*/