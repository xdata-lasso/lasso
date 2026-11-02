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
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1, -55602865, '2024-02-19 01:18:26+00:00', 'u_s_8c8a0e', '2022-06-06 02:35:43+00:00', 'wqcgsk', '9n8c4pgu7v', 'e4', 1160656988, -992890117, 1914020640, 1268590800, 1219478689, 'uzhsrwbbp6lu');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (2, 907682809, '2021-12-08 15:32:00+00:00', 'u_s_8c8a0e', '2025-04-09 18:22:58+00:00', 'iie5u', 'w6kl', 'a9', 1620389964, 546571701, 947159877, 1990080517, 1408123494, '4');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (3, 374105386, '2020-05-12 00:10:04+00:00', 'u_s_8c8a0e', '2021-02-04 01:21:18+00:00', 'gce376nium52', 'zbuo4nrqrof', 'qyp5s5bbp0', 743312762, -1822992503, -868774469, -1068298341, -314162272, 'ytoo3o9');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (5, -1438850342, '2020-08-18 16:30:34+00:00', '!', '2023-03-10 01:47:11+00:00', '4ji7zwa', '2dwyrq', '3pyu78d', -977635379, 1661181156, -1372125820, -2031361952, 1649269347, 'p5qi2rkf9v');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (6, 556727997, '2024-02-28 14:45:41+00:00', '#', '2024-08-09 01:13:45+00:00', 'pz0f8jegd21', 'y9uxj4', 'wb', -1929953647, 1581736075, -261132974, -1264842910, -1052964641, 'qcx5');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (7, 580968159, '2021-10-14 14:41:11+00:00', 'p', '2022-04-18 00:53:20+00:00', 'tu0', 'z', '9fjgq8n2f', -1056308489, -1454058168, -2078052421, -512640349, 1038566008, 'n6vck6ah0f');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (4, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', '4', 'gu7v', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (8, 1908028688, '2020-03-08 22:40:47+00:00', 'p6luhvdlttil', '2020-03-11 00:23:16+00:00', 'nprmdposii', '5u', 'w6kl', 1620389964, 546571701, 947159877, 1990080517, 1408123494, '4');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (9, 1, '2024-06-15 00:00:00+00:00', NULL, '2024-06-15 00:00:00+00:00', 'value', 'value', 'value', 1, 1, 1, 1, 1, 'value');

-- Inserting into table: badges --
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (1, 1, 'hvdlttilbnpr', '2021-08-20 16:50:24+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483647, 2, 'l7', '2023-10-09 18:36:37+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (0, 7, 'jswwlq7xb', '2025-02-02 06:02:30+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483646, 7, '2fxa7ryfd', '2022-05-09 09:35:03+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483644, 7, 'z16nijjai5d', '2025-07-17 09:46:47+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-1, 7, '5o', '2020-10-22 21:08:07+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483642, 7, 'gjd8y', '2023-05-06 21:04:41+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (3, 1, '1afgo', '2020-11-22 11:14:57+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483641, 1, 'itsj3', '2020-02-17 22:42:09+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483639, 1, 'xp1q430', '2023-08-17 20:15:35+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483638, 1, 'jh3den8c68', '2023-02-21 21:59:10+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483637, 1, 'vacx7afu5', '2023-01-06 16:23:08+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (2, 4, 'ecigce376n', '2021-02-10 21:10:52+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (4, 4, 'm52zbu', '2021-11-30 23:39:10+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (5, 9, '5k5swwqcgs', '2021-06-17 14:22:38+00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.DisplayName FROM badges AS T1 INNER JOIN users AS T2 ON T1.UserId = T2.Id GROUP BY T2.DisplayName ORDER BY COUNT(T1.Id) DESC, T2.DisplayName NULLS LAST LIMIT 1;

/*
Gold Result:
('u_s_8c8a0e',)
*/

-- Prediction Query
SELECT u.displayname FROM users AS u INNER JOIN badges AS b ON u.id = b.userid GROUP BY b.userid ORDER BY COUNT(b.id) DESC, u.displayname NULLS LAST LIMIT 1;

/*
Prediction Result:
('u_s_8c8a0e',)
*/