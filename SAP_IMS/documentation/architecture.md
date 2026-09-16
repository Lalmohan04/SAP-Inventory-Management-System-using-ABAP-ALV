# System Architecture

The supplied architecture diagram describes a three-layer SAP inventory-management design.

## 1. Presentation Layer
- Selection screen for Plant (WERKS), Material Number (MATNR), and Storage Location (LGORT)
- ALV (ABAP List Viewer) grid
- Interactive display, sorting/filtering, readable formatting and clickable rows

## 2. Application Layer
- Data retrieval using SQL/JOIN operations
- Internal-table data processing
- Traffic-light stock evaluation
- KPI calculation
- Event handling for double-click/drill-down
- Output returned to the ALV presentation layer

## 3. Data Layer
The supplied architecture identifies:
- MARD — stock quantities
- MARA — material information
- MAKT — material descriptions
- MSEG — material movement details
- MKPF — document header/posting date
- T156T — movement type descriptions

See `screenshots/architecture/system-architecture.png` for the supplied architecture diagram.
