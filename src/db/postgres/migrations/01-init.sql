CREATE TABLE IF NOT EXISTS users(
    ID UUID PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create an enum type for transaction types if the enum has not yet been created.
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'transaction_type') THEN
        CREATE TYPE transaction_type AS ENUM ('EARNING', 'EXPENSE', 'INVESTIMENT');
    END IF;
END $$;

CREATE TABLE IF NOT EXISTS transactions(
    ID UUID PRIMARY KEY,
    user_id UUID REFERENCES users(ID),
    name VARCHAR(100) NOT NULL,
    date TIMESTAMP NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    type transaction_type NOT NULL
);