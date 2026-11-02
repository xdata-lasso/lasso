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
-- Inserting into table: posts --
INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (-2147483648, 2122220075, 1072996612, '2024-04-12 00:38:47+00:00', -1349201381, 1019800248, 'dlttil', -2147483648, '2020-03-11 00:23:16+00:00', 't2__7d7c99', '<humor>', -1257178728, 1236688122, 2087640001, -2147483648, '2025-09-01 05:13:03+00:00', '2025-03-03 08:26:45+00:00', 907682809, '2021-12-08 15:32:00+00:00', 'siie5unw6k', 'fa9');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (2, 1313172851, -761141909, '2024-10-24 14:16:53+00:00', -53231346, -443340271, 'uo4nrqrofqy', -2147483648, '2022-01-22 16:14:13+00:00', 't2__7d7c99', '<humor>', -921187550, -2070843029, 328305758, -2147483648, '2022-10-06 23:43:31+00:00', '2022-07-13 23:48:43+00:00', -1347802441, '2022-02-19 15:51:21+00:00', '1', 'ryytoo3');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (3, 90119032, -1438850342, '2020-08-18 16:30:34+00:00', 1055976837, 1775126557, 'ji7zwau2', -2147483648, '2025-11-10 22:24:59+00:00', 't2__7d7c99', '<humor>', 1909986641, 1485335077, -511185946, -2147483648, '2022-03-25 08:00:08+00:00', '2023-09-08 22:37:16+00:00', 392822403, '2022-01-29 19:28:25+00:00', 'u78d99r', 'jsl');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (4, -59984348, -664303813, '2022-03-24 16:30:12+00:00', -1981402255, -890215420, '9n8c4pgu7v', -2147483648, '2020-09-25 19:25:33+00:00', '4h', 't2__b924d6', -992890117, 1914020640, 1268590800, -2147483648, '2023-03-21 21:13:18+00:00', '2022-01-21 14:23:36+00:00', -1670923962, '2025-08-22 00:34:24+00:00', 'wbbp6', 'uhv');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (5, 1, 1, '2024-06-15 00:00:00+00:00', 1, 1, 'value', -2147483648, '2024-06-15 00:00:00+00:00', 'value', NULL, 1, 1, 1, -2147483648, '2024-06-15 00:00:00+00:00', '2024-06-15 00:00:00+00:00', 1, '2024-06-15 00:00:00+00:00', 'value', 'value');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (6, 528680845, -1585009206, '2021-08-19 01:10:02+00:00', 283598170, 742285925, 'u', -2147483648, '2021-11-30 23:39:10+00:00', 'nrqrofqy', '5s5b', 2107872094, 882961052, 743312762, -2147483648, '2024-11-25 22:27:17+00:00', '2020-08-22 17:31:36+00:00', -751275471, '2021-08-01 11:21:15+00:00', 'qa1', 'ryytoo3');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (7, -511185946, -1021749117, '2025-01-11 14:32:08+00:00', -1097120355, 244829661, 'jsl', -2147483648, '2023-07-26 21:52:05+00:00', '4', 'p5qi2rk', -705985602, 537874887, -461695645, -2147483648, '2025-11-28 13:30:18+00:00', '2020-10-01 21:08:19+00:00', 176555546, '2020-08-21 23:51:43+00:00', 'd2', 'vy9uxj4');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (8, -1245312912, 1575412235, '2022-04-18 00:53:20+00:00', -1509264256, -792947627, 'z', -2147483648, '2024-06-08 14:05:00+00:00', 'fjgq8n2f3', 'dqv0gcb98ozk', -155284187, 1686459626, -1554531873, -2147483648, '2023-03-28 14:41:46+00:00', '2022-05-18 00:14:53+00:00', 1038566008, '2025-03-26 10:17:14+00:00', 'n6vck6ah0f8', 'sww');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (9, -1738458256, -1714354341, '2020-06-19 19:37:13+00:00', 1074760385, 1129658414, '1afgo', -2147483648, '2020-11-22 11:14:57+00:00', 'itsj3', 'y', -598313376, 1972233925, 1792827279, -2147483648, '2025-05-18 14:45:15+00:00', '2025-11-05 10:13:50+00:00', -106471771, '2023-06-28 02:52:00+00:00', 'jh3den8', 'c68x8vacx7');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (10, -1784554553, -242584410, '2023-07-14 21:32:37+00:00', 1870300798, 820970595, 'qdjpe1io2', -2147483648, '2023-10-17 13:49:58+00:00', '8507cvtjp', 'ttg6bnou5zi3', -68044929, -1776877925, 1201273976, -2147483648, '2025-08-13 14:13:20+00:00', '2021-12-05 15:43:31+00:00', -1950324754, '2023-07-08 08:00:15+00:00', '7z2zezjo7wg', 'd5ysxc');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (11, 195202164, 1817366143, '2023-11-02 12:51:45+00:00', 1055237066, 988954859, 'th', -2147483648, '2024-11-29 13:11:46+00:00', 'mnajjla3', 'okv8uttmu2', -1252009958, 1908593332, 697257217, -2147483648, '2023-05-05 20:15:58+00:00', '2024-06-27 07:12:45+00:00', 448935289, '2023-04-29 21:53:50+00:00', 'be8yvkv42q7', 'x58b4');

