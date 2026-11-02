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
-- DATASET 2
-- Tests: Multiple users tied for the maximum reputation, presence of NULL reputation, and lack of activity in child tables for maximum reputation users.
-- Refutes: Mutants using ORDER BY Reputation DESC LIMIT 1 (would only return 1 row instead of 2), NULL handling mistakes, and unnecessary INNER JOINs with badges/posts/comments/votes.
INSERT INTO users (Id, Reputation, DisplayName, Views, UpVotes, DownVotes, AccountId, Age) VALUES (10, 1000, 'MaxUser1', 10, 5, 1, 10, 25);
INSERT INTO users (Id, Reputation, DisplayName, Views, UpVotes, DownVotes, AccountId, Age) VALUES (20, 1000, 'MaxUser2', 20, 15, 2, 20, 35);
INSERT INTO users (Id, Reputation, DisplayName, Views, UpVotes, DownVotes, AccountId, Age) VALUES (30, 200, 'ActiveLowRepUser', 999, 999, 99, 30, 40);
INSERT INTO users (Id, Reputation, DisplayName, Views, UpVotes, DownVotes, AccountId, Age) VALUES (40, NULL, 'NullRepUser', 888, 888, 88, 40, 50);
INSERT INTO badges (Id, UserId, Name, Date) VALUES (1, 30, 'Popular', '2023-01-01 10:00:00');
INSERT INTO posts (Id, PostTypeId, OwnerUserId, Score, ViewCount, Title) VALUES (1, 1, 30, 50, 100, 'Sample Post');
INSERT INTO comments (Id, PostId, UserId, Score, Text) VALUES (1, 1, 30, 10, 'Sample Comment');
INSERT INTO votes (Id, PostId, VoteTypeId, UserId, BountyAmount) VALUES (1, 1, 2, 30, 50);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT Id FROM users WHERE Reputation = (SELECT MAX(Reputation) FROM users);

/*
Gold Result:
(10,)
(20,)
*/

-- Prediction Query
SELECT "id" FROM "users" ORDER BY "reputation" DESC, users.id NULLS LAST LIMIT 1;

/*
Prediction Result:
(10,)
*/