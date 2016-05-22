Scripts to set up a raspberry pi for our usage case.

There are currently two setup scripts: `Setup.sh` and `SimpleSetup.sh`. SimpleSetup.sh is much easier to manage. Just give it any number within range, and it will run Setup.sh with all the required arguments as read below. If you give it anything as an additional input, it will run Setup.sh in 'test mode'.

Current usage for SimpleSetup.sh:

``` sudo ./SimpleSetup.sh NUM

or, for test mode, as described below:

``` sudo ./SimpleSetup.sh NUM S

where s is any input.


Current usage for Setup.sh:

``` sudo ./Setup.sh SUFF PASS NUM

where:
* SUFF is an SSID suffix
* PASS is an alphanumeric string between 8 and 64 characters
* NUM is a number between 1 and 255

Running the above, and then rebooting, should give you a wireless access point with an ssid like `riot-waikato-SUFF`, a WPA2 key management using `PASS`, and a an ip range like `172.24.NUM.50 - 172.24.NUM-150` for clients to connect to.

Adding a fourth argument to the script will cause it to output all of the relevant information about how the device will be configured without actually making any changes, a so called 'test-mode'. An example of this usage is `050 mysecurepassword 50 test`.

