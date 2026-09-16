# Data Flow

The supplied data-flow diagram shows this sequence:

1. **User Input**
   - Plant (WERKS)
   - Material Number (MATNR)
   - Storage Location (LGORT)

2. **Data Retrieval**
   - Inventory data is fetched from MARD, MARA and MAKT using JOIN operations.

3. **Data Storage**
   - Retrieved data is stored in ABAP internal tables for in-memory processing.

4. **Filtering and Processing**
   - User-input filtering is applied.
   - Stock levels are evaluated using traffic-light indicators.
   - KPIs are calculated for total and low-stock items.

5. **Data Presentation**
   - Processed data is displayed through an ALV Grid.

6. **User Interaction**
   - A selected record can trigger a double-click event.

7. **Drill-Down Processing**
   - Movement information is retrieved from MSEG, MKPF and T156T.
   - Detailed movement history is displayed.

See `screenshots/architecture/data-flow.png` for the supplied data-flow diagram.
