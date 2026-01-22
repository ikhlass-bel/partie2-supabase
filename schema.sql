CREATE TABLE customers (
  customer_id SERIAL PRIMARY KEY,
  name TEXT,
  email TEXT
);

CREATE TABLE accounts (
  account_id SERIAL PRIMARY KEY,
  customer_id INT,
  balance NUMERIC
);

CREATE TABLE audit_logs (
  log_id SERIAL PRIMARY KEY,
  user_id UUID,
  action VARCHAR(100),
  table_name VARCHAR(50),
  record_id INT,
  ip_address VARCHAR(45),
  created_at TIMESTAMP DEFAULT NOW()
);
