CREATE TABLE major (
    major_id text NOT NULL,
    major_name varchar,
    department varchar,
    college varchar,
    PRIMARY KEY (major_id)
);

CREATE TABLE zip_code (
    zip_code bigint NOT NULL,
    type varchar,
    city varchar,
    county varchar,
    state varchar,
    short_state varchar,
    PRIMARY KEY (zip_code)
);

CREATE TABLE event (
    event_id text NOT NULL,
    event_name varchar,
    event_date varchar,
    type varchar,
    notes varchar,
    location varchar,
    status varchar,
    PRIMARY KEY (event_id)
);

CREATE TABLE member (
    member_id text NOT NULL,
    first_name varchar,
    last_name varchar,
    email varchar,
    position varchar,
    t_shirt_size varchar,
    phone varchar,
    zip integer,
    link_to_major varchar,
    PRIMARY KEY (member_id),
    FOREIGN KEY (link_to_major) REFERENCES major (major_id),
    FOREIGN KEY (zip) REFERENCES zip_code (zip_code)
);

CREATE TABLE attendance (
    link_to_event text NOT NULL,
    link_to_member text NOT NULL,
    PRIMARY KEY (link_to_event, link_to_member),
    FOREIGN KEY (link_to_event) REFERENCES event (event_id),
    FOREIGN KEY (link_to_member) REFERENCES member (member_id)
);

CREATE TABLE budget (
    budget_id text NOT NULL,
    category varchar,
    spent real,
    remaining real,
    amount integer,
    event_status varchar,
    link_to_event varchar,
    PRIMARY KEY (budget_id),
    FOREIGN KEY (link_to_event) REFERENCES event (event_id)
);

CREATE TABLE expense (
    expense_id text NOT NULL,
    expense_description varchar,
    expense_date varchar,
    cost real,
    approved varchar,
    link_to_member varchar,
    link_to_budget varchar,
    PRIMARY KEY (expense_id),
    FOREIGN KEY (link_to_budget) REFERENCES budget (budget_id)
    FOREIGN KEY (link_to_member) REFERENCES member (member_id)
);

CREATE TABLE income (
    income_id text NOT NULL,
    date_received varchar,
    amount integer,
    source varchar,
    notes varchar,
    link_to_member varchar,
    PRIMARY KEY (income_id),
    FOREIGN KEY (link_to_member) REFERENCES member (member_id)
);
