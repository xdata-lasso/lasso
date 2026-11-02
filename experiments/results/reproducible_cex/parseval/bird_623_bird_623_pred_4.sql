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
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', '4', 'gu7v', -1865039888, 1160656988, -992890117, 1914020640, 66, 'ypuzhsrw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (2, 2122220075, '2022-01-03 02:42:55+00:00', 'luhvdltti', '2021-07-20 10:41:36+00:00', 'n', 'rmdp', 'siie', -45536098, 1861536320, 44952191, 1151980946, 66, 'a9');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (4, 1620389964, '2025-05-02 19:47:39+00:00', '0t5c4ec', '2021-02-04 01:21:18+00:00', 'gce376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', 743312762, -1822992503, -868774469, -1068298341, -314162272, 'ytoo3o9');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', '4', 'gu7v', -1865039888, 1160656988, -992890117, 1914020640, 66, 'ypuzhsrw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (5, 1908028688, '2020-03-08 22:40:47+00:00', 'p6luhvdlttil', '2020-03-11 00:23:16+00:00', 'nprmdposii', '5u', 'w6kl', 1620389964, 546571701, 947159877, 1990080517, 65, 'c4ecigce');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (6, 1155439218, '2021-02-10 21:10:52+00:00', 'm52zbu', '2021-11-30 23:39:10+00:00', 'nrqrofqy', '5s5b', 'p', 882961052, 743312762, -1822992503, -868774469, 65, 'qa1');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (7, 1, '2024-06-15 00:00:00+00:00', 'value', '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, NULL, 'value');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (8, 1, '2024-06-15 00:00:00+00:00', 'value', '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, NULL, 'value');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (9, 1, '2024-06-15 00:00:00+00:00', 'value', '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, NULL, 'value');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (10, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', '4', 'gu7v', -1865039888, 1160656988, -992890117, 1914020640, 66, 'ypuzhsrw');

-- Inserting into table: badges --
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483648, 1, 'Supporter', '2020-04-05 14:43:51+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483647, 4, 'Supporter', '2020-12-13 17:48:30+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483646, 4, 'Supporter', '2021-08-05 01:19:54+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483645, 4, 'Supporter', '2025-11-19 11:50:18+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483644, 4, 'Supporter', '2024-06-06 15:16:07+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (2, 1, 'Supporter', '2023-10-09 18:36:37+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (3, 1, 'Supporter', '2021-05-27 14:39:41+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483641, 1, 'Supporter', '2021-07-01 18:29:24+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483640, 1, 't2__e538a9', '2020-08-18 16:30:34+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483639, 1, 'Supporter', '2023-03-10 01:47:11+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (4, 3, NULL, '2024-06-15 00:00:00+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (5, 5, 't2__8b234f', '2023-12-22 03:17:01+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (6, 6, NULL, '2024-06-15 00:00:00+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (7, 7, 'Supporter', '2023-08-19 04:29:46+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (8, 8, 't2__8b234f', '2022-05-03 02:13:10+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (9, 9, NULL, '2024-06-15 00:00:00+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (10, 10, 'Supporter', '2020-04-05 14:43:51+00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.Id) FROM users AS T1 INNER JOIN badges AS T2 ON T1.Id = T2.UserId WHERE T1.Age > 65 AND T2.Name = 'Supporter';

/*
Gold Result:
(6,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT users.id) FROM users INNER JOIN badges ON users.id = badges.userid WHERE users.age > 65 AND badges.name = 'Supporter';

/*
Prediction Result:
(2,)
*/