# Project Screenshots

This directory contains the screenshots and visual evidence associated with the **SAP Inventory Management System using ABAP and ALV**.

The screenshots document the system's ABAP implementation, inventory reporting output, KPI analysis, material-movement drill-down, system architecture, and data flow.

---

## 1. Output Screenshots

The following screenshots demonstrate the main system execution and reporting outputs.

| Screenshot | Description |
|---|---|
| [`01-selection-screen.png`](output/01-selection-screen.png) | Selection screen for entering Plant (`WERKS`), Material Number (`MATNR`), and Storage Location (`LGORT`). |
| [`02-alv-output.png`](output/02-alv-output.png) | Main ALV report displaying material, description, material type, plant, storage location, and stock information. |
| [`03-kpi-summary.png`](output/03-kpi-summary.png) | Inventory KPI summary showing total materials and low-stock items. |
| [`04-drill-down.png`](output/04-drill-down.png) | Detailed material movement drill-down containing movement and posting information. |

---

## 2. System Architecture

The architecture diagram represents the three-layer design of the system:

- Presentation Layer
- Application Layer
- Data Layer

**Architecture Diagram:**  
[`system-architecture.png`](architecture/system-architecture.png)

The architecture documentation is available in [`architecture.md`](../documentation/architecture.md).

---

## 3. Data Flow

The data-flow diagram illustrates the processing sequence from:

**User Input → Data Retrieval → Internal Table Processing → Filtering & Processing → ALV Presentation → User Interaction → Drill-Down**

**Data Flow Diagram:**  
[`data-flow.png`](architecture/data-flow.png)

The detailed explanation is available in [`data-flow.md`](../documentation/data-flow.md).

---

## 4. ABAP Code Evidence

The `code/` directory contains the **12 ABAP code screenshots** supplied in the project code document.

The screenshots show the implementation of:

- Selection parameters
- `TY_STOCK` structure
- `TY_MOVE` structure
- Internal tables
- MARD, MARA and MAKT data retrieval
- Inventory filtering
- Traffic-light stock classification
- KPI calculation
- ALV layout and field catalog
- Double-click event handling
- MSEG, MKPF and T156T movement retrieval
- Movement ALV display

### Code Screenshots

- [`Code 01`](code/code-01.png)
- [`Code 02`](code/code-02.png)
- [`Code 03`](code/code-03.png)
- [`Code 04`](code/code-04.png)
- [`Code 05`](code/code-05.png)
- [`Code 06`](code/code-06.png)
- [`Code 07`](code/code-07.png)
- [`Code 08`](code/code-08.png)
- [`Code 09`](code/code-09.png)
- [`Code 10`](code/code-10.png)
- [`Code 11`](code/code-11.png)
- [`Code 12`](code/code-12.png)

---

## 5. Screenshot Organization

```text
screenshots/
│
├── code/
│   ├── code-01.png
│   ├── code-02.png
│   ├── code-03.png
│   ├── code-04.png
│   ├── code-05.png
│   ├── code-06.png
│   ├── code-07.png
│   ├── code-08.png
│   ├── code-09.png
│   ├── code-10.png
│   ├── code-11.png
│   └── code-12.png
│
├── output/
│   ├── 01-selection-screen.png
│   ├── 02-alv-output.png
│   ├── 03-kpi-summary.png
│   └── 04-drill-down.png
│
├── architecture/
│   ├── system-architecture.png
│   └── data-flow.png
│
└── README.md
