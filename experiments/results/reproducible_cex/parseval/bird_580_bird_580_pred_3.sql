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
INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (1, -55602865, '2024-02-19 01:18:26+00:00', 't1__ca516e', '2022-06-06 02:35:43+00:00', 'wqcgsk', '9n8c4pgu7v', 'e4', 1160656988, -992890117, 1914020640, 1268590800, 1219478689, 'uzhsrwbbp6lu');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (2, -1257178728, '2022-04-12 01:47:28+00:00', 't1__ca516e', '2021-08-20 16:50:24+00:00', 'dposiie5unw', 'klfa9000t', 'c4ecigce', -1585009206, -53231346, -443340271, 757448742, -1179823637, 'rqro');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (-2147483647, 775304493, '2024-12-28 10:57:01+00:00', 't1__7e6b55', '2022-03-17 22:33:35+00:00', 'p5s5bbp', '02eutliqa11r', 'ytoo3o9', -1666765085, 1178636309, -1390245819, 1055976837, 1775126557, 'ji7zwau2');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (12, 2142703426, '2023-03-13 16:07:34+00:00', 't1__ca516e', '2022-10-12 16:19:32+00:00', '8d99rljsl', 'b4yp5qi', 'rkf9vqx5', 1836127587, -1529584866, 1196308825, 910894705, -283454505, '9uxj4hw');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (13, -2050247126, '2022-10-17 07:55:28+00:00', 't1__a9c103', '2021-07-30 02:29:08+00:00', 'h2gn', 'q', 'nqcx5h', -1245312912, 1575412235, -988981234, -841004020, -361507387, '79fjgq8');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (14, -1255130038, '2020-10-05 05:32:26+00:00', 't1__7e6b55', '2023-11-18 03:19:57+00:00', 'dqv0gcb98ozk', 'zbilyrkn', '6vck6ah0f8js', -658391922, -1388029300, -566887085, 602161869, 1350414441, 'a7ryfd');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (15, 564390026, '2024-11-03 18:41:48+00:00', 't1__9135a6', '2024-05-16 22:03:30+00:00', 'ijja', '5dh', 'ogrgjd8y', 1129658414, 1250290042, -1717646459, -1696173285, 710458518, 'sj3ayxp1q430');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (16, 1923912467, '2024-11-10 21:13:22+00:00', 't1__9d103e', '2025-04-02 22:54:49+00:00', 'jh3den8c68', '8vacx7', 'f', -47052816, 645287482, 765724008, -1099855564, 87529806, 'ctdctmfg62g0');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (17, 1870300798, '2024-03-11 08:01:44+00:00', 't1__05e264', '2025-11-17 07:39:50+00:00', '8qdjp', '1i', '2278', 2004147439, -691774480, -1523347137, 1582582341, 453836040, '6b');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (18, -1171104889, '2024-03-12 07:01:30+00:00', 't1__4a2e0b', '2023-06-13 16:42:54+00:00', '36c', 'bfkfoacd', '7z2zezj', 1448731351, -604098478, 1248858185, -57705450, -915385605, 'm');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (19, 1721638020, '2023-06-27 00:46:15+00:00', 't1__647bd1', '2021-12-02 15:45:50+00:00', 'ztdgj5i3lq5l', 'pim5', '58q', 1817366143, 1615073310, 1055237066, 988954859, -1719383707, '2m');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (20, 418247369, '2021-03-26 16:58:48+00:00', 't1__0963d4', '2021-04-29 06:47:06+00:00', 'a3o', 'v8u', 'tmu2n', -1817527403, -1402164108, 2123471885, -526633767, 448935289, 'be8yvkv');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (21, 318331233, '2023-10-16 10:50:30+00:00', 't1__a6017d', '2022-03-14 12:32:27+00:00', '7sx58b4pma', 'us3auvmkrpdj', 'wzw5chn9mo70', 628082526, -1245584612, 1731843275, -582376271, -1165594842, 'szdo2z');

INSERT INTO "users" ("id", "reputation", "creationdate", "displayname", "lastaccessdate", "websiteurl", "location", "aboutme", "views", "upvotes", "downvotes", "accountid", "age", "profileimageurl") VALUES (22, 270415200, '2020-02-24 22:37:14+00:00', '0', '2022-03-19 07:41:34+00:00', '0k32odwcl5a', 'msorlwyngc', 'dj9erhi', 1056589776, -499913447, -360096930, -1942581013, -795975227, 'xuzkb52');

