function setup() {}

// export table t as file f.
function export_table(f, t) {
  const data = table_to_string(t);
  const filename = f;
  const blob = new Blob([data], {type: 'text/csv'});
  if (window.navigator.msSaveOrOpenBlob) {
      window.navigator.msSaveBlob(blob, filename);
  } else {
      const elem = document.createElement('a');
      elem.href = window.URL.createObjectURL(blob);
      elem.download = filename
      document.body.appendChild(elem);
      elem.click();
      document.body.removeChild(elem);
  }
}

function table_to_string(t) {
  const rows = t.getElementsByTagName('tr');
  let output = "";
  for (var i = 0; i < rows.length; i++) {
      const r = rows[i];
      let cols = r.getElementsByTagName('td');
      if (cols.length == 0)
          cols = r.getElementsByTagName('th');
      for (let j = 0; j < cols.length; j++) {
          if (j != 0) output += ",";
          var td = cols[j];
          output += td.innerHTML;
      }
      output += "\n";
  }
  return output;
}

function export_failure_table() {
    const t = document.getElementById('failure_table');
    export_table("mail_failure_table.csv", t);
}
