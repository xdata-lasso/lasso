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
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1, -55602865, '2024-02-19 01:18:26+00:00', 'csgillespie', '2022-06-06 02:35:43+00:00', 'wqcgsk', '9n8c4pgu7v', 'e4', 1160656988, -992890117, 1914020640, 1268590800, 1219478689, 'uzhsrwbbp6lu');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (2, 528680845, '2023-12-22 03:17:01+00:00', 'csgillespie', '2024-05-26 02:52:16+00:00', 'nium52zbu', '4nrq', 'rofqyp5s5b', 2107872094, 882961052, 743312762, -1822992503, -868774469, 'qa1');

-- Inserting into table: badges --
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483648, 1, 'dlttil', '2011-01-01 00:00:00+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483647, 1, 'nprmdposii', '2000-03-01 00:00:00+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483646, 1, 'unw6klfa', '2011-01-01 00:00:00+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483645, 1, '00t5c4ecigc', '2011-01-01 00:00:00+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483644, 2, 'yytoo', '2011-01-01 00:00:00+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (2, 2, 'o9hl72kl', '2020-08-18 16:30:34+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483642, 2, '4ji7zwa', '2011-01-01 00:00:00+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (3, 2, '2dwyrq', '2023-09-08 22:37:16+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483640, 2, 'yu78', '2011-01-01 00:00:00+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (4, 2, '9', '2024-09-26 13:13:01+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483638, 2, 'jsl', '2011-01-01 00:00:00+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (5, 2, 'b4yp5qi', '2023-10-21 02:54:45+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483636, 2, 'f9v', '2011-01-01 00:00:00+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (6, 2, 'x58pz', '2023-06-28 05:47:44+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483634, 1, '8jegd21vy9ux', '2011-01-01 00:00:00+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (7, 2, 'j4hwbdvlph', '2023-09-26 13:08:37+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483632, 1, 'dqwn', '2011-01-01 00:00:00+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (8, 2, 'cx5hn', '2020-05-10 07:36:02+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483630, 1, 'jtu0d', '2011-01-01 00:00:00+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (9, 2, '79fjgq8', '2021-10-07 12:15:00+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483628, 2, '3d', '2011-01-01 00:00:00+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (10, 2, 'qv0gcb98ozk', '2023-12-12 02:47:46+00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.Id) FROM badges AS T1 INNER JOIN users AS T2 ON T1.UserId = T2.Id WHERE STRFTIME('%Y', T1.Date) = '2011' AND T2.DisplayName = 'csgillespie';

/*
Gold Result:
(12,)
*/

-- Prediction Query
SELECT COUNT(*) FROM badges WHERE UserId = (SELECT Id FROM users WHERE DisplayName = 'csgillespie') AND STRFTIME('%Y', Date) = '2011';

/*
Prediction Result:
(6,)
*/