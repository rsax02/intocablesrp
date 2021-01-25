Locales['en'] = {
    ['document_deleted'] = "El documento fue ~g~eliminado~w~.",
    ['document_delete_failed'] = "Eliminación de documento ~r~fallida~w~.",
    ['copy_from_player'] = "Acabas de ~g~recibir~w~ una copia de un documento.",
    ['from_copied_player'] = "Documento ~g~copiado~w~ al jugador",
    ['could_not_copy_form_player'] = "Could ~r~not~w~ copy form to player.",
    ['document_options'] = "Opciones de documentos",
    ['public_documents'] = "Documentos publicos",
    ['job_documents'] = "Documentos de trabajo",
    ['saved_documents'] = "Documentos guardados",
    ['close_bt'] = "Cerrar",
    ['no_player_found'] = "No se encontraron jugadores",
    ['go_back'] = "Regresar",
    ['view_bt'] = "Ver",
    ['show_bt'] = "Mostrar",
    ['give_copy'] = "Dar copia",
    ['delete_bt'] = "Borrar",
    ['yes_delete'] = "Si, borrar",
}

Config.Documents['en'] = {
      ["public"] = {
        {
          headerTitle = "DECLARACIÓN DE TRANSPORTE DE VEHÍCULO",
          headerSubtitle = "Declaración de transporte de vehículo a otro ciudadano",
          elements = {
            { label = "NÚMERO DE PLACA", type = "input", value = "", can_be_emtpy = false },
            { label = "NOMBRE DEL COMPRADOR", type = "input", value = "", can_be_emtpy = false },
            { label = "PRECIO ACORDADO", type = "input", value = "", can_be_empty = false },
            { label = "OTRA INFORMACIÓN", type = "textarea", value = "", can_be_emtpy = true },
          }
        }
      },
      ["police"] = {
        {
          headerTitle = "PERMISO DE ARMAS",
          headerSubtitle = "Permiso especial de armas aprobado por la Policía",
          elements = {
            { label = "NOMBRE", type = "input", value = "", can_be_emtpy = false },
            { label = "APELLIDO", type = "input", value = "", can_be_emtpy = false },
            { label = "VALIDEZ", type = "input", value = "", can_be_empty = false },
            { label = "INFORMACIÓN", type = "textarea", value = "AL CIUDADANO SE LE PERMITE Y SE LE OTORGA UN PERMISO DE ARMAS QUE SERÁ VÁLIDO HASTA LA FECHA DE VENCIMIENTO ANTERIORMENTE MENCIONADA.", can_be_emtpy = false },
          }
        },
        {
          headerTitle = "CONSTANCIA DE ANTECEDENTES",
          headerSubtitle = "Constancia oficial de antecedentes del ciudadano, otorgado por la Policía",
          elements = {
            { label = "NOMBRE", type = "input", value = "", can_be_emtpy = false },
            { label = "APELLIDO", type = "input", value = "", can_be_emtpy = false },
            { label = "VALIDEZ", type = "input", value = "", can_be_empty = false },
            { label = "REGISTRO", type = "textarea", value = "POR LA PRESENTE LA POLICÍA DECLARA QUE EL CIUDADANO MENCIONADO ANTERIORMENTE TIENE UN EXPEDIENTE CRIMINAL CLARO. ESTE RESULTADO SE GENERA A PARTIR DE LOS DATOS ENVIADOS AL SISTEMA DE REGISTRO PENAL EN LA FECHA DE FIRMA DEL DOCUMENTO.", can_be_emtpy = false, can_be_edited = false },
          }         }
      },
      ["ambulance"] = {
        {
          headerTitle = "SEGURO MÉDICO",
          headerSubtitle = "Reporte médico oficial aprobado por un Doctor",
          elements = {
            { label = "NOMBRE", type = "input", value = "", can_be_emtpy = false },
            { label = "APELLIDO", type = "input", value = "", can_be_emtpy = false },
            { label = "VALIDEZ", type = "input", value = "", can_be_empty = false },
            { label = "NOTAS", type = "textarea", value = "Este documento certifica que (Nombre del paciente) cuenta con seguro medico el cual cubre todo tipo de costos de atención medica y vendajes en caso de reanimación que son 2 de cortesía. No cubre vendajes sin reanimación, ni la distancia recorrida para dar la asistencia médica.", can_be_emtpy = false },
          }
        },
        {
          headerTitle = "REPORTE PSICOLÓGICO",
          headerSubtitle = "Reporte psicológico oficial aprobado por un Doctor",
          elements = {
            { label = "NOMBRE", type = "input", value = "", can_be_emtpy = false },
            { label = "APELLIDO", type = "input", value = "", can_be_emtpy = false },
            { label = "VALIDEZ", type = "input", value = "", can_be_empty = false },
            { label = "NOTAS", type = "textarea", value = "Este documento certifica que (Nombre del paciente) pasó satisfactoriamente la prueba psicológica que indica que se encuentra estable emocionalmente y mentalmente para el uso responsable de armas.", can_be_emtpy = false },
          }
        },
        {
          headerTitle = "PERMISOS DE CONSUMO",
          headerSubtitle = "Permiso médico oficial de consumo aprobado por un Doctor",
          elements = {
            { label = "NOMBRE", type = "input", value = "", can_be_emtpy = false },
            { label = "APELLIDO", type = "input", value = "", can_be_emtpy = false },
            { label = "VALIDEZ", type = "input", value = "", can_be_empty = false },
            { label = "NOTAS", type = "textarea", value = "Este documento certifica que (Nombre del paciente) pasó satisfactoriamente la prueba de sangre que indica que no contiene ningún tipo de droga, se le otorga el permiso de estupefacientes debido a motivos de salud no divulgados. La cantidad legal y permitida que puede poseer el ciudadano es de (--g).", can_be_emtpy = false, can_be_edited = false },
          }
        }
      },
      ["mechanic"] = {
        {
            headerTitle = "SEGURO VEHICULAR",
            headerSubtitle = "Seguro vehícular oficial aprobado por un Mecánico",
            elements = {
              { label = "NOMBRE", type = "input", value = "", can_be_emtpy = false },
              { label = "APELLIDO", type = "input", value = "", can_be_emtpy = false },
              { label = "VALIDEZ", type = "input", value = "", can_be_empty = false },
              { label = "NOTAS", type = "textarea", value = "ESTE DOCUMENTO CUBRE TODO TIPO DE REPARACIONES A LOS VEHICULOS DEL ASEGURADO", can_be_emtpy = false },
            }
        }     
      }
}
