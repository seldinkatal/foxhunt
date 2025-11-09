--^(?i:ih|info here)$

sendGMCP("Char.Items.Room")
enableTrigger("Info Here Capture")
send(matches[1])