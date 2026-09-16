# System Architecture

The SAP Inventory Management System follows a **three-layer architecture** consisting of the **Presentation Layer, Application Layer, and Data Layer**. This separation organizes user interaction, ABAP processing, business logic, and SAP data access into distinct components.

## 1. Presentation Layer

The Presentation Layer handles **user interaction and data visualization**.

### Components

- **Selection Screen**
  - Plant (`WERKS`)
  - Material Number (`MATNR`)
  - Storage Location (`LGORT`)

- **ALV (ABAP List Viewer) Grid**
  - Displays processed inventory data in a structured tabular format.
  - Supports interactive data viewing.
  - Provides sorting and filtering capabilities.
  - Improves readability through formatted output.
  - Allows users to select records for detailed analysis.

### Purpose

To provide a user-friendly interface for viewing and analyzing inventory information.

---

## 2. Application Layer

The Application Layer is responsible for **data processing and business logic implementation** using ABAP.

### Components

### Data Retrieval
- Fetches inventory information using ABAP Open SQL.
- Uses JOIN operations to combine relevant SAP standard tables.
- Retrieves the main inventory dataset from:
  - `MARD`
  - `MARA`
  - `MAKT`

### Data Processing
- Stores retrieved records in ABAP internal tables.
- Applies filtering based on user-selected parameters.
- Processes the retrieved inventory information before presentation.

### Business Logic Implementation
- Applies traffic-light indicators to classify stock levels.
- Calculates inventory KPIs.
- Identifies low-stock items for inventory monitoring.

### Event Handling
- Captures user interactions such as double-click events in the ALV.
- Identifies the selected material.
- Triggers the material movement drill-down functionality.

### Output to User
- Sends the processed inventory information to the Presentation Layer.
- Displays the results through the ALV Grid.

### Purpose

To transform retrieved inventory data into meaningful information and control the behavior of the reporting system.

---

## 3. Data Layer

The Data Layer stores and provides access to the **inventory and material-related SAP data** used by the application.

### SAP Standard Tables

| Table | Description |
|---|---|
| `MARD` | Stores stock quantities at plant and storage-location level |
| `MARA` | Contains general material information such as material type |
| `MAKT` | Stores material descriptions |
| `MSEG` | Contains material movement details |
| `MKPF` | Stores material document header information such as posting date |
| `T156T` | Provides descriptions of movement types |

### Main Data Flow

```text
MARD + MARA + MAKT
        |
        v
   ABAP Data Retrieval
        |
        v
   Internal Table Processing
        |
        v
 Stock Evaluation + KPI Calculation
        |
        v
      ALV Grid
        |
        | Double-Click
        v
MSEG + MKPF + T156T
        |
        v
Movement History ALV
