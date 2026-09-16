# SAP Inventory Management System

A SAP ABAP-based inventory monitoring and reporting project using **ALV (ABAP List Viewer)**.

This directory contains the reconstructed ABAP source, project documentation, implementation evidence, screenshots, and portfolio presentation for the **Inventory Management System using SAP ABAP with ALV**.

> **Source and Reconstruction Note:**  
> The ABAP source in this repository is a portfolio reconstruction based on the supplied ABAP code screenshots and project documentation. It is not an exported copy of the original SAP system object.

---

## Project Overview

The system is designed to monitor inventory information and provide an interactive reporting interface using SAP ABAP and ALV.

The documented implementation includes:

- Inventory data retrieval using SAP standard tables
- JOIN operations using `MARD`, `MARA`, and `MAKT`
- User-based filtering using Plant, Material, and Storage Location
- ABAP internal-table processing
- Stock-level traffic-light indicators
- Inventory KPI calculation
- Interactive ALV reporting
- Double-click material drill-down
- Material movement analysis using `MSEG`, `MKPF`, and `T156T`

---

## Technology Stack

| Category | Technology |
|---|---|
| ERP Platform | SAP |
| Programming Language | ABAP |
| Reporting | ALV / `REUSE_ALV_GRID_DISPLAY` |
| Database Access | ABAP Open SQL / JOIN |
| Data Processing | ABAP Internal Tables |
| Development Environment | SAP GUI / ABAP Editor (SE38) |

---

## SAP Tables Used

### Inventory Data

| Table | Purpose |
|---|---|
| `MARD` | Stock quantities at plant and storage-location level |
| `MARA` | General material information |
| `MAKT` | Material descriptions |

### Movement Drill-Down

| Table | Purpose |
|---|---|
| `MSEG` | Material movement details |
| `MKPF` | Material document header and posting date |
| `T156T` | Movement type descriptions |

---

## User Selection

The selection screen provides the following parameters:

| Parameter | Description |
|---|---|
| `P_WERKS` | Plant |
| `P_MATNR` | Material Number |
| `P_LGORT` | Storage Location |

These parameters are used to filter the inventory records before displaying the main ALV report.

---

## Main Features

### 1. Inventory Reporting

Inventory information is retrieved from:

```text
MARD + MARA + MAKT
        |
        v
ABAP Internal Table
        |
        v
Inventory Processing
        |
        v
Main ALV Report
