# 🚗 AutoQuery: Vehicle Database Management System

AutoQuery is a complete SQL Server project designed to manage vehicle registrations, ownership transfers, and compliance tracking. This system simulates a real-world DMV-like database, using advanced SQL features like stored procedures, triggers, and audit tables to ensure accurate and secure data handling.

---

## 📌 Project Highlights

- ✅ **Structured Vehicle & Owner Registration**
- 🔄 **Audit Trails via Triggers** — Tracks changes to ownership
- ⚙️ **Stored Procedures** — Automates data entry, transfer, and deletion
- 🧾 **Audit Tables** — Maintains logs for historical compliance
- 🔍 **Supports Reporting** — Easily extendable to Power BI / analytics

---

## 🛠️ Tech Stack

- **SQL Server (SSMS / Azure SQL)**
- **T-SQL: Stored Procedures, Triggers, Views**
- **Visual Studio / GitHub for Versioning**
- *(Optional for future)*: Power BI for visualization

---

## 📂 Repository Structure

Auto-Query/
│
├── SQL Scripts/                      # All SQL code files
│   ├── Tables.sql                   # Scripts to create core tables (Vehicles, Owners, Ownership)
│   ├── StoredProcedures.sql         # Procedures for inserting, updating, and managing records
│   ├── Triggers.sql                 # Triggers to log changes and ensure data integrity
│   └── AuditTables.sql              # Audit table creation for logging historical changes
│
├── Documentation/                   # Project documentation and visual aids
│   ├── ProjectDescription.md        # Brief technical summary of the project
│   ├── ERDiagram.png                # Visual entity-relationship diagram 
│       
│
├── README.md                        # Project overview and setup guide

---

## 🧱 Core Tables

- `Vehicles`: Details of registered vehicles
- `Owners`: Personal and contact information
- `VehicleOwnership`: Links each vehicle to current/past owners
- `VehicleOwnershipAudit`: Captures audit logs via triggers

---

## ⚙️ Features via Stored Procedures

- `InsertVehicle`, `InsertOwner`, `AssignOwnership`
- `TransferOwnership` and ownership-end logic
- Simplifies CRUD operations with parameterized input

---

## 🔄 Triggers & Auditing

- Triggers on `VehicleOwnership` table capture:
  - Insertions (new ownership)
  - Updates (transfers)
  - Deletions (revocations)

- All actions are logged into the `VehicleOwnershipAudit` table for historical tracking and compliance.

---

## 🧩 ER Diagram

A visual overview of the system's database schema:

![ER Diagram](./Documentation/ERDiagram.png)
---

## 💡 Outcomes

- 🚀 **90% reduction in manual updates** through automation
- 📈 **Fully auditable system** with built-in integrity
- 🔍 **Supports real-time queries** for reporting tools

---

## 👨‍💻 Author

**Uday Sai Kiran Reddy Gadam**  
📧 [udaysaikor@gmail.com](mailto:udaysaikor@gmail.com)  
🎓 MS in Business Analytics & AI, University of Texas at Dallas  


---

> 🌟 Star this project if you found it useful or would like to build on it!


