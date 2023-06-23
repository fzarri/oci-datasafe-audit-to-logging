### Send Data Safe DB Audit Events to OCI Logging

This little utility is designed to be called periodically in order to get DB Audit Events from DataSafe and send to OCI Logging. It is written as a serverless function using the [fn framework](https://fnproject.io/) to run in [OCI](https://cloud.oracle.com/). 

Uses:

* Data Safe Activity auditing
* OCI Logging Custom Log
* OCI Object Storage Bucket to manage lock and status (last DB audit event time colletected from Data Safe)
* Resource principal Authentication for OCI API invocations (Data Safe O, Logging)
* OCI Monitoring Alarm to call periodically OCI Function
* Internal Semaphor with lock file in OCI Object Storage to permit to schedule every minutes and to manage cuncurrency with fn function timeout = 5 min 

Required configuration:

* OCI Compartment for Data Safe
* LogGroup and Logs created in OCI Logging
* Dynamic Group which includes the running function
* Policies on the Dyanmic Group for list audit events in Data Safe, access to OCI Object Storage, and put logs in OCI Loggings
* Some sort of scheduler (I used OCI Monitoring Alarm and OCI Notification)


Navigating this repo:

Structure is a little monolithic... Main implementation is in func.py.
Perpetual TODO: Better test coverage...
