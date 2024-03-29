function $(x) { return document.getElementById(x) }
var mail_address_input = $("mail_address"),
    response_area = $("response_area"),
    request_code = $('request_code'),
    code_area = $('code_area'),
    submit_code = $('submit_code'),
    activation_code = $('activation_code')

function validateEmail(str) { // element to be validated
  var str = str.trim(),
      email = /^[^@]+@[^@.]+\.[^@]*\w\w$/
  return email.test(str)
}

function display_code_area() {
    code_area.style.display = 'block'
}

function check_code_validity() {
  var v = activation_code.value.trim()
  if (v.length != 16 || !/^[0-9a-f]+$/.test(v))  {
    submit_code.disabled = true
  } else {
    submit_code.disabled = false
  }
}

request_code.addEventListener("click", () => {
  var mail_address = mail_address_input.value
  if (validateEmail(mail_address)) {
    post_to_url("request_activation@PERLEXT@", { address: mail_address },
      (msg) => {
        if (msg.slice(0, 2) == "OK") {
            popup("addr_popup", CODE_REQUESTED)
            if (msg.slice(3)) response_area.innerHTML = "<hr>" + msg.slice(3)
            display_code_area()
            check_code_validity()
        } else {
            popup("addr_popup", CODE_REQUESTED_BUT_SOMETHING_WRONG)
            response_area.innerHTML = "<hr>" + msg
        }
      },
      (e) => {
        popup("addr_popup", ERROR_HANDLING_CODE_REQUEST)
        response_area.innerHTML += "<code>" + e + '</code><br>'
      }
    )
  } else {
    popup("addr_popup", INVALID_EMAIL_ADDRESS)
  }
});

submit_code.addEventListener("click", () => {
    var mail_address = mail_address_input.value
    popup("submit_popup", SUBMITTED)
    post_to_url("request_activation@PERLEXT@",
        {
            address: mail_address,
            code: activation_code.value,
        },
      t => {
          if (t.match("^activated .*")) {
              let msg = t.split(" ");
              msg.shift()
              response_area.innerHTML = "<hr><p>" + msg.join(" ") + "</p>"
          } else if (t.match("^already .*") || t.match("^failed .*")) {
              let msg = t.split(" ");
              msg.shift()
              response_area.innerHTML = "<hr><p>" + msg.join(" ") + "</p>"
          } else {
              response_area.innerHTML = "<hr><p>" + UNEXPECTED_ERROR + t + "</p>"
          }
      },
      t => {
          popup("submit_popup", OPT_IN_ERROR + t)
          response_area.innerHTML = "<hr>" + t
      }
    )
})

activation_code.addEventListener("input", (e) => check_code_validity())
