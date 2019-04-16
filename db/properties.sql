DROP TABLE IF EXISTS properties;

CREATE TABLE properties(
  id SERIAL2 PRIMARY KEY,
  address VARCHAR(255),
  value INT4,
  number_of_bedrooms INT2,
  buy_status BOOLEAN
);
