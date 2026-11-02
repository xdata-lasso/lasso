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
-- Tests basic filtering (ParentId IS NOT NULL vs IS NULL), ordering by Score DESC, and foreign key join on OwnerUserId vs LastEditorUserId.
INSERT INTO users (Id, Reputation, DisplayName) VALUES (1, 100, 'Alice_QuestionOwner');
INSERT INTO users (Id, Reputation, DisplayName) VALUES (2, 200, 'Bob_TopAnswerOwner');
INSERT INTO users (Id, Reputation, DisplayName) VALUES (3, 150, 'Charlie_LowAnswerOwner');
INSERT INTO users (Id, Reputation, DisplayName) VALUES (4, 300, 'Dave_Editor');
-- Post 10: High score (100), but ParentId IS NULL (should be excluded)
INSERT INTO posts (Id, PostTypeId, Score, OwnerUserId, LastEditorUserId, ParentId, OwnerDisplayName) VALUES (10, 1, 100, 1, 4, NULL, 'FakeAlice');
-- Post 20: Highest score among answers (50), ParentId IS NOT NULL (should be selected -> Bob)
INSERT INTO posts (Id, PostTypeId, Score, OwnerUserId, LastEditorUserId, ParentId, OwnerDisplayName) VALUES (20, 2, 50, 2, 4, 10, 'FakeBob');
-- Post 30: Lower score among answers (10), ParentId IS NOT NULL (kills Score ASC or MIN(Score) mutants -> Charlie)
INSERT INTO posts (Id, PostTypeId, Score, OwnerUserId, LastEditorUserId, ParentId, OwnerDisplayName) VALUES (30, 2, 10, 3, 4, 10, 'FakeCharlie');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DisplayName FROM users WHERE Id = (SELECT OwnerUserId FROM posts WHERE NOT ParentId IS NULL ORDER BY Score DESC, posts.id NULLS LAST LIMIT 1);

/*
Gold Result:
('Bob_TopAnswerOwner',)
*/

-- Prediction Query
SELECT T3.DisplayName FROM posts AS T1 INNER JOIN posts AS T2 ON T1.ParentId = T2.Id INNER JOIN users AS T3 ON T2.OwnerUserId = T3.Id WHERE NOT T1.ParentId IS NULL ORDER BY T1.Score DESC, T1.id NULLS LAST, T2.id NULLS LAST, T3.id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Alice_QuestionOwner',)
*/