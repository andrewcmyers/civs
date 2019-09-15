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
    response_area = document.getElementById("response_area")

mail_address_input.addEventListener("change", () =>
    post_to_url("request_deactivation@PERLEXT", { address: mail_address, check: true },
        deactivated => {
            deactivate.value = (deactivated == 1) ? reactivate_msg : deactivate_msg
        },
        () => {}))

sendcode.addEventListener("click", () => {
  var mail_address = mail_address_input.value
  if (validateEmail(mail_address)) {
    post_to_url("request_deactivation@PERLEXT@", { address: mail_address },
      () => popup("addr_popup", "Code requested. Check your email."),
      () => popup("addr_popup", "Error requesting code."),
    )
  } else {
    popup("addr_popup", "bad e-mail address")
  }
});

deactivate.addEventListener("click", () => {
    var mail_address = mail_address_input.value
    post_to_url("request_deactivation@PERLEXT@", { address: mail_address, code: deactivation_code.value },
      t => {
          popup("submit_popup", "requested")
          if (t == "deactivated") {
              response_area.innerHTML =
                  "<hr><p>CIVS will not send any more mail to this address. " +
                  "You can reactivate mails from CIVS only by using this web page " +
                  "with the same code you just used.</p>"
              deactivate.value = reactivate_msg
              sendcode.disabled = true
          } else if (t == "activated") {
              response_area.innerHTML =
                  "<hr><p>You have successfully reactivated mail to this address.</p>"
              deactivate.value = deactivate_msg
              sendcode.disabled = false
          } else {
              response_area.innerHTML = "<hr>" + t
          }
      },
      t => {
          popup("submit_popup", "Error:")
          response_area.innerHTML = t
      }
    )
})
   
deactivation_code.addEventListener("input", (e) => {
  var v = deactivation_code.value.trim()
  deactivate.disabled = (v.length != 16 || !/^[0-9a-f]+$/.test(v)) 
})
