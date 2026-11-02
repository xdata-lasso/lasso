CREATE TABLE event (
    event_id text PRIMARY KEY,
    event_name text,
    event_date text,
    type text,
    notes text,
    location text,
    status text
);

CREATE TABLE major (
    major_id text PRIMARY KEY,
    major_name text,
    department text,
    college text
);

CREATE TABLE member (
    member_id text PRIMARY KEY,
    first_name text,
    last_name text,
    email text,
    "position" text,
    t_shirt_size text,
    phone text,
    zip bigint,
    link_to_major text REFERENCES major(major_id)
);

CREATE TABLE budget (
    budget_id text PRIMARY KEY,
    category text,
    spent real,
    remaining real,
    amount bigint,
    event_status text,
    link_to_event text REFERENCES event(event_id)
);

CREATE TABLE expense (
    expense_id text PRIMARY KEY,
    expense_description text UNIQUE,
    expense_date text,
    cost real,
    approved text,
    link_to_member text REFERENCES member(member_id),
    link_to_budget text REFERENCES budget(budget_id)
);

CREATE TABLE attendance (
    link_to_event text REFERENCES event(event_id),
    link_to_member text REFERENCES member(member_id),
    PRIMARY KEY (link_to_event, link_to_member)
);
