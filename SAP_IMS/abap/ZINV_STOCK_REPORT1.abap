REPORT zinv_stock_report1.
TYPE-POOLS: slis.

*---------------------------------------------------------------*
* Selection Screen
*---------------------------------------------------------------*
PARAMETERS: p_werks TYPE werks_d,
            p_matnr TYPE matnr,
            p_lgort TYPE lgort_d.

*---------------------------------------------------------------*
* Stock Structure
*---------------------------------------------------------------*
TYPES: BEGIN OF ty_stock,
         matnr TYPE mard-matnr,
         maktx TYPE makt-maktx,
         werks TYPE mard-werks,
         lgort TYPE mard-lgort,
         labst TYPE mard-labst,
         mtart TYPE mara-mtart,
         light TYPE c LENGTH 1,
       END OF ty_stock.

*---------------------------------------------------------------*
* Movement Structure
*---------------------------------------------------------------*
TYPES: BEGIN OF ty_move,
         matnr TYPE mseg-matnr,
         mblnr TYPE mseg-mblnr,
         menge TYPE mseg-menge,
         bwart TYPE mseg-bwart,
         btext TYPE t156t-btext,
         budat TYPE mkpf-budat,
       END OF ty_move.

*---------------------------------------------------------------*
* Data
*---------------------------------------------------------------*
DATA: it_stock    TYPE STANDARD TABLE OF ty_stock WITH EMPTY KEY,
      it_move     TYPE STANDARD TABLE OF ty_move WITH EMPTY KEY,
      it_fieldcat TYPE slis_t_fieldcat_alv,
      wa_fieldcat TYPE slis_fieldcat_alv,
      wa_layout   TYPE slis_layout_alv,
      lv_total    TYPE i,
      lv_low      TYPE i.

*---------------------------------------------------------------*
* Fetch Data (INNER JOIN)
*---------------------------------------------------------------*
SELECT a~matnr, c~maktx, a~werks, a~lgort, a~labst, b~mtart
  FROM mard AS a
  INNER JOIN mara AS b ON a~matnr = b~matnr
  INNER JOIN makt AS c ON a~matnr = c~matnr
  INTO TABLE @it_stock
  UP TO 500 ROWS.

*---------------------------------------------------------------*
* Filtering
*---------------------------------------------------------------*
LOOP AT it_stock INTO DATA(ls_stock).

  IF p_werks IS NOT INITIAL AND ls_stock-werks <> p_werks.
    DELETE it_stock INDEX sy-tabix.
    CONTINUE.
  ENDIF.

  IF p_matnr IS NOT INITIAL AND ls_stock-matnr <> p_matnr.
    DELETE it_stock INDEX sy-tabix.
    CONTINUE.
  ENDIF.

  IF p_lgort IS NOT INITIAL AND ls_stock-lgort <> p_lgort.
    DELETE it_stock INDEX sy-tabix.
    CONTINUE.
  ENDIF.

ENDLOOP.

*---------------------------------------------------------------*
* Traffic Lights
*---------------------------------------------------------------*
LOOP AT it_stock ASSIGNING FIELD-SYMBOL(<fs>).

  IF <fs>-labst < 5000.
    <fs>-light = '3'.
  ELSEIF <fs>-labst < 10000.
    <fs>-light = '2'.
  ELSE.
    <fs>-light = '1'.
  ENDIF.

ENDLOOP.

*---------------------------------------------------------------*
* KPI Calculation
*---------------------------------------------------------------*
CLEAR: lv_total, lv_low.

LOOP AT it_stock INTO DATA(ls_kpi).

  lv_total = lv_total + 1.

  IF ls_kpi-labst < 5000.
    lv_low = lv_low + 1.
  ENDIF.

ENDLOOP.

*---------------------------------------------------------------*
* KPI Display
*---------------------------------------------------------------*
FORMAT COLOR COL_HEADING.
WRITE: / '*** INVENTORY SUMMARY ***'.
FORMAT RESET.

