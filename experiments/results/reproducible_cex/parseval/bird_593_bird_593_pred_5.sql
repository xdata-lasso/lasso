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
-- Inserting into table: users --
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', 'New York', '4', -734455130, 1744686505, -1633151678, -252690330, 1115440883, 'hsrwbbp');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3, -1349201381, '2020-12-19 01:52:21+00:00', 'dlttil', '2020-03-11 00:23:16+00:00', 'nprmdposii', 'New York', '5u', 1861536320, 44952191, 1151980946, 1620389964, 546571701, '0t5c4ecigc');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (4, 528680845, '2023-12-22 03:17:01+00:00', '6nium52zb', '2025-10-02 08:51:14+00:00', 'o4nrqr', 'fqyp', 's5bbp02e', -751275471, -1347802441, 1673584235, -2118135981, 2074205376, 'yytoo');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (2, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', 't2__f9f007', '4', -734455130, 1744686505, -1633151678, -252690330, 1115440883, 'hsrwbbp');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (5, 1, '2024-06-15 00:00:00+00:00', 'value', '2024-06-15 00:00:00+00:00', 'value', NULL, 'value', 1, 1, 1, 1, 1, 'value');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (6, -1659388584, '2020-06-20 11:35:06+00:00', 'tti', '2021-07-20 10:41:36+00:00', 'n', 'New York', 'rmdp', 2026480202, -1576219117, -1823627488, -1209887326, -1399556171, 'a9000t5c4eci');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (7, 1149850321, '2020-05-18 19:45:10+00:00', 'e376nium52', '2025-09-21 09:36:38+00:00', 'buo4nrq', 'New York', 'rofqyp5s5b', 2107872094, 882961052, 743312762, -1822992503, -868774469, 'qa1');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (8, 2074205376, '2022-05-03 02:13:10+00:00', 'ytoo3o9', '2020-12-13 17:48:30+00:00', '72k', 'New York', 'ex1', -74849714, 105869088, -2081315180, 1909986641, 1485335077, 'yrq13pyu78d9');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (9, 244829661, '2021-07-21 20:51:39+00:00', 'sl0', '2020-03-25 00:00:06+00:00', 'yp5qi2rk', 'New York', '9v', 556727997, 1178000634, 1836127587, -1529584866, 1196308825, 'd21vy9uxj4hw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (10, -2050247126, '2022-10-17 07:55:28+00:00', 'ph2', '2020-12-04 21:49:29+00:00', 'dqwn', 'New York', 'cx5hn', -1106350634, -1509264256, -792947627, -1898531797, -1748371085, 'q8');

-- Inserting into table: badges --
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (1, 1, 'Supporter', '2024-04-12 00:38:47+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (3, 1, 'Supporter', '2023-11-18 08:10:54+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (2, 2, 'Supporter', '2024-04-12 00:38:47+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (4, 5, 'Supporter', '2021-07-31 11:04:01+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (5, 6, NULL, '2024-06-15 00:00:00+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (6, 7, NULL, '2024-06-15 00:00:00+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (7, 8, NULL, '2024-06-15 00:00:00+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (8, 9, NULL, '2024-06-15 00:00:00+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (9, 10, NULL, '2024-06-15 00:00:00+00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(DISTINCT T1.Id) FROM badges AS T1 INNER JOIN users AS T2 ON T1.UserId = T2.Id WHERE T1.Name IN ('Supporter', 'Teacher') AND T2.Location = 'New York';

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT T3.Id) FROM badges AS T1 INNER JOIN badges AS T2 ON T1.UserId = T2.UserId INNER JOIN users AS T3 ON T1.UserId = T3.Id WHERE T1.Name = 'Teacher' AND T2.Name = 'Supporter' AND T3.Location = 'New York';

/*
Prediction Result:
(0,)
*/