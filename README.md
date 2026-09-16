# SAP Inventory Management System using ABAP & ALV

## An Interactive and Intelligent Inventory Monitoring Solution

A **SAP ABAP-based Inventory Management System** developed using **ABAP and ALV (ABAP List Viewer)** for inventory monitoring, stock analysis, KPI reporting, and material movement drill-down.

The project demonstrates backend-oriented SAP development using **ABAP Open SQL, JOIN operations, internal tables, ALV reporting, event handling, and SAP standard tables**.

> **Source and Reconstruction Note:**  
> The ABAP source in this repository is a portfolio reconstruction based on the supplied ABAP code screenshots and project documentation. It is not an exported copy of the original SAP system object.

---

## Project Overview

The system provides an interactive inventory monitoring and reporting solution that retrieves material and stock information from SAP standard tables, processes the data using ABAP, and presents the results through an ALV Grid.

The documented implementation includes:

- Inventory data retrieval using ABAP Open SQL
- JOIN operations between SAP standard tables
- Dynamic filtering by Plant, Material, and Storage Location
- ABAP internal-table processing
- Stock-level traffic-light indicators
- Inventory KPI calculation
- Interactive ALV reporting
- Double-click event handling
- Material movement drill-down
- Movement analysis using SAP material-document tables

---

## Key Features

### 1. Inventory Data Retrieval

The main inventory information is retrieved from:

```text
MARD + MARA + MAKT
        |
        v
ABAP Internal Table
        |
        v
Inventory Processing
