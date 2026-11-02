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
-- 1. Multiple users tied for the minimum Views (refutes ORDER BY Views ASC LIMIT 1).
-- 2. NULL values in Views (refutes ORDER BY Views ASC without NULLS LAST, as SQLite sorts NULLs first).
-- 3. Negative values in Views (refutes hardcoded Views = 0).
-- 4. Distinct values in other numeric columns (Reputation, UpVotes, DownVotes, Age, AccountId) to refute wrong column selection.
-- 5. Unrelated posts with ViewCount to refute selecting from the wrong table (posts vs users).
INSERT INTO users (Id, Reputation, Views, UpVotes, DownVotes, AccountId, Age, DisplayName) VALUES (1, 500, 10, 5, 100, 1000, 25, 'Alice');
INSERT INTO users (Id, Reputation, Views, UpVotes, DownVotes, AccountId, Age, DisplayName) VALUES (2, 100, -5, 50, 2, 200, 18, 'Bob');
INSERT INTO users (Id, Reputation, Views, UpVotes, DownVotes, AccountId, Age, DisplayName) VALUES (3, 1, -5, 20, 10, 300, 40, 'Charlie');
INSERT INTO users (Id, Reputation, Views, UpVotes, DownVotes, AccountId, Age, DisplayName) VALUES (4, 50, NULL, 0, 0, 50, 12, 'NullUser');
INSERT INTO users (Id, Reputation, Views, UpVotes, DownVotes, AccountId, Age, DisplayName) VALUES (5, 1000, 100, 1, 50, 10, 99, 'MaxUser');
INSERT INTO posts (Id, OwnerUserId, ViewCount, Score) VALUES (101, 1, -100, -50);
INSERT INTO posts (Id, OwnerUserId, ViewCount, Score) VALUES (102, 5, -100, -50);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT Id FROM users WHERE Views = (SELECT MIN(Views) FROM users);

/*
Gold Result:
(2,)
(3,)
*/

-- Prediction Query
SELECT Id FROM users ORDER BY Views ASC, users.id NULLS LAST LIMIT 1;

/*
Prediction Result:
(4,)
*/