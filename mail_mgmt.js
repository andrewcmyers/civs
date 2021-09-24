var reactivate_msg = "Submit reactivation",
    deactivate_msg = "Submit deactivation"

function validateEmail(str) { // element to be validated
  var str = str.trim(),
      email = /^[^@]+@[^@.]+\.[^@]*\w\w$/
  return email.test(str)
}

var sendcode = document.getElementById("sendcode"),
    mail_address_input = document.getElementById("mail_address"),
    deactivation_code = document.getElementById("deactivation_code"),
    deactivate = document.getElementById("deactivate"),
    filter_question = document.getElementById("filter_question"),
    response_area = document.getElementById("response_area")

mail_address_input.addEventListener("change", () => {
    var mail_address = mail_address_input.value
    post_to_url("request_deactivation@PERLEXT@", { address: mail_address, check: true },
        deactivated => {
            // response_area.innerHTML += "check: " + deactivated + "<br>"
            deactivate.value = (deactivated == 1) ? reactivate_msg : deactivate_msg
        },
        () => {})
})

sendcode.addEventListener("click", () => {
  var mail_address = mail_address_input.value
  if (validateEmail(mail_address)) {
    post_to_url("request_deactivation@PERLEXT@", { address: mail_address },
      (msg) => {
        if (msg == "OK") {
            popup("addr_popup", "Code requested. Check your email.")
        } else {
            popup("addr_popup", "Code requested but something went wrong.")
            response_area.innerHTML = msg
        }
      },
      (e) => popup("addr_popup", "Error requesting code: " + e),
    )
  } else {
    popup("addr_popup", "bad e-mail address")
  }
});

deactivate.addEventListener("click", () => {
    var mail_address = mail_address_input.value
    popup("submit_popup", "requested")
    post_to_url("request_deactivation@PERLEXT@",
        {
            address: mail_address,
            code: deactivation_code.value,
            filter_pattern: filter_pattern.value
        },
      t => {
          if (t.match(/^deactivated .*/)) {
              let msg = t.split(" ");
              msg.shift()
              response_area.innerHTML = "<hr><p>" + msg.join(" ") + "</p>"
              deactivate.value = reactivate_msg
              sendcode.disabled = true
          } else if (t.match("^(activated|already) .*")) {
              let msg = t.split(" ");
              msg.shift()
              response_area.innerHTML = "<hr><p>" + msg.join(" ") + "</p>"
              deactivate.value = deactivate_msg
              sendcode.disabled = false
          } else {
              response_area.innerHTML = "<hr>" + t
          }
      },
      t => {
          popup("submit_popup", "Error:" + t)
          response_area.innerHTML = t
      }
    )
})
   
deactivation_code.addEventListener("input", (e) => {
  var v = deactivation_code.value.trim()
  if (v.length != 16 || !/^[0-9a-f]+$/.test(v))  {
    deactivate.disabled = true
    filter_question.style.display = "none"
  } else {
    deactivate.disabled = false
    filter_question.style.display = "block"
  }
})