INSERT INTO "posts" ("id", "posttypeid", "acceptedanswerid", "creaiondate", "score", "viewcount", "body", "owneruserid", "lasactivitydate", "title", "tags", "answercount", "commentcount", "favoritecount", "lasteditoruserid", "lasteditdate", "communityowneddate", "parentid", "closeddate", "ownerdisplayname", "lasteditordisplayname") VALUES (12, 823835795, -354292049, '2025-06-30 18:54:45+00:00', 238533676, -1514700303, 'of', -2147483648, '2022-12-30 09:36:03+00:00', 'zdo2z', 'obb0q0k32o', -1898678660, 440115543, 292557306, -2147483648, '2025-08-28 09:25:40+00:00', '2021-12-02 07:29:49+00:00', -984562992, '2023-01-20 18:10:08+00:00', 'ngc1dj9', 'rh');

-- Inserting into table: users --
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483648, -55602865, '2024-02-19 01:18:26+00:00', 'wwqcg', '2022-06-28 11:34:24+00:00', '9n8', '4', 'gu7v', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw');

-- Inserting into table: comments --
INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (1, -2147483648, 947159877, 't1__027b00', '2022-07-16 22:41:51+00:00', -2147483648, 'c4ecigce');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (2, 2, 1692174491, 't1__027b00', '2024-03-18 20:04:07+00:00', -2147483648, 'i2rkf');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (3, 3, 556727997, 't1__027b00', '2024-02-28 14:45:41+00:00', -2147483648, 'pz0f8jegd');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (-2147483648, -2147483648, -1377057208, 'ilbnp', '2022-04-12 01:47:28+00:00', -2147483648, 'dpos');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (5, 5, -45536098, 'w6kl', '2020-09-15 12:11:12+00:00', -2147483648, 'a9000t5c4eci');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (4, 2, 90119032, 'lex', '2023-08-25 07:55:29+00:00', -2147483648, 'ji7zwau2');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (6, -2147483648, -2050247126, 'lph2gn', '2020-07-01 12:41:54+00:00', -2147483648, 'wnqcx');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (7, 3, -566887085, '72fxa7ryfd', '2022-05-09 09:35:03+00:00', -2147483648, 'z16nijjai5d');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (8, -2147483648, -47052816, '1of77pzo72c', '2022-08-17 19:55:37+00:00', -2147483648, 'c');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (9, 4, 983324983, 'ztdg', '2021-03-26 14:01:04+00:00', -2147483648, '5i3lq5lnpim5');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (10, 11, 319284352, '3auvm', '2021-05-14 07:56:41+00:00', -2147483648, 'rpdjwzw5ch');

INSERT INTO "comments" ("id", "postid", "score", "text", "creationdate", "userid", "userdisplayname") VALUES (11, 11, 1056589776, 'k1', '2023-04-06 19:38:57+00:00', -2147483648, 'eyo6');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT AVG(T2.ViewCount), T2.Title, T1.Text FROM comments AS T1 INNER JOIN posts AS T2 ON T1.Id = T1.PostId WHERE T2.Tags = '<humor>';

/*
Gold Result:
(783862178.0, 't2__7d7c99', 'ilbnp')
*/

-- Prediction Query
SELECT AVG(T1.ViewCount), T1.Title, T2.Text FROM posts AS T1 INNER JOIN comments AS T2 ON T1.Id = T2.PostId WHERE T1.Tags LIKE '%<humor>%';

/*
Prediction Result:
(842846695.5, 't2__7d7c99', 'ilbnp')
*/