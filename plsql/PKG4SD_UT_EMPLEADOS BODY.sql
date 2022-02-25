create or replace Package Body PKG4SD_UT_EMPLEADOS As 
/*==============================================================*/
/* SISTEMA:     PACKAGE UTIL           					*/
/* PAQUETE:     PKG4SD_UT_EMPLEADOS.sql     	                    */
/* DESCRIPCION: UTILIDADES PARA: EMPLEADOS       			    */
/* AUTOR:       David Forero							        */
/* FECHA:       05/02/2022                                      */
/*==============================================================*/
  /* Declaraci�n de variable tipo cursor */
  -------------------------------------------------------------------------------
  --  CURSOR EXPLICITO PARA CONTAR LOS REGISTROS DE EMPLEADOS
  -------------------------------------------------------------------------------
  Cursor cur_EMPLEADOS_count
	(
		 pvId_Docu      IN EMPLEADOS.ID_EMPLEADO%TYPE
	)
	Is

  Select
    Count(1)
  From
    EMPLEADOS
  Where
    ID_EMPLEADO = pvId_Docu;

  -----------------------------------------------------------------------------
  -- Fun4SD_Exist FUNCION PARA DETERMINAR QUE EL ID_EMPLEADO EXISTA
  -----------------------------------------------------------------------------
  Function Fun4SD_Exist
	(
		pvId_Docu   IN    EMPLEADOS.ID_EMPLEADO%TYPE
	)
	RETURN BOOLEAN
	IS

	Cuantos number:=0;

	/*Un bloque an�nimo PL/SQL*/
	BEGIN
	 OPEN cur_EMPLEADOS_count
		(
		 	pvId_Docu
		);
		FETCH cur_EMPLEADOS_count INTO Cuantos;
     CLOSE cur_EMPLEADOS_count;

	 IF ( Cuantos = 0 ) THEN
        RETURN (FALSE);
     END IF;
		RETURN (TRUE);
	END Fun4SD_Exist;

  -------------------------------------------------------------------------------
  --  Fun4SD_GetRecord FUNCION PARA OBTENER UN CURSOR CON SUS DATOS
  -------------------------------------------------------------------------------
  Function Fun4SD_GetRecord
	(
		pvId_Docu   IN    EMPLEADOS.ID_EMPLEADO%TYPE
	)
 RETURN type_cursor IS

  /*VARIABLE CURSOR*/
  cur4SDCed type_cursor;

	Begin

   Open cur4SDCed For
       Select
        *
       From
        EMPLEADOS
       Where
        ID_EMPLEADO = pvId_Docu;

    Return cur4SDCed;

	End Fun4SD_GetRecord;

End PKG4SD_UT_EMPLEADOS;