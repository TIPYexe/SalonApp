# SQL Salon App

# Database Schema and Tables

This repository contains an SQL file that defines the database schema and tables for a salon management system. The schema includes tables for managing clients, employees, services, appointments, products, and more. The file also includes sample data to populate the tables.

## Tables

The SQL file includes the following tables:

- **clienti**: Stores information about salon clients, such as their ID, name, contact details, and membership points.
- **oferte**: Manages available offers with their descriptions, expiration dates, and associated loyalty points.
- **salon**: Contains details about the salon, including its ID, name, address, and contact information.
- **angajati**: Stores information about salon employees, including their ID, name, contact details, and associated salon.
- **serviciu**: Manages salon services, including their ID, price, and duration.
- **programari**: Tracks appointments made by clients, including appointment ID, date, employee ID, client ID, and service ID.
- **stoc**: Keeps track of the salon's inventory items by storing their ID and description.
- **produse**: Stores information about products available in the salon, including their barcode, quantity, name, price, and selling price.
- **cos**: Manages shopping carts for clients, with each cart having a unique ID and associated client ID.
- **oferte_disponibile**: Tracks the availability of offers for each client, with entries for offer ID and client ID.
- **meserie**: Establishes a many-to-many relationship between employees and services, associating each employee ID with the services they can perform.
- **nr_prod**: Tracks the quantity of products in each shopping cart, with entries for cart ID, product barcode, and quantity.
- **produse_in_stoc**: Manages the relationship between inventory items and products, associating each product with its stock ID and barcode.

## Usage

To use this SQL file, you can import it into your preferred database management system. The file includes table creation statements, constraints, and sample data insertion statements. You can customize the schema, modify the data, or add additional tables based on your specific requirements.

Feel free to explore the structure of the tables and use them as a foundation for developing a salon management system or related applications.

Please note that this SQL file is provided as a starting point and may require further modifications or enhancements based on your specific needs.
