
run_segment() {
  # Path to `smc` binary
  smc="/Applications/smcFanControl.app/Contents/Resources/smc"

  # Sensor to use. List is available at:
  # https://github.com/hholtmann/smcFanControl/blob/master/smc-command/README#L74
  sensor=TCAD

  echo -n "∆ "

  $smc -k $sensor -r | \
  sed 's/.*bytes \(.*\))/\1/' | \
  sed 's/\([0-9a-fA-F]*\)/0x\1/g' | \
  perl -ne 'chomp; ($low,$high) = split(/ /); print "1k"; print (((hex($low)*256)+hex($high))/4/64); print " 1/n\n";' | \
  dc

  echo "°C"
}