WRITE: / 'Total Materials:', lv_total.
WRITE: / 'Low Stock Items:', lv_low.
SKIP 2.

*---------------------------------------------------------------*
* Layout
*---------------------------------------------------------------*
wa_layout-lights_fieldname = 'LIGHT'.
wa_layout-zebra = 'X'.
wa_layout-colwidth_optimize = 'X'.

PERFORM build_fieldcat.

*---------------------------------------------------------------*
* Display ALV
*---------------------------------------------------------------*
CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
  EXPORTING
    i_callback_program      = sy-repid
    i_callback_user_command = 'USER_COMMAND'
    is_layout               = wa_layout
    it_fieldcat             = it_fieldcat
  TABLES
    t_outtab                = it_stock.

*---------------------------------------------------------------*
* Field Catalog
*---------------------------------------------------------------*
FORM build_fieldcat.

  PERFORM add_field USING 'MATNR' 'Material'.
  PERFORM add_field USING 'MAKTX' 'Description'.
  PERFORM add_field USING 'MTART' 'Material Type'.
  PERFORM add_field USING 'WERKS' 'Plant'.
  PERFORM add_field USING 'LGORT' 'Storage Location'.
  PERFORM add_field USING 'LABST' 'Stock'.

ENDFORM.

FORM add_field USING p_field p_text.

  wa_fieldcat-fieldname = p_field.
  wa_fieldcat-seltext_m = p_text.
  wa_fieldcat-hotspot = 'X'.

  APPEND wa_fieldcat TO it_fieldcat.
  CLEAR wa_fieldcat.

ENDFORM.

*---------------------------------------------------------------*
* Double Click Event
*---------------------------------------------------------------*
FORM user_command USING r_ucomm LIKE sy-ucomm
                        rs_selfield TYPE slis_selfield.

  IF r_ucomm = '&IC1' OR r_ucomm = 'PICK'.

    READ TABLE it_stock INDEX rs_selfield-tabindex
      INTO DATA(ls_stock).

    IF sy-subrc = 0.

      CLEAR it_move.

      SELECT a~matnr, a~mblnr, a~menge, a~bwart,
             d~btext, b~budat
        FROM mseg AS a
        INNER JOIN mkpf AS b ON a~mblnr = b~mblnr
        INNER JOIN t156t AS d ON a~bwart = d~bwart
        INTO TABLE @it_move
        UP TO 500 ROWS
        WHERE a~matnr = @ls_stock-matnr
          AND d~spras = @sy-langu
          AND ( a~bwart = '561'
             OR a~bwart = '562'
             OR a~bwart = '101'
             OR a~bwart = '261'
             OR a~bwart = '601' ).

      PERFORM display_movement.

    ENDIF.

  ENDIF.

ENDFORM.

*---------------------------------------------------------------*
* Movement ALV
*---------------------------------------------------------------*
FORM display_movement.

  DATA: it_fcat TYPE slis_t_fieldcat_alv.

  PERFORM add_fcat USING 'MATNR' 'Material' CHANGING it_fcat.
  PERFORM add_fcat USING 'MBLNR' 'Document' CHANGING it_fcat.
  PERFORM add_fcat USING 'MENGE' 'Quantity' CHANGING it_fcat.
  PERFORM add_fcat USING 'BWART' 'Move Type' CHANGING it_fcat.
  PERFORM add_fcat USING 'BTEXT' 'Move Description' CHANGING it_fcat.
  PERFORM add_fcat USING 'BUDAT' 'Posting Date' CHANGING it_fcat.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      it_fieldcat = it_fcat
    TABLES
      t_outtab = it_move.

ENDFORM.

FORM add_fcat USING p_field p_text
              CHANGING pt_fcat TYPE slis_t_fieldcat_alv.

  DATA: wa TYPE slis_fieldcat_alv.

  wa-fieldname = p_field.
  wa-seltext_m = p_text.

  APPEND wa TO pt_fcat.

ENDFORM.