-- Inserting into table: badges --
INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483648, 1, 'Necromancer', '2020-12-19 01:52:21+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483647, 1, 'Necromancer', '2022-11-06 10:19:41+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483646, 1, 'Necromancer', '2020-06-20 11:35:06+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483645, 1, 'Necromancer', '2021-07-11 07:27:32+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483644, 1, 'Necromancer', '2022-07-30 13:34:14+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483643, 1, 'Necromancer', '2022-08-02 13:58:36+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483642, 1, 'Necromancer', '2021-01-23 18:11:33+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483641, 1, 'Necromancer', '2021-07-20 10:41:36+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483640, 1, 'Necromancer', '2020-03-11 00:23:16+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483639, 1, 'Necromancer', '2025-02-07 06:53:31+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483638, 2, 'Necromancer', '2025-11-10 22:24:59+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483637, 2, 'Necromancer', '2020-06-29 05:47:52+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483636, 2, 'Necromancer', '2023-01-13 04:58:30+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483635, 2, 'Necromancer', '2024-12-22 09:14:04+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483634, 2, 'Necromancer', '2023-03-29 15:56:46+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483633, 2, 'Necromancer', '2022-05-13 17:57:39+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483632, 2, 'Necromancer', '2022-03-25 08:00:08+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483631, 2, 'Necromancer', '2023-09-08 22:37:16+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483630, 2, 'Necromancer', '2025-01-11 14:32:08+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483629, 2, 'Necromancer', '2023-11-27 00:51:18+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483628, 22, 'Necromancer', '2023-09-14 18:35:43+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483627, 22, 'Necromancer', '2020-11-29 19:49:13+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483626, 22, 'Necromancer', '2022-12-04 16:04:40+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483625, 22, 'Necromancer', '2021-10-10 22:42:32+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483624, 22, 'Necromancer', '2021-07-02 13:56:51+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483623, 22, 'Necromancer', '2020-01-06 01:47:51+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483622, 22, 'Necromancer', '2022-06-25 15:47:56+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483621, 22, 'Necromancer', '2024-04-30 14:56:46+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483620, 22, 'Necromancer', '2025-03-08 07:37:26+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483619, 22, 'Necromancer', '2020-07-21 23:57:27+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483618, 22, 'Necromancer', '2025-09-08 01:16:35+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483617, 22, 'Necromancer', '2021-07-22 08:59:59+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483616, 22, 'Necromancer', '2020-02-21 12:15:41+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483615, 22, 'Necromancer', '2021-12-10 09:52:50+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483614, 22, 'Necromancer', '2020-08-28 14:27:04+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483613, 22, 'Necromancer', '2021-12-15 23:43:59+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483612, 22, 'Necromancer', '2022-12-20 18:28:11+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483611, 22, 'Necromancer', '2021-02-07 13:23:16+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483610, 22, 'Necromancer', '2021-01-23 12:42:14+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483609, 22, 'Necromancer', '2023-09-21 01:04:05+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483608, 22, 'Necromancer', '2023-05-07 14:15:39+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483607, 22, 'Necromancer', '2024-03-11 19:06:57+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483606, 22, 'Necromancer', '2021-10-05 09:01:22+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483605, 22, 'Necromancer', '2025-05-04 13:24:05+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483604, 22, 'Necromancer', '2023-02-18 23:14:50+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483603, 22, 'Necromancer', '2021-03-06 10:06:33+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483602, 22, 'Necromancer', '2021-01-02 12:34:35+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483601, 22, 'Necromancer', '2024-05-19 10:57:10+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483600, 22, 'Necromancer', '2024-04-07 18:10:54+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483599, 22, 'Necromancer', '2023-10-03 17:29:40+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483598, 22, 'Necromancer', '2022-03-16 10:43:12+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483597, 22, 'Necromancer', '2023-10-18 11:51:31+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483596, 22, 'Necromancer', '2023-02-20 15:26:15+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483595, 22, 'Necromancer', '2025-10-14 13:29:52+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483594, 22, 'Necromancer', '2024-10-27 05:47:49+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483593, 22, 'Necromancer', '2021-06-27 02:54:15+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483592, 22, 'Necromancer', '2023-03-16 20:38:44+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483591, 22, 'Necromancer', '2025-01-25 14:56:35+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483590, 22, 'Necromancer', '2021-12-25 22:00:39+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483589, 22, 'Necromancer', '2022-08-25 00:08:33+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (2, 1, 'Necromancer', '2025-07-02 03:36:52+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (3, 1, 'Necromancer', '2021-12-05 05:27:44+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483588, 1, 'Necromancer', '2022-12-15 20:09:37+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483585, 1, 'Necromancer', '2024-08-29 05:28:03+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483584, 1, 'Necromancer', '2021-12-24 12:13:22+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483583, 1, 'Necromancer', '2025-09-10 18:47:19+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483582, 1, 'Necromancer', '2020-02-05 22:42:54+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483581, 1, 'Necromancer', '2025-12-04 20:24:52+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483580, 1, 'Necromancer', '2025-02-26 07:57:51+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483579, 1, 'Necromancer', '2020-02-08 01:53:00+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483578, 1, 'Necromancer', '2023-01-03 20:24:22+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483577, 1, 'Necromancer', '2020-10-19 21:22:19+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483576, 1, 'Necromancer', '2024-09-22 16:04:20+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483575, 1, 'Necromancer', '2024-05-20 15:01:09+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483574, 1, 'Necromancer', '2020-01-10 04:27:01+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483573, 1, 'Necromancer', '2022-03-05 18:43:06+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483572, 1, 'Necromancer', '2020-03-03 02:26:18+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483571, 1, 'Necromancer', '2023-07-01 11:41:54+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483570, 1, 'Necromancer', '2022-07-26 21:24:54+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483569, 1, 'Necromancer', '2020-02-29 08:50:35+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483568, 1, 'Necromancer', '2025-02-14 08:12:06+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483567, 1, 'Necromancer', '2025-12-21 08:50:01+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483566, 1, 'Necromancer', '2021-02-21 13:56:33+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483565, 1, 'Necromancer', '2025-04-01 08:16:25+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483564, 1, 'Necromancer', '2021-11-04 03:03:45+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483563, 1, 'Necromancer', '2020-06-29 17:59:15+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483562, 1, 'Necromancer', '2023-05-07 05:01:37+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483561, 1, 'Necromancer', '2023-12-20 17:13:08+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483560, 1, 'Necromancer', '2024-09-22 10:31:45+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483559, 1, 'Necromancer', '2022-07-28 07:48:03+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483558, 1, 'Necromancer', '2020-01-05 17:53:54+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483557, 1, 'Necromancer', '2021-04-16 21:57:00+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483556, 1, 'Necromancer', '2023-05-09 01:10:53+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483555, 1, 'Necromancer', '2024-10-08 16:57:12+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483554, 1, 't2__82f23c', '2022-08-02 17:02:31+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483553, 1, 't2__90eaad', '2020-06-02 05:30:58+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483552, 1, 't2__45b569', '2024-07-21 17:54:15+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483551, 1, 't2__91e1e6', '2021-10-03 11:24:08+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483550, 1, 't2__b21fe8', '2025-07-30 07:59:24+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483549, 1, 't2__57b724', '2025-09-25 15:29:13+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483548, 1, 't2__e7e3d8', '2024-02-19 05:03:24+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483547, 1, 't2__d72565', '2023-01-06 00:58:47+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483546, 1, 't2__c1cf74', '2020-04-24 22:41:34+00:00');

INSERT INTO "badges" ("id", "userid", "name", "date") VALUES (-2147483545, 1, 't2__9ae66a', '2020-11-23 15:43:29+00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.DisplayName FROM users AS T1 INNER JOIN badges AS T2 ON T1.Id = T2.UserId WHERE T2.Name = 'Necromancer' LIMIT 10;

/*
Gold Result:
('t1__ca516e',)
('t1__ca516e',)
('t1__ca516e',)
('t1__ca516e',)
('t1__ca516e',)
('t1__ca516e',)
('t1__ca516e',)
('t1__ca516e',)
('t1__ca516e',)
('t1__ca516e',)
*/

-- Prediction Query
SELECT DISTINCT T1.DisplayName FROM users AS T1 JOIN badges AS T2 ON T1.Id = T2.UserId WHERE T2.Name = 'Necromancer';

/*
Prediction Result:
('t1__ca516e',)
('0',)
*/