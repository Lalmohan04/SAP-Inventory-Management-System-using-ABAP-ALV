# Data Flow

The SAP Inventory Management System follows a structured data flow from **user input and inventory data retrieval to processing, ALV presentation, user interaction, and material-movement drill-down**.

## 1. User Input

The process begins when the user enters filtering parameters through the SAP selection screen.

### Input Parameters

- **Plant (`WERKS`)**
- **Material Number (`MATNR`)**
- **Storage Location (`LGORT`)**

These parameters determine the inventory records that are considered during processing.

---

## 2. Data Retrieval

The ABAP program retrieves inventory information from SAP standard tables using Open SQL and JOIN operations.

### Main Tables

- `MARD` — Stock quantities at plant and storage-location level
- `MARA` — General material information
- `MAKT` — Material descriptions

The retrieved information forms the main inventory dataset used by the application.

---

## 3. Data Storage

The retrieved records are stored temporarily in **ABAP internal tables**.

The internal tables provide an in-memory structure for:

- storing retrieved inventory records;
- applying user-defined filtering;
- evaluating stock levels;
- calculating inventory KPIs;
- preparing data for ALV presentation.

The main inventory internal table is represented by the `TY_STOCK` structure in the ABAP program.

---

## 4. Filtering and Processing

After retrieval, the program processes the inventory records according to the user's selection parameters.

### Filtering

The program checks:

- Plant (`P_WERKS`)
- Material Number (`P_MATNR`)
- Storage Location (`P_LGORT`)

Only records satisfying the specified parameters are retained.

### Stock Evaluation

The program applies traffic-light indicators based on stock quantity:

| Stock Quantity | Status |
|---|---|
| `< 5000` | Low |
| `5000–<10000` | Medium |
| `>= 10000` | High |

### KPI Calculation

The program calculates:

- **Total Materials**
- **Low Stock Items**

These values are displayed as an inventory summary.

---

## 5. Data Presentation

The processed inventory records are presented through an **ALV Grid**.

The ALV output provides a structured view containing fields such as:

- Material
- Description
- Material Type
- Plant
- Storage Location
- Stock

The ALV layout also supports formatted presentation and traffic-light indicators for stock status.

---

## 6. User Interaction

The ALV report allows the user to interact with individual inventory records.

When a material record is selected through a **double-click event**, the ABAP event-handling logic identifies the selected material.

This interaction triggers the next stage of the process: material movement drill-down.

---

## 7. Drill-Down Processing

The drill-down retrieves detailed movement information for the selected material.

### Movement Tables

- `MSEG` — Material movement details
- `MKPF` — Material document header information, including posting date
- `T156T` — Movement type descriptions

### Movement Information

The detailed movement ALV displays:

- Material
- Document
- Quantity
- Movement Type
- Movement Description
- Posting Date

This provides a more detailed view of the selected material's movement history.

---

# Complete Data Flow

```text
+-----------------------------+
| 1. USER INPUT               |
|                             |
| WERKS | MATNR | LGORT       |
+-------------+---------------+
              |
              v
+-----------------------------+
| 2. DATA RETRIEVAL           |
|                             |
| MARD | MARA | MAKT          |
|      JOIN Operations        |
+-------------+---------------+
              |
              v
+-----------------------------+
| 3. DATA STORAGE             |
|                             |
| ABAP Internal Tables        |
| In-Memory Processing        |
+-------------+---------------+
              |
              v
+-----------------------------+
| 4. FILTERING & PROCESSING   |
|                             |
| User Filters                |
| Stock Evaluation            |
| KPI Calculation             |
+-------------+---------------+
              |
              v
+-----------------------------+
| 5. DATA PRESENTATION        |
|                             |
| Interactive ALV Grid        |
+-------------+---------------+
              |
              v
+-----------------------------+
| 6. USER INTERACTION         |
|                             |
| Double-Click Selected Row   |
+-------------+---------------+
              |
              v
+-----------------------------+
| 7. DRILL-DOWN PROCESSING    |
|                             |
| MSEG | MKPF | T156T         |
|                             |
| Detailed Movement History   |
+-----------------------------+
