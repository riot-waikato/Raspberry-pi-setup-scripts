Scripts to set up a raspberry pi for our usage case.

Current usage:
```sudo ./Setup.sh SUFF PASS NUM
where:
* SUFF is an SSID suffix
* PASS is an alphanumeric string between 8 and 64 characters
* NUM is a number between 1 and 255

Running the above, and then rebooting, should give you a wireless access point with an ssid like `riot-waikato-SUFF`, a WPA2 key management using `PASS`, and a an ip range like `172.24.NUM.50 - 172.24.NUM-150` for clients to connect to.