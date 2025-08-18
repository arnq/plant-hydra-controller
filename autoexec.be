# this file on the device so it runs at boot
import json

# --- CONFIG ---
const RELAY_INDEX = 0         # Relay1 = 0, Relay2 = 1, ...
const ANALOG_NAME = "A0"      
const THRESHOLD   = 380       
const SAMPLE_MS   = 15*60*1000
const PUMP_ON_MS  = 2000

def read_moisture()
  # read current sensor snapshot as JSON and pick ANALOG.A0
  var s = tasmota.read_sensors()
  var obj = json.load(s)
  if "ANALOG" in obj && ANALOG_NAME in obj["ANALOG"]
    return int(obj["ANALOG"][ANALOG_NAME])
  end
  return -1
end

def pump(on)
  tasmota.set_power(RELAY_INDEX, on)   # control the relay for pump
end

def water_for(ms)
  pump(true)
  tasmota.set_timer(ms, /-> pump(false))
end

def check_once()
  var v = read_moisture()
  if v >= 0
    print("Hydra: moisture=", v, " threshold=", THRESHOLD)
    if v < THRESHOLD
      print("Hydra: dry -> watering ", PUMP_ON_MS, "ms")
      water_for(PUMP_ON_MS)
    else
      pump(false)  # ensure pump is off
    end
  else
    print("Hydra: no analog reading found (ANALOG.", ANALOG_NAME, ")")
  end
  # schedule next run
  tasmota.set_timer(SAMPLE_MS, check_once)
end

# start a few seconds after boot
tasmota.set_timer(5000, check_once)