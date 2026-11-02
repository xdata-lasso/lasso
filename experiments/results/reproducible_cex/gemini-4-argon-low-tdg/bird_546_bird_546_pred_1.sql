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
-- 1. WHERE condition: ClosedDate IS NOT NULL vs ClosedDate IS NULL vs omitting WHERE clause.
-- 2. Duplicate preservation (SELECT vs SELECT DISTINCT): One user owns multiple closed posts, and two different users share the same DisplayName.
-- 3. Column confusion: T2.DisplayName vs T1.OwnerDisplayName vs T1.LastEditorDisplayName.
-- 4. Join key confusion: T1.OwnerUserId = T2.Id vs T1.LastEditorUserId = T2.Id vs T1.Id = T2.Id.
INSERT INTO users (Id, Reputation, CreationDate, DisplayName) VALUES (1, 100, '2020-01-01 00:00:00', 'Alice');
INSERT INTO users (Id, Reputation, CreationDate, DisplayName) VALUES (2, 200, '2020-01-02 00:00:00', 'Bob');
INSERT INTO users (Id, Reputation, CreationDate, DisplayName) VALUES (3, 300, '2020-01-03 00:00:00', 'Alice');
INSERT INTO users (Id, Reputation, CreationDate, DisplayName) VALUES (4, 400, '2020-01-04 00:00:00', 'EditorDiana');
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, ClosedDate, OwnerDisplayName, LastEditorDisplayName, Title) VALUES (10, 1, 4, '2021-05-01 12:00:00', 'FakeOwner1', 'FakeEditor1', 'Closed Post 1 by Alice1');
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, ClosedDate, OwnerDisplayName, LastEditorDisplayName, Title) VALUES (20, 1, 4, '2021-05-02 12:00:00', 'FakeOwner2', 'FakeEditor2', 'Closed Post 2 by Alice1');
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, ClosedDate, OwnerDisplayName, LastEditorDisplayName, Title) VALUES (30, 2, 4, NULL, 'FakeOwner3', 'FakeEditor3', 'Open Post by Bob');
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, ClosedDate, OwnerDisplayName, LastEditorDisplayName, Title) VALUES (40, 3, 2, '2021-05-03 12:00:00', 'FakeOwner4', 'FakeEditor4', 'Closed Post by Alice2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.DisplayName FROM posts AS T1 INNER JOIN users AS T2 ON T1.OwnerUserId = T2.Id WHERE NOT T1.ClosedDate IS NULL;

/*
Gold Result:
('Alice',)
('Alice',)
('Alice',)
*/

-- Prediction Query
SELECT DISTINCT "users"."displayname" FROM "users" INNER JOIN "posts" ON "users"."id" = "posts"."owneruserid" WHERE NOT "posts"."closeddate" IS NULL;

/*
Prediction Result:
('Alice',)
*/