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
-- DATASET 1
-- Tests:
-- 1. WHERE NOT T1.Age IS NULL (User 1 has NULL Age and earliest post date).
-- 2. INNER JOIN vs LEFT JOIN on users (User 2 has lowest Age=15 but no posts).
-- 3. INNER JOIN vs RIGHT JOIN on posts (Post 100 has OwnerUserId=NULL and earliest post date).
-- 4. Join key T1.Id = T2.OwnerUserId vs T2.LastEditorUserId or T1.Id = T2.Id.
-- 5. ORDER BY T1.Age ASC vs DESC, and LIMIT 1 vs no LIMIT.
INSERT INTO users (Id, Reputation, CreationDate, Age) VALUES (1, 100, '2020-01-01 00:00:00', NULL);
INSERT INTO users (Id, Reputation, CreationDate, Age) VALUES (2, 100, '2020-01-02 00:00:00', 15);
INSERT INTO users (Id, Reputation, CreationDate, Age) VALUES (3, 100, '2020-01-03 00:00:00', 25);
INSERT INTO users (Id, Reputation, CreationDate, Age) VALUES (4, 100, '2020-01-04 00:00:00', 35);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, CreaionDate, LasActivityDate) VALUES (100, NULL, 2, '2018-01-01 00:00:00', '2023-01-01 00:00:00');
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, CreaionDate, LasActivityDate) VALUES (101, 1, 2, '2019-01-01 00:00:00', '2023-01-02 00:00:00');
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, CreaionDate, LasActivityDate) VALUES (102, 3, 4, '2022-05-01 00:00:00', '2020-01-01 00:00:00');
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, CreaionDate, LasActivityDate) VALUES (103, 4, 2, '2021-01-01 00:00:00', '2023-01-03 00:00:00');
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, CreaionDate, LasActivityDate) VALUES (3, 4, 4, '2017-01-01 00:00:00', '2023-01-04 00:00:00');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.CreaionDate FROM users AS T1 INNER JOIN posts AS T2 ON T1.Id = T2.OwnerUserId WHERE NOT T1.Age IS NULL ORDER BY T1.Age, T2.CreaionDate, T1.id NULLS LAST, T2.id NULLS LAST LIMIT 1;

/*
Gold Result:
('2022-05-01 00:00:00',)
*/

-- Prediction Query
SELECT MIN("posts"."creaiondate") FROM "users" JOIN "posts" ON "users"."id" = "posts"."owneruserid" WHERE "users"."age" = (SELECT MIN("age") FROM "users" WHERE NOT "age" IS NULL);

/*
Prediction Result:
(None,)
*/