# Inventory Management App

## Overview
The Inventory Management App is a mobile application designed to help users efficiently manage their inventory, sales, and customer transactions. It includes features for user authentication, inventory tracking, sales recording, and generating reports in multiple formats.

## Features

### 1. User Authentication
- Predefined login credentials:
  - **Email**: user@gmail.com
  - **Password**: 123456

### 2. Inventory Management
- Add new inventory items with details such as name, description, quantity, and price.
- Perform CRUD (Create, Read, Update, Delete) operations on inventory items.
- Search items by name or description.
- Add and manage customers with details like name, address, and mobile number.

### 3. Sales
- Record sales transactions including date, quantity, and customer (or cash sale).

### 4. Reports
- **Sales Report**: Overview of sales transactions.
- **Items Report**: Detailed list of inventory items.
- **Customer Ledger**: Displays all transactions related to a customer.

### 5. Data Export
- Export reports in various formats:
  - **Print**
  - **Excel**
  - **PDF**
  - **Email**

## Technologies Used
- **Flutter** for the frontend.
- **Riverpod** for state management.
- **Realm Database** for local data storage.
- **Syncfusion_flutter_pdf & xlsio** for report generation.

## Installation & Setup
1. Clone the repository:
   ```bash
   https://github.com/Afnanappu/inventory_management_app_task.git
   cd inventory_management_app
   ```
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Run the application:
   ```bash
   flutter run
   ```

## Usage
- Login using predefined credentials.
- Navigate through the app to manage inventory, record sales, and generate reports.
- Export data in multiple formats for better reporting and tracking.

## License
This project is licensed under the MIT License.