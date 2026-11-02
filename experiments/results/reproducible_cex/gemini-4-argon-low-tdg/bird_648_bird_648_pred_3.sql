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
-- Tests exact boundary conditions on FavoriteCount (150, 151, 149, NULL), duplicate rows vs DISTINCT/GROUP BY, and wrong numeric column usage.
INSERT INTO users (Id, DisplayName, WebsiteUrl, Reputation, Views, UpVotes, DownVotes, AccountId, Age, Location, AboutMe, ProfileImageUrl) VALUES (1, 'Alice', 'https://alice.dev', 10, 5, 2, 1, 1001, 25, 'LocA', 'BioA', 'ImgA');
INSERT INTO users (Id, DisplayName, WebsiteUrl, Reputation, Views, UpVotes, DownVotes, AccountId, Age, Location, AboutMe, ProfileImageUrl) VALUES (2, 'Bob', 'https://bob.org', 200, 300, 200, 200, 200, 40, 'LocB', 'BioB', 'ImgB');
INSERT INTO users (Id, DisplayName, WebsiteUrl, Reputation, Views, UpVotes, DownVotes, AccountId, Age, Location, AboutMe, ProfileImageUrl) VALUES (3, 'Charlie', 'https://charlie.net', 50, 50, 50, 50, 1003, 30, 'LocC', 'BioC', 'ImgC');
INSERT INTO users (Id, DisplayName, WebsiteUrl, Reputation, Views, UpVotes, DownVotes, AccountId, Age, Location, AboutMe, ProfileImageUrl) VALUES (4, 'Diana', NULL, 20, 10, 5, 0, 1004, 28, 'LocD', 'BioD', 'ImgD');
INSERT INTO posts (Id, OwnerUserId, FavoriteCount, Score, ViewCount, AnswerCount, CommentCount, PostTypeId, AcceptedAnswerId, LastEditorUserId, ParentId, OwnerDisplayName, LastEditorDisplayName) VALUES (101, 1, 151, 10, 20, 1, 2, 1, NULL, 2, NULL, 'FakeAlice', 'Bob');
INSERT INTO posts (Id, OwnerUserId, FavoriteCount, Score, ViewCount, AnswerCount, CommentCount, PostTypeId, AcceptedAnswerId, LastEditorUserId, ParentId, OwnerDisplayName, LastEditorDisplayName) VALUES (102, 1, 200, 5, 10, 0, 0, 1, NULL, 2, NULL, 'FakeAlice2', 'Bob');
INSERT INTO posts (Id, OwnerUserId, FavoriteCount, Score, ViewCount, AnswerCount, CommentCount, PostTypeId, AcceptedAnswerId, LastEditorUserId, ParentId, OwnerDisplayName, LastEditorDisplayName) VALUES (103, 2, 150, 500, 1000, 200, 200, 1, NULL, 1, NULL, 'Bob', 'Alice');
INSERT INTO posts (Id, OwnerUserId, FavoriteCount, Score, ViewCount, AnswerCount, CommentCount, PostTypeId, AcceptedAnswerId, LastEditorUserId, ParentId, OwnerDisplayName, LastEditorDisplayName) VALUES (104, 3, 149, 300, 400, 5, 10, 1, NULL, 1, NULL, 'Charlie', 'Alice');
INSERT INTO posts (Id, OwnerUserId, FavoriteCount, Score, ViewCount, AnswerCount, CommentCount, PostTypeId, AcceptedAnswerId, LastEditorUserId, ParentId, OwnerDisplayName, LastEditorDisplayName) VALUES (105, 3, NULL, 250, 350, 2, 1, 1, NULL, 1, NULL, 'Charlie', 'Alice');
INSERT INTO posts (Id, OwnerUserId, FavoriteCount, Score, ViewCount, AnswerCount, CommentCount, PostTypeId, AcceptedAnswerId, LastEditorUserId, ParentId, OwnerDisplayName, LastEditorDisplayName) VALUES (106, 4, 155, 1, 1, 0, 0, 1, NULL, 4, NULL, 'Diana', 'Diana');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.DisplayName, T1.WebsiteUrl FROM users AS T1 INNER JOIN posts AS T2 ON T1.Id = T2.OwnerUserId WHERE T2.FavoriteCount > 150;

/*
Gold Result:
('Alice', 'https://alice.dev')
('Alice', 'https://alice.dev')
('Diana', None)
*/

-- Prediction Query
SELECT u.DisplayName, u.WebsiteUrl FROM posts AS p JOIN users AS u ON p.OwnerUserId = u.Id WHERE p.FavoriteCount > 150 AND NOT u.WebsiteUrl IS NULL;

/*
Prediction Result:
('Alice', 'https://alice.dev')
('Alice', 'https://alice.dev')
*/