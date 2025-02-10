# Teltonika GPS/NMEA Logging

Script to track your Teltonika device (NMEA) within your private Nextcloud (using the Phonetrack app).  
This script **survives firmware updates** and requires **no manual terminal interaction**.

## Installation

Place this script in **Custom Scripts** within the Teltonika GUI (`/etc/rc.local`).

## Tested Devices

| Device  | Firmware Version          |
|---------|---------------------------|
| RUTX50  | RUTX_R_00.07.06.3         |
| RUTX11  | RUTX_R_00.07.12           |

## Changelog

- **Added iteration over multiple interfaces** (multi-WAN setup support).

## Credits

Based on [G4Cab/TeltonikaNMEAlogger](https://github.com/G4Cab/TeltonikaNMEAlogger).

