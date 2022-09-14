bool isNumeric(String? s) {
  bool response;
  try {
    double numero = double.parse(s == null ? "" : s);
    response = true;
  } catch (e) {
    response = false;
  }
  return response;
}

validateSimpleInputString(String? value) {
  dynamic response = "";
  switch (value) {
    case null:
      {
        response = "Complete la casilla";
      }
      break;
    case "":
      {
        response = "Complete la casilla";
      }
      break;
    default:
      {
        response = null;
      }
      break;
  }
  return response;
}

validateSimpleInputNumber(String? value) {
  dynamic response = "";
  if (isNumeric(value)) {
    response = null;
  } else {
    response = "El campo es numerico";
  }
  return response;
}

validateDNIInput(String? value) {
  dynamic response = "";
  if (isNumeric(value)) {
    if (value?.length != 8) {
      response = "El DNI consta de 8 caracteres";
    } else {
      response = null;
    }
  } else {
    response = "El campo es DNI es numerico";
  }
  return response;
}

validateEmailInput(String? value) {
  dynamic response = "";
  bool emailValid = RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(value == null ? "" : value);
  if (emailValid) {
    response = null;
  } else {
    response = "El correo no es correcto";
  }
  return response;
}

validateCompleteDateTimeInput(DateTime? value) {
  return value == null ? "El campo debe de ser completado" : null;
}

convertMapToQuery(Map data) {
  String response = "";
  data.entries
      .forEach((e) => response = response + e.key + "=" + e.value + "&");
  return response.substring(0, response.length - 1);
}
