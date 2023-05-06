<html>
<body>
  <?php
  $input = $_POST["rawtls"];
  $found = false;
  $lines = explode("\n",$input);
  $pattern1 = "/private_key_pem:/";
  $pattern2 = "/-----BEGIN RSA PRIVATE KEY-----/";

  if (count($lines) > 1) {
    # If a user has copied the whole of the tls resource (as requested)
    foreach($lines as $line) {
      if (preg_match($pattern1,$line)) {
        $tmp1 = str_replace("private_key_pem: ","",$line);
        $tmp2 = str_replace("\\n","<br>",$tmp1);
        $tmp3 = str_replace("\"","",$tmp2);
        $output = $tmp3;
        $found = true;
      }
    }
  } else {
    # If a user has been clever and just copied the RSA Private Key they will end up here
    if (count($lines) === 1) {
      if (preg_match($pattern2,$input)) {
        $tmp1 = str_replace("\\n","<br>",$input);
        $tmp2 = str_replace("\"","",$tmp1);
        $output = $tmp2;
        $found = true;
      }
    }
  }


  if ($found === true) {
    echo "<tt>";
    echo $output;
    echo "</tt>";
  } else {
    echo "<b>ERROR</b>: you have not submitted the correct text.<p>";
    echo "To remedy this navigate back to the <a href=formatkey.html>format key page</a> and follow its instructions.";
  }

  ?>
</body>
</html>

