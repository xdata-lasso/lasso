-- Relational schema for ManyRowsBM benchmark suite.
-- Universal schema compatible with SQLite, PostgreSQL, and MySQL.

CREATE TABLE customers (
  customer_id INTEGER PRIMARY KEY,
  customer_name VARCHAR(100) NOT NULL UNIQUE,
  country VARCHAR(50) NOT NULL,
  tier VARCHAR(20) NOT NULL CHECK (tier IN ('BRONZE', 'SILVER', 'GOLD', 'PLATINUM')),
  credit_limit DECIMAL(10, 2) NOT NULL CHECK (credit_limit >= 0)
);

CREATE TABLE categories (
  category_id INTEGER PRIMARY KEY,
  category_name VARCHAR(100) NOT NULL UNIQUE,
  department VARCHAR(50) NOT NULL CHECK (department IN ('ELECTRONICS', 'HOME', 'APPAREL', 'GROCERY', 'TOYS', 'SPORTS'))
);

CREATE TABLE products (
  product_id INTEGER PRIMARY KEY,
  category_id INTEGER NOT NULL,
  product_name VARCHAR(100) NOT NULL UNIQUE,
  price DECIMAL(10, 2) NOT NULL CHECK (price > 0),
  stock_quantity INTEGER NOT NULL CHECK (stock_quantity >= 0),
  FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

CREATE TABLE orders (
  order_id INTEGER PRIMARY KEY,
  customer_id INTEGER NOT NULL,
  order_date VARCHAR(20) NOT NULL,
  order_status VARCHAR(20) NOT NULL CHECK (order_status IN ('PENDING', 'PAID', 'SHIPPED', 'DELIVERED', 'CANCELLED', 'RETURNED')),
  total_amount DECIMAL(10, 2) NOT NULL CHECK (total_amount >= 0),
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
  item_id INTEGER PRIMARY KEY,
  order_id INTEGER NOT NULL,
  product_id INTEGER NOT NULL,
  quantity INTEGER NOT NULL CHECK (quantity > 0),
  unit_price DECIMAL(10, 2) NOT NULL CHECK (unit_price > 0),
  discount DECIMAL(4, 2) NOT NULL CHECK (discount >= 0 AND discount <= 1.0),
  UNIQUE (order_id, product_id),
  FOREIGN KEY (order_id) REFERENCES orders(order_id),
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE shipments (
  shipment_id INTEGER PRIMARY KEY,
  order_id INTEGER NOT NULL UNIQUE,
  carrier VARCHAR(50) NOT NULL CHECK (carrier IN ('UPS', 'FEDEX', 'DHL', 'USPS')),
  tracking_status VARCHAR(20) NOT NULL CHECK (tracking_status IN ('LABEL_CREATED', 'IN_TRANSIT', 'OUT_FOR_DELIVERY', 'DELIVERED', 'LOST')),
  delivery_days INTEGER NOT NULL CHECK (delivery_days >= 0),
  FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

CREATE TABLE customer_events (
  event_id INTEGER PRIMARY KEY,
  customer_id INTEGER NOT NULL,
  event_type VARCHAR(50) NOT NULL CHECK (event_type IN ('VIEW', 'CLICK', 'ADD_TO_CART', 'CHECKOUT', 'PURCHASE', 'LOGOUT')),
  page_url VARCHAR(200) NOT NULL,
  duration_seconds INTEGER NOT NULL CHECK (duration_seconds > 0),
  event_seq INTEGER NOT NULL CHECK (event_seq >= 1),
  UNIQUE (customer_id, event_seq),
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE sensor_telemetry (
  telemetry_id INTEGER PRIMARY KEY,
  device_id INTEGER NOT NULL,
  metric_name VARCHAR(50) NOT NULL CHECK (metric_name IN ('TEMP', 'PRESSURE', 'HUMIDITY', 'VOLTAGE')),
  metric_value DECIMAL(10, 2) NOT NULL,
  reading_seq INTEGER NOT NULL CHECK (reading_seq >= 1),
  UNIQUE (device_id, metric_name, reading_seq)
);

CREATE TABLE inventory_logs (
  log_id INTEGER PRIMARY KEY,
  product_id INTEGER NOT NULL,
  change_type VARCHAR(20) NOT NULL CHECK (change_type IN ('RESTOCK', 'SALE', 'ADJUSTMENT', 'RETURN')),
  change_amount INTEGER NOT NULL,
  log_seq INTEGER NOT NULL CHECK (log_seq >= 1),
  UNIQUE (product_id, log_seq),
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);
